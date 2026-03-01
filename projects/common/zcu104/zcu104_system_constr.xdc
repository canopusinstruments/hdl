###############################################################################
## Copyright (C) 2016-2025 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# GPIO - LEDs (gpio_bd[3:0])

set_property  -dict {PACKAGE_PIN  D5    IOSTANDARD LVCMOS33} [get_ports gpio_bd[0]]       ; ## GPIO_LED_0_LS
set_property  -dict {PACKAGE_PIN  D6    IOSTANDARD LVCMOS33} [get_ports gpio_bd[1]]       ; ## GPIO_LED_1_LS
set_property  -dict {PACKAGE_PIN  A5    IOSTANDARD LVCMOS33} [get_ports gpio_bd[2]]       ; ## GPIO_LED_2_LS
set_property  -dict {PACKAGE_PIN  B5    IOSTANDARD LVCMOS33} [get_ports gpio_bd[3]]       ; ## GPIO_LED_3_LS

# GPIO - DIP Switches (gpio_bd[7:4])

set_property  -dict {PACKAGE_PIN  E4    IOSTANDARD LVCMOS33} [get_ports gpio_bd[4]]       ; ## GPIO_DIP_SW0
set_property  -dict {PACKAGE_PIN  D4    IOSTANDARD LVCMOS33} [get_ports gpio_bd[5]]       ; ## GPIO_DIP_SW1
set_property  -dict {PACKAGE_PIN  F5    IOSTANDARD LVCMOS33} [get_ports gpio_bd[6]]       ; ## GPIO_DIP_SW2
set_property  -dict {PACKAGE_PIN  F4    IOSTANDARD LVCMOS33} [get_ports gpio_bd[7]]       ; ## GPIO_DIP_SW3

# GPIO - Push Buttons (gpio_bd[11:8])

set_property  -dict {PACKAGE_PIN  B4    IOSTANDARD LVCMOS33} [get_ports gpio_bd[8]]       ; ## GPIO_PB_SW0
set_property  -dict {PACKAGE_PIN  C4    IOSTANDARD LVCMOS33} [get_ports gpio_bd[9]]       ; ## GPIO_PB_SW1
set_property  -dict {PACKAGE_PIN  B3    IOSTANDARD LVCMOS33} [get_ports gpio_bd[10]]      ; ## GPIO_PB_SW2
set_property  -dict {PACKAGE_PIN  C3    IOSTANDARD LVCMOS33} [get_ports gpio_bd[11]]      ; ## GPIO_PB_SW3

# GPIO - PMOD0 (gpio_bd[19:12])

set_property  -dict {PACKAGE_PIN  G8    IOSTANDARD LVCMOS33} [get_ports gpio_bd[12]]      ; ## PMOD0_0
set_property  -dict {PACKAGE_PIN  H8    IOSTANDARD LVCMOS33} [get_ports gpio_bd[13]]      ; ## PMOD0_1
set_property  -dict {PACKAGE_PIN  G7    IOSTANDARD LVCMOS33} [get_ports gpio_bd[14]]      ; ## PMOD0_2
set_property  -dict {PACKAGE_PIN  H7    IOSTANDARD LVCMOS33} [get_ports gpio_bd[15]]      ; ## PMOD0_3
set_property  -dict {PACKAGE_PIN  G6    IOSTANDARD LVCMOS33} [get_ports gpio_bd[16]]      ; ## PMOD0_4
set_property  -dict {PACKAGE_PIN  H6    IOSTANDARD LVCMOS33} [get_ports gpio_bd[17]]      ; ## PMOD0_5
set_property  -dict {PACKAGE_PIN  J6    IOSTANDARD LVCMOS33} [get_ports gpio_bd[18]]      ; ## PMOD0_6
set_property  -dict {PACKAGE_PIN  J7    IOSTANDARD LVCMOS33} [get_ports gpio_bd[19]]      ; ## PMOD0_7

# GPIO - PMOD1 (gpio_bd[27:20])

set_property  -dict {PACKAGE_PIN  J9    IOSTANDARD LVCMOS33} [get_ports gpio_bd[20]]      ; ## PMOD1_0
set_property  -dict {PACKAGE_PIN  K9    IOSTANDARD LVCMOS33} [get_ports gpio_bd[21]]      ; ## PMOD1_1
set_property  -dict {PACKAGE_PIN  K8    IOSTANDARD LVCMOS33} [get_ports gpio_bd[22]]      ; ## PMOD1_2
set_property  -dict {PACKAGE_PIN  L8    IOSTANDARD LVCMOS33} [get_ports gpio_bd[23]]      ; ## PMOD1_3
set_property  -dict {PACKAGE_PIN  L10   IOSTANDARD LVCMOS33} [get_ports gpio_bd[24]]      ; ## PMOD1_4
set_property  -dict {PACKAGE_PIN  M10   IOSTANDARD LVCMOS33} [get_ports gpio_bd[25]]      ; ## PMOD1_5
set_property  -dict {PACKAGE_PIN  M8    IOSTANDARD LVCMOS33} [get_ports gpio_bd[26]]      ; ## PMOD1_6
set_property  -dict {PACKAGE_PIN  M9    IOSTANDARD LVCMOS33} [get_ports gpio_bd[27]]      ; ## PMOD1_7

# Define SPI clock

create_clock -name spi0_clk      -period 40   [get_pins -hier */EMIOSPI0SCLKO]
create_clock -name spi1_clk      -period 40   [get_pins -hier */EMIOSPI1SCLKO]
