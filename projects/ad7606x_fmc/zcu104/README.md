<!-- no_build_example, no_dts -->

# AD7606X-FMC/ZCU104 HDL Project

- VADJ with which it was tested in hardware: 1.8V

The parameters configurable through the `make` command, can be found below, as well as in the **system_project.tcl** file; it contains the default
configuration.

If other configurations are desired, then the parameters from the HDL project (see below) need to be changed, as well as the Linux/no-OS project configurations.

All of the configuration modes can be found in the chosen chips's data sheet. We offer support for only a few of them.

- INTF - Defines the operation interface
  - 0 - Parallel
  - 1 - Serial
- NUM_OF_SDI - Defines the number of SDI lines used: 1, 2, 4 or 8
- ADC_N_BITS - Specifies the ADC resolution: 16 or 18 bits (only for the Parallel Interface)

For the serial interface (INTF=1), the following parameters will be used in make command:
- INTF
- NUM_OF_SDI.

For the parallel interface (INTF=0), the following parameters will be used in make command:
- INTF
- ADC_N_BITS.

:warning: When switching between Serial and Parallel Interface,
make sure to replicate this move in hardware too by changing the hardware switch (JP5). Rebuild the design if the variable has been changed.

### Example configurations

This specific command is equivalent to running `make` only:

#### 16-bit parallel interface (default)

```
make INTF=0 ADC_N_BITS=16
```

#### 18-bit parallel interface

```
make INTF=0 ADC_N_BITS=18
```

#### Serial interface with 1 SDI line

```
make INTF=1 NUM_OF_SDI=1
```

#### Serial interface with 2 SDI lines

```
make INTF=1 NUM_OF_SDI=2
```

#### Serial interface with 4 SDI lines

```
make INTF=1 NUM_OF_SDI=4
```

#### Serial interface with 8 SDI lines

```
make INTF=1 NUM_OF_SDI=8
```

Corresponding no-OS project: [ad7606x-fmc](https://github.com/analogdevicesinc/no-OS/tree/main/projects/ad7606x-fmc)

## Building the HDL project

The design is built upon ADI's generic HDL reference design framework. ADI
distributes the bit/elf files of these projects as part of the [ADI Kuiper Linux](https://wiki.analog.com/resources/tools-software/linux-software/kuiper-linux). If you want to build the sources, ADI makes them available on the [HDL repository](https://github.com/analogdevicesinc/hdl/tree/main/).
To get the source you must [clone] the HDL repository, and then build the project as follows:.

Linux/Cygwin/WSL

```bash
cd hdl/projects/ad7606x_fmc/zcu104
make INTF=0 ADC_N_BITS=16
```

The result of the build, if parameters were used, will be in a folder named by
the configuration used:
if the following command was run

`make INTF=0 ADC_N_BITS=16`

then the folder name will be:

`INTF0_ADC_N_BITS16`

A more comprehensive build guide can be found in the [Build an HDL project](https://analogdevicesinc.github.io/hdl/user_guide/build_hdl.html#build-hdl) user guide.

## Hardware Changes

The ZCU104 evaluation board uses the FMC_LPC (Low Pin Count) connector for the AD7606X-FMCZ board. Ensure that VADJ is set to 1.8V for proper operation of the FMC connector signals.

### Jumper Configuration

For the parallel interface mode (INTF=0):
- JP5 - B - Parallel interface

For the serial interface mode (INTF=1):
- JP5 - A - Serial interface

Refer to the AD7606X-FMCZ board documentation and ZCU104 board documentation for proper jumper settings.

## Constraints and Pin Mapping

The constraint files (system_constr_pif.xdc, system_constr_spi_1/2/4/8.xdc) define the FMC_LPC connector pin mappings to the ZCU104 FPGA pins. These are based on the ZCU104 FMC_LPC connector specification and are compatible with the standard ANSI/VITA 57.1 FMC standard.

## Additional Resources

- [AD7606X-FMC HDL project documentation](https://analogdevicesinc.github.io/hdl/projects/ad7606x_fmc/index.html)
- [ADI HDL User guide](https://analogdevicesinc.github.io/hdl/user_guide/index.html)
- [ZCU104 Board Documentation](https://www.xilinx.com/products/boards-and-kits/zcu104.html)
