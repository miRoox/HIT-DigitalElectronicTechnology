`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:42:55 05/13/2018
// Design Name:
// Module Name:    digitSeg
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
module digitSeg(
    input [3:0] bcd_i,  // 输入BCD8421码
    output a_o,         // 数码管段选，低电平有效
    output b_o,
    output c_o,
    output d_o,
    output e_o,
    output f_o,
    output g_o
    );

    assign {a_o,b_o,c_o,d_o,e_o,f_o,g_o} =
        (bcd_i == 4'd0) ? 7'b0000001 :
        (bcd_i == 4'd1) ? 7'b1001111 :
        (bcd_i == 4'd2) ? 7'b0010010 :
        (bcd_i == 4'd3) ? 7'b0000110 :
        (bcd_i == 4'd4) ? 7'b1001100 :
        (bcd_i == 4'd5) ? 7'b0100100 :
        (bcd_i == 4'd6) ? 7'b0100000 :
        (bcd_i == 4'd7) ? 7'b0001111 :
        (bcd_i == 4'd8) ? 7'b0000000 :
        (bcd_i == 4'd9) ? 7'b0000100 :
        7'bx;

endmodule
