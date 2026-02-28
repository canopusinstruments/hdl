###############################################################################
## Copyright (C) 2023-2025 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# AD485x
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS18}                          [get_ports lvds_cmos_n]  ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS18}                          [get_ports pd]           ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS18}                          [get_ports cnv]          ; ##  Bank  67 VCCO - VADJ_FMC
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS18}                          [get_ports busy]         ; ##  Bank  67 VCCO - VADJ_FMC

# SPI
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS18}                          [get_ports csck]         ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA09_P)
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS18}                          [get_ports csdio]        ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA13_P)
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS18}                          [get_ports cs_n]         ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA13_N)
set_property -dict {PACKAGE_PIN B8 IOSTANDARD LVCMOS18}                           [get_ports csd0]         ; ##  Bank  68 VCCO - VADJ_FMC (FMC_LPC_LA26_N)

# LVDS
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVDS_25}                           [get_ports scki_p]       ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_CLK0_M2C_P)
set_property -dict {PACKAGE_PIN E14 IOSTANDARD LVDS_25}                           [get_ports scki_n]       ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_CLK0_M2C_N)
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_p[0]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA00_CC_P)
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_n[0]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA00_CC_N)
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_p[1]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA01_CC_P)
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_n[1]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA01_CC_N)
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_p[2]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA02_P)
set_property -dict {PACKAGE_PIN K20 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_n[2]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA02_N)
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_p[3]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA03_P)
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_n[3]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA03_N)
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_p[4]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA04_P)
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_n[4]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA04_N)
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_p[5]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA05_P)
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_n[5]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA05_N)
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_p[6]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA06_P)
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_n[6]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA06_N)
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_p[7]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA07_P)
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports sdo_n[7]]     ; ##  Bank  67 VCCO - VADJ_FMC (FMC_LPC_LA07_N)
set_property -dict {PACKAGE_PIN G10 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports scko_p]       ; ##  Bank  68 VCCO - VADJ_FMC (FMC_LPC_CLK1_M2C_P)
set_property -dict {PACKAGE_PIN F10 IOSTANDARD LVDS_25 DIFF_TERM TRUE}            [get_ports scko_n]       ; ##  Bank  68 VCCO - VADJ_FMC (FMC_LPC_CLK1_M2C_N)

create_clock -period 2.5 -name scko [get_ports scko_p]
set_false_path -from [get_clocks scko] -to [get_clocks -of_objects [get_pins i_system_wrapper/system_i/adc_clkgen/inst/i_mmcm_drp/i_mmcm/CLKOUT0]]
