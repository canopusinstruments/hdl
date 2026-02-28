###############################################################################
## Copyright (C) 2024 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################
# AD4851, AD4852, AD4853, AD4854
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS18}                          [get_ports lvds_cmos_n]  ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS18}                          [get_ports pd]           ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS18}                          [get_ports cnv]          ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS18}                          [get_ports busy]         ; ##  Bank  67 VCCO - VADJ_FMC

# SPI
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS18}                          [get_ports csck]         ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA09_P)
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS18}                          [get_ports csdio]        ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA13_P)
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS18}                          [get_ports cs_n]         ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA13_N)
set_property -dict {PACKAGE_PIN B8 IOSTANDARD LVCMOS18}                           [get_ports csd0]         ; ##  Bank  68 VCCO - VADJ_FMC (FMC_LPC_LA26_N)

# CMOS
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS18}                          [get_ports scki]         ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_CLK0_M2C_P)
set_property -dict {PACKAGE_PIN G10 IOSTANDARD LVCMOS18} [get_ports scko]         ; ##  Bank  68 VCCO - VADJ_FMC (FMC_LPC_CLK1_M2C_P)
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS18} [get_ports sdo[0]]       ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS18} [get_ports sdo[1]]       ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS18} [get_ports sdo[2]]       ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS18} [get_ports sdo[3]]       ; ##  Bank  67 VCCO - VADJ_FMC

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {scko_IBUF}]

create_clock -name scko_cmos       -period  10 [get_ports scko]
set_max_delay -from [get_clocks scko_cmos] -to [get_clocks -of_objects [get_pins i_system_wrapper/system_i/adc_clkgen/inst/i_mmcm_drp/i_mmcm/CLKOUT0]] 10.0
set_min_delay -from [get_clocks scko_cmos] -to [get_clocks -of_objects [get_pins i_system_wrapper/system_i/adc_clkgen/inst/i_mmcm_drp/i_mmcm/CLKOUT0]] 1.0
