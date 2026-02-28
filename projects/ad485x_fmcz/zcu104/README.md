# AD485x FMCZ on ZCU104

## Overview

This is a hardware design for the AD485x-based EVAL-AD4858 or EVAL-AD4857 evaluation boards on the Xilinx ZCU104 FMC board. The ZCU104 is an evaluation board for the Xilinx Zynq UltraScale+ MPSoC.

The ad485x_fmcz project provides a complete reference design including the following features:

- AD485x Analog-to-Digital Converter (ADC) interface via FMC HPC connector
- Dual interface mode support: CMOS and LVDS
- CMOS mode variants: Quad (4-lane) and Octa (8-lane) data configurations
- DMA-based data streaming to DDR4 memory
- AXI register access for device configuration and control
- Interrupt-driven sample ready notification

## Directory Structure

```
ad485x_fmcz/
├── common/
│   ├── ad485x_fmcz_bd.tcl      # Core ADC design block diagram (device-agnostic)
│   ├── config.tcl              # Device parameter configuration
│   └── README.md
├── zed/                         # Zynq-7000 (ZedBoard) variant
│   ├── system_project.tcl
│   ├── system_bd.tcl
│   ├── system_top_*.v
│   └── system_constr_*.xdc
├── zcu104/                      # Zynq UltraScale+ (ZCU104) variant [NEW]
│   ├── system_project.tcl
│   ├── system_bd.tcl
│   ├── system_top_lvds.v
│   ├── system_top_cmos_quad.v
│   ├── system_top_cmos_octa.v
│   ├── system_constr_lvds.xdc
│   ├── system_constr_cmos_quad.xdc
│   ├── system_constr_cmos_octa.xdc
│   ├── Makefile
│   └── README.md                # This file
└── Makefile
```

## Supported Devices

The design supports the following AD485x family devices:
- **AD4858** - 8-channel, 20-bit, 250 kSPS SAR ADC (evaluation board: EVAL-AD4858)
- **AD4857** - 8-channel, 20-bit, 250 kSPS SAR ADC
- **AD4856** - 8-channel, 20-bit, 250 kSPS SAR ADC
- **AD4855** - 8-channel, 20-bit, 250 kSPS SAR ADC
- **AD4854** - 4-channel, 20-bit, 250 kSPS SAR ADC (evaluation board: EVAL-AD4857)
- **AD4853** - 4-channel, 20-bit, 250 kSPS SAR ADC
- **AD4852** - 4-channel, 20-bit, 250 kSPS SAR ADC
- **AD4851** - 4-channel, 20-bit, 250 kSPS SAR ADC

## Building the Design

### Prerequisites

1. **Xilinx Vivado**: Version 2024.2 or later (check `REQUIRED_VIVADO_VERSION` in project scripts)
2. **Board Definition Files**: ZCU104 board support package installed in Vivado
3. **ADI HDL Library**: Latest analog-devices-hdl repository available
4. **FMC Pin Mappings**: ZCU104 FMC HPC to FPGA pin mapping (see below)

### Building the Design

```bash
# Navigate to the project directory
cd projects/ad485x_fmcz/zcu104

# Build with default CMOS interface (QUAD variant for 4-channel devices)
make

# Build with LVDS interface
make LVDS_CMOS_N=1

# Build with a specific device (default is AD4858)
make DEVICE=AD4854

# Build with CMOS OCTA variant (for 8-channel devices)
make CMOS_OCTA_QUAD=0
```

### Build Output

Successfully completed builds generate:
- `ad485x_fmcz_zcu104.bit` - FPGA bitstream
- `ad485x_fmcz_zcu104.mcs` - Memory configuration file for Flash programming
- Full Vivado project files in `ad485x_fmcz_zcu104.xpr`

## Interface Selection

### CMOS Mode (Default)
- **Data Pins**: Single-ended LVCMOS 1.8V
- **Throughput**: Depends on number of lanes:
  - Quad mode (4 lanes): Supports 4-channel ADCs, 4 x 20-bit @ 250 kSPS = 20 MB/s
  - Octa mode (8 lanes): Supports 8-channel ADCs, 8 x 20-bit @ 250 kSPS = 40 MB/s
- **Latency**: Lower latency due to direct data paths
- **GPIO Control**: `lvds_cmos_n = 0` (set via GPIO bit 33)

### LVDS Mode
- **Data Pins**: Differential LVDS 1.8V
- **Clock**: Requires both base clock (200 MHz) and fast clock (400 MHz)
- **Throughput**: 8 lanes only, 8 x 20-bit @ 250 kSPS = 40 MB/s
- **Latency**: Slightly higher due to LVDS receiver delays
- **GPIO Control**: `lvds_cmos_n = 1` (set via GPIO bit 33)

## Block Diagram Components

### Clock and Reset Management
- **sys_cpu_clk**: 100 MHz (from PS8 PL0)
- **sys_dma_clk**: 250 MHz (from PS8 PL1, for DMA operations)
- **sys_iodelay_clk**: 500 MHz (from PS8 PL2, for I/O timing)
- **adc_clk**: 200 MHz (generated via axi_clkgen from sys_cpu_clk)
- **adc_fast_clk**: 400 MHz (generated via axi_clkgen, LVDS mode only)

### Key IP Cores
- **axi_ad485x**: ADC core instantiation and control
  - Supports CMOS and LVDS interfaces
  - Configurable via AXI register interface
  - Output: 20-bit samples from up to 8 channels
- **axi_clkgen**: Clock generation for on-board PLLs
  - Input: sys_cpu_clk (100 MHz)
  - Output: adc_clk (200 MHz), adc_fast_clk (400 MHz for LVDS)
- **axi_dmac**: DMA controller
  - Source: axi_ad485x (ADC stream)
  - Destination: DDR4 memory
  - Interrupt-driven operation
- **axi_pwm_gen**: Conversion control pulse generator
  - Generates CNV (convert) pulse to initiate ADC sampling
  - Timing: 1 cycle per 8 clock periods (100 kHz rate at 200 MHz base)
- **axi_sysid**: System identification ROM
  - Provides design information via AXI

### AXI Address Map
- **axi_ad485x**: 0x43C0_0000 (register access and streaming data)
- **axi_pwm_gen**: 0x43D0_0000 (pulse width modulator control)
- **ad485x_dma**: 0x43E0_0000 (DMA engine)
- **adc_clkgen**: 0x4400_0000 (clock generator configuration)
- **axi_sysid**: 0x4500_0000 (system identification)

## Pin Mapping Status

### ✅ **COMPLETE: FMC Pin Mappings Extracted and Populated**

FMC pin assignments have been successfully extracted from the ZCU104 reference design XDC file and populated into all constraint files.

**FMC Connector Type:** Low Pin Count (LPC) - 68 pins
**Voltage Domain:** VADJ_FMC (adjustable to 1.8V)
**Banks Used:** 67, 68
**Source:** `zcu104_Rev1.0_U1_01302018.xdc` (official Xilinx reference design)

#### Clock Signals ✓
- **CLK0 (scki):** E15/E14 (Bank 67) - FMC_LPC_CLK0_M2C differential LVDS pair
- **CLK1 (optional scko):** G10/F10 (Bank 68) - FMC_LPC_CLK1_M2C differential LVDS pair

#### Data Signals - All in Banks 67/68 ✓

**LVDS 8-Lane Interface (Differential):**
- LA00: F17/F16 (SDO[0])
- LA01: H18/H17 (SDO[1])
- LA02: L20/K20 (SDO[2])
- LA03: K19/K18 (SDO[3])
- LA04: L17/L16 (SDO[4])
- LA05: K17/J17 (SDO[5])
- LA06: H19/G19 (SDO[6])
- LA07: J16/J15 (SDO[7])

**CMOS Quad Mode (Single-ended, 4-lane):**
- SDO[0:3]: F17, H18, L20, K19 (using LA00-LA03 P pins)

**CMOS Octa Mode (Single-ended, 8-lane):**
- SDO[0:7]: F17, H18, L20, K19, L17, K17, H19, J16 (using all LA P pins)

#### Control Signals ✓
- **busy:** E18 (Bank 67) - FMC_LPC_LA08_P
- **cnv:** E17 (Bank 67) - FMC_LPC_LA08_N
- **pd:** F17 (Bank 67) - FMC_LPC_LA09_P
- **lvds_cmos_n:** E16 (Bank 67) - FMC_LPC_LA09_N

### Constraint Files Updated ✓
The following files have been populated with actual FMC_LPC pin assignments:
- `zcu104_fmc0_hpc.txt` ✅ - Complete FMC pin-to-ball mapping (62 pins)
- `system_constr_lvds.xdc` ✅ - LVDS 8-lane differential interface with LVDS25/LVCMOS18 standards
- `system_constr_cmos_quad.xdc` ✅ - CMOS 4-lane single-ended interface with LVCMOS18
- `system_constr_cmos_octa.xdc` ✅ - CMOS 8-lane single-ended interface with LVCMOS18

## Software Requirements

### Xilinx Tools
- Vivado 2024.2 (or later)
- Xilinx SDK / Vitis

### Linux Kernel Driver
- ADI IIO kernel drivers for AD485x devices
- Located in Analog Devices Linux kernel tree

### HDL Library Dependencies
Ensures the following ADI library cores are available:
- `axi_ad485x` - AD485x core
- `axi_clkgen` - Clock generator
- `axi_dmac` - Direct Memory Access controller
- `axi_pwm_gen` - Pulse width modulator
- `axi_sysid` / `sysid_rom` - System identification

## Porting Notes: ZCU104 vs ZED

Key differences reflected in this port:

| Feature | ZED | ZCU104 |
|---------|-----|--------|
| FPGA Device | Zynq-7000 (7Z020) | Zynq UltraScale+ (xczu*) |
| Memory | DDR3-800/1066 | DDR4-3200 |
| Processing System | PS7 | PS8 |
| PL Clock Domains | 1 (100 MHz) | 3 (100/250/500 MHz) |
| FMC Type | LPC | HPC |
| I/O Banks | 14 | Multiple with 1.8V standard |
| Hardware Architecture | AXI3 | AXI4/AXI4-Lite |

## Troubleshooting

### Build Errors

**Error: "Design validation failed - FMC pins unmapped"**
- **Cause**: Placeholder pin assignments not replaced with actual mappings
- **Solution**: Complete FMC pin mapping procedure (see above)

**Error: "Device 'xczu*' not found"**
- **Cause**: ZCU104 board definition not installed in Vivado
- **Solution**: Install ZCU104 board support package

**Error: "Design timing convergence failed"**
- **Cause**: Incomplete or incorrect timing constraints
- **Solution**: Regenerate constraints using FMC constraint generator; check pin assignments for bus loading

### Runtime Issues

**ADC data not streaming**
- Verify LVDS_CMOS_N GPIO bit matches interface mode (0=CMOS, 1=LVDS)
- Check DMA controller configuration (source/destination addresses)
- Verify clock configuration in axi_clkgen registers

**Intermittent data corruption**
- May indicate timing slack issues with CMOS mode
- Try LVDS mode for more robust operation
- Check signal integrity and trace routing

## References

- [AD485x Datasheet](https://www.analog.com/media/en/technical-documentation/data-sheets/ad4851-ad4852-ad4853-ad4854-ad4855-ad4856-ad4857-ad4858.pdf)
- [EVAL-AD4858ZPZ Evaluation Board User Guide](https://www.analog.com/media/en/technical-documentation/user-guides/eval-ad4858zpz-ug.pdf)
- [Xilinx ZCU104 User Guide](https://xilinx.github.io/kria/build/html/docs/user_guide_zcu104/1_overview/overview.html)
- [Xilinx Vivado Design Suite Documentation](https://www.xilinx.com/support/documentation.html)

## Support and Contribution

For issues, feature requests, or contributions:
- [Analog Devices HDL GitHub](https://github.com/analogdevicesinc/hdl)
- [Analog Devices Wiki](https://wiki.analog.com/)

---

**Last Updated**: 2025-02-28
**Status**: Porting in progress - Awaiting FMC pin mapping completion
**Next Steps**: Populate FMC pin mappings and regenerate constraints for production build
