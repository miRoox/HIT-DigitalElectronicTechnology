`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:54:08 12/08/2017 
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
    input [3:0] SW,
    output [7:0] LED,
    output [3:0] AN,
    input CLK,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG
    );
    wire en38;
    wire [3:0] times;

    assign AN = 4'b0111;
    assign en38 = ~SW[3];
    
    decoder38 u1 (
    .in         (SW[2:0]),
    .out        (LED),
    .en         (en38)
    );
    timer u2 (
    .clk        (CLK),
    .bcdout     (times),
    .reset      (en38)
    );
    digitDecoder u3 (
    .bcdin      (times),
    .blank      (en38),
    .a          (CA),
    .b          (CB),
    .c          (CC),
    .d          (CD),
    .e          (CE),
    .f          (CF),
    .g          (CG)
    );

endmodule
