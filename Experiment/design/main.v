`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:21:51 05/14/2018
// Design Name:
// Module Name:    main
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module main(
    input clk,          // 50MHz
    input [1:0] btn,    // 按钮
    output [3:0] an,    // 数码管位选
    output ca,          // 数码管段选
    output cb,
    output cc,
    output cd,
    output ce,
    output cf,
    output cg,
    output dp
    );

    wire clk5ms;
    wire rst, toggle;
    wire [3:0] dsec;
    wire [3:0] sec0;
    wire [3:0] sec1;
    wire [3:0] min;

    clkGen u1(
    .clk50MHz_i (clk),
    .clk5ms_o   (clk5ms)
    );

    controller u2(
    .rst_i      (rst),
    .toggle_i   (toggle),
    .clk_i      (clk5ms),
    .dsec_o     (dsec),
    .sec0_o     (sec0),
    .sec1_o     (sec1),
    .min_o      (min)
    );

    digitDisplay u3(
    .bcd_i0     (dsec),
    .bcd_i1     (sec0),
    .bcd_i2     (sec1),
    .bcd_i3     (min),
    .dp_i       (4'b0101),
    .clk_i      (clk5ms),
    .sel_o      (an),
    .a_o        (ca),
    .b_o        (cb),
    .c_o        (cc),
    .d_o        (cd),
    .e_o        (ce),
    .f_o        (cf),
    .g_o        (cg),
    .dp_o       (dp)
    );

    keyPress u4(
    .key_i      (btn[1]),
    .pressed_o  (rst),
    .clk_i      (clk5ms)
    );

    keyClick u5(
    .key_i      (btn[0]),
    .clicked_o  (toggle),
    .clk_i      (clk5ms)
    );

endmodule
