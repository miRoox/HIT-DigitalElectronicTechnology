`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:04:54 05/14/2018
// Design Name:
// Module Name:    keyClick
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
module keyClick(
    input key_i,
    output clicked_o,
    input clk_i
    );

    wire pressed;
    reg current, post;

    always@(posedge clk_i)
    begin
        current <= pressed;
    end

    always@(posedge clk_i)
    begin
        post <= current;
    end

    keyPress u1(
    .key_i      (key_i),
    .pressed_o  (pressed),
    .clk_i      (clk_i)
    );

    assign clicked_o = (post == 0) && (current == 1);

endmodule
