// ***************************************************************************
// ***************************************************************************
// Copyright (C) 2024-2025 Analog Devices, Inc. All rights reserved.
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

  inout                   fixed_io_mio_0,
  inout                   fixed_io_mio_1,
  inout       [ 3:0]      fixed_io_mio_4_7,
  inout       [53:47]     fixed_io_mio_47_43,
  inout                   fixed_io_ps_clk,
  inout                   fixed_io_ps_porb,
  inout                   fixed_io_ps_srstb,
  inout       [ 1:0]      fixed_io_ddr_vrn,
  inout       [ 1:0]      fixed_io_ddr_vrp,

  inout       [31:0]      gpio_bd,

  output                  scki,
  input                   scko,
  input       [ 7:0]      sdo,

  input                   busy,
  output                  cnv,
  output                  pd,
  output                  lvds_cmos_n,

  input                   csd0, //spiad_sdo
  output  reg             csck, //spiad_sck
  output  reg             csdio,//spiad_sdi
  output  reg             cs_n  //spiad_csn
);

  // internal signals

  wire    [94:0]  gpio_i;
  wire    [94:0]  gpio_o;
  wire    [94:0]  gpio_t;

  wire            spiad_sck_s;
  wire            spiad_csn_s;
  wire            spiad_sdi_s;

  wire            cpu_clk;

  reg     [ 4:0]  cnt_cs_up = 3'd0;

  assign gpio_i[94:32] = gpio_o[94:32];
  assign pd = gpio_o[32];

  always @(posedge cpu_clk) begin
    csck <= spiad_sck_s;
    csdio <= spiad_sdi_s;
    if (spiad_csn_s == 1'b0) begin
      cs_n <= 1'b0;
      cnt_cs_up <= 3'd0;
    end else if (cnt_cs_up == 5'h1f) begin
      cs_n <= 1'b0;
      cnt_cs_up <= cnt_cs_up;
    end else begin
      cs_n <= 1'b1;
      cnt_cs_up <= cnt_cs_up + 3'd1;
    end
  end

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
    .system_cpu_clk(cpu_clk),
    .spi0_clk_i(spiad_sck_s),
    .spi0_clk_o(spiad_sck_s),
    .spi0_csn_0_o(spiad_csn_s),
    .spi0_csn_1_o(),
    .spi0_csn_2_o(),
    .spi0_csn_i(1'b1),
    .spi0_sdi_i(csd0),
    .spi0_sdo_i(csd0),
    .spi0_sdo_o(spiad_sdi_s),
    .spi1_clk_i(1'b0),
    .spi1_clk_o(),
    .spi1_csn_0_o(),
    .spi1_csn_1_o(),
    .spi1_csn_2_o(),
    .spi1_csn_i(1'b1),
    .spi1_sdi_i(1'b0),
    .spi1_sdo_i(1'b0),
    .spi1_sdo_o(),
    .scki(scki),
    .scko(scko),
    .adc_lane_0(sdo[0]),
    .adc_lane_1(sdo[1]),
    .adc_lane_2(sdo[2]),
    .adc_lane_3(sdo[3]),
    .adc_lane_4(sdo[4]),
    .adc_lane_5(sdo[5]),
    .adc_lane_6(sdo[6]),
    .adc_lane_7(sdo[7]),
    .busy(busy),
    .cnv(cnv),
    .lvds_cmos_n(lvds_cmos_n));

endmodule
