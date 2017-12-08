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

// 主模块
module main(
    input [3:0] SW,     // 拨码开关
    output [7:0] LED,   // LED，高电平点亮
    output [3:0] AN,    // 数码管位选，低电平有效
    input CLK,          // 时钟输入，50MHz
    output CA,          // 数码管对应字段，低电平点亮
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG
    );
    wire en38;          // 3-8译码器使能输入，兼定时器复位以及数码管灭灯输入
    wire [3:0] times;   // 定时器输出计数

    assign AN = 4'b0111;
    assign en38 = ~SW[3];  // SW3 实现功能切换

    decoder38 u1 (
    .in         (SW[2:0]), // SW0~SW2 作为3-8译码器输入
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
