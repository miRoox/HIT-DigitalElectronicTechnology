`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:20:21 05/13/2018
// Design Name:
// Module Name:    digitDisplay
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
module digitDisplay(
    input [3:0] bcd_i0, // 输入BCD8421码
    input [3:0] bcd_i1,
    input [3:0] bcd_i2,
    input [3:0] bcd_i3,
    input [3:0] dp_i,   // 小数点控制
    input clk_i,        // 5ms
    output [3:0] sel_o, // 数码管位选输出，低电平有效
    output a_o,         // 数码管段选输出
    output b_o,
    output c_o,
    output d_o,
    output e_o,
    output f_o,
    output g_o,
    output dp_o
    );

    reg [3:0] sel_reg;
    reg dp_reg;
    reg [3:0] bcd_reg;
    reg [1:0] tubeSel;

    always@(posedge clk_i)
    begin
        case(tubeSel)
        2'd0:
        begin
            sel_reg <= 4'b0111;
            dp_reg <= dp_i[0];
            bcd_reg <= bcd_i0;
        end
        2'd1:
        begin
            sel_reg <= 4'b1011;
            dp_reg <= dp_i[1];
            bcd_reg <= bcd_i1;
        end
        2'd2:
        begin
            sel_reg <= 4'b1101;
            dp_reg <= dp_i[2];
            bcd_reg <= bcd_i2;
        end
        2'd3:
        begin
            sel_reg <= 4'b1110;
            dp_reg <= dp_i[3];
            bcd_reg <= bcd_i3;
        end
        endcase

        tubeSel <= tubeSel +1;
    end

    assign sel_o = sel_reg;
    digitSeg u1(
    .bcd_i      (bcd_reg),
    .a_o        (a_o),
    .b_o        (b_o),
    .c_o        (c_o),
    .d_o        (d_o),
    .e_o        (e_o),
    .f_o        (f_o),
    .g_o        (g_o)
    );
    assign dp_o = dp_reg;

endmodule
