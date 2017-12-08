`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:14:42 12/08/2017
// Design Name:
// Module Name:    digitDecoder
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
module digitDecoder(
    input [3:0] bcdin,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    input blank
    );

    assign {a,b,c,d,e,f,g} = (blank == 1) ? 7'b1111111 :
        (bcdin == 4'd0) ? 7'b0000001 :
        (bcdin == 4'd1) ? 7'b1001111 :
        (bcdin == 4'd2) ? 7'b0010010 :
        (bcdin == 4'd3) ? 7'b0000110 :
        (bcdin == 4'd4) ? 7'b1001100 :
        (bcdin == 4'd5) ? 7'b0100100 :
        (bcdin == 4'd6) ? 7'b0100000 :
        (bcdin == 4'd7) ? 7'b0001111 :
        (bcdin == 4'd8) ? 7'b0000000 :
        (bcdin == 4'd9) ? 7'b0000100 :
        7'bx;

endmodule
