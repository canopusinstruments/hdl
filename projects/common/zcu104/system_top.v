// ***************************************************************************
// ***************************************************************************
// Copyright (C) 2025 Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/main/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  // ZCU104 DDR4 Interface
  inout       [16:0]      ddr4_addr,
  inout       [ 1:0]      ddr4_ba,
  inout                   ddr4_bg,
  inout                   ddr4_cke,
  inout                   ddr4_odt,
  inout                   ddr4_cs_n,
  inout                   ddr4_act_n,
  inout                   ddr4_ras_n,
  inout                   ddr4_cas_n,
  inout                   ddr4_we_n,
  inout                   ddr4_ck_p,
  inout                   ddr4_ck_n,
  inout       [ 7:0]      ddr4_dm_dbi_n,
  inout       [63:0]      ddr4_dq,
  inout       [ 7:0]      ddr4_dqs_c,
  inout       [ 7:0]      ddr4_dqs_t,
  inout                   ddr4_reset_n,

  // ZCU104 Fixed I/O - PS Miscellaneous
  inout                   fixed_io_mio_0,  // QSPI CS
  inout                   fixed_io_mio_1,  // QSPI CLK
  inout       [ 3:0]      fixed_io_mio_4_7, // QSPI DATA
  inout       [53:47]     fixed_io_mio_47_43, // Other MIO
  inout                   fixed_io_ps_clk,
  inout                   fixed_io_ps_porb,
  inout                   fixed_io_ps_srstb,
  inout       [ 1:0]      fixed_io_ddr_vrn,
  inout       [ 1:0]      fixed_io_ddr_vrp,

  // GPIO - expansion pins (if used)
  inout       [31:0]      gpio_bd

);

  // internal signals

  wire    [94:0]  gpio_i;
  wire    [94:0]  gpio_o;
  wire    [94:0]  gpio_t;

  wire            spi0_csn;
  wire            spi0_sclk;
  wire            spi0_mosi;
  wire            spi0_miso;

  wire            spi1_csn;
  wire            spi1_sclk;
  wire            spi1_mosi;
  wire            spi1_miso;

  // high-speed I/O interface

  wire    [63:0]  ddr4_dq_oe_n;
  wire            ddr4_dqs_t_oe_n;
  wire            ddr4_dqs_c_oe_n;

  wire    [16:0]  ddr4_addr_oe_n;
  wire    [ 1:0]  ddr4_ba_oe_n;
  wire            ddr4_bg_oe_n;
  wire            ddr4_cke_oe_n;
  wire            ddr4_odt_oe_n;
  wire            ddr4_cs_n_oe_n;
  wire            ddr4_act_n_oe_n;
  wire            ddr4_ras_n_oe_n;
  wire            ddr4_cas_n_oe_n;
  wire            ddr4_we_n_oe_n;
  wire            ddr4_ck_p_oe_n;
  wire            ddr4_ck_n_oe_n;

  // instantiations

  ad_iobuf #(
    .DATA_WIDTH(32)
  ) i_iobuf (
    .dio_t(gpio_t[31:0]),
    .dio_i(gpio_o[31:0]),
    .dio_o(gpio_i[31:0]),
    .dio_p(gpio_bd));

  system_wrapper i_system_wrapper (
    .ddr4_act_n(ddr4_act_n),
    .ddr4_addr(ddr4_addr),
    .ddr4_ba(ddr4_ba),
    .ddr4_bg(ddr4_bg),
    .ddr4_cas_n(ddr4_cas_n),
    .ddr4_ck_n(ddr4_ck_n),
    .ddr4_ck_p(ddr4_ck_p),
    .ddr4_cke(ddr4_cke),
    .ddr4_cs_n(ddr4_cs_n),
    .ddr4_dm_dbi_n(ddr4_dm_dbi_n),
    .ddr4_dq(ddr4_dq),
    .ddr4_dqs_c(ddr4_dqs_c),
    .ddr4_dqs_t(ddr4_dqs_t),
    .ddr4_odt(ddr4_odt),
    .ddr4_ras_n(ddr4_ras_n),
    .ddr4_reset_n(ddr4_reset_n),
    .ddr4_we_n(ddr4_we_n),
    .fixed_io_ddr_vrn(fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp(fixed_io_ddr_vrp),
    .fixed_io_mio_0(fixed_io_mio_0),
    .fixed_io_mio_1(fixed_io_mio_1),
    .fixed_io_mio_4_7(fixed_io_mio_4_7),
    .fixed_io_mio_47_43(fixed_io_mio_47_43),
    .fixed_io_ps_clk(fixed_io_ps_clk),
    .fixed_io_ps_porb(fixed_io_ps_porb),
    .fixed_io_ps_srstb(fixed_io_ps_srstb),
    .gpio_i(gpio_i),
    .gpio_o(gpio_o),
    .gpio_t(gpio_t),
    .spi0_csn(spi0_csn),
    .spi0_miso(spi0_miso),
    .spi0_mosi(spi0_mosi),
    .spi0_sclk(spi0_sclk),
    .spi1_csn(spi1_csn),
    .spi1_miso(spi1_miso),
    .spi1_mosi(spi1_mosi),
    .spi1_sclk(spi1_sclk));

endmodule

// ***************************************************************************
// ***************************************************************************
