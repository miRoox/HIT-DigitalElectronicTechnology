`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    18:33:18 12/08/2017
// Design Name:
// Module Name:    timer
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

// 定时减计数器
module timer(
    input clk,          // 输入时钟，BASYS2开发板上的时钟为50MHZ
    input reset,        // 复位信号，同步复位
    output [3:0] bcdout // BCD8421码输出
    );
    reg [25:0] count;   // 定时1s
    reg [3:0] out;

    initial
    begin
        count = 26'b0;
        out = 4'd9;
    end

    always @ (negedge clk)
    begin
        if (reset)
        begin
            count <= 26'b0;
        end
        else
        begin
            count <= count + 1;
        end
    end

    always @ (negedge clk)
    begin
        if (reset)
            out <= 4'd9;
        else
        begin
            if(count==26'd50_000_000)
            begin
                if (out==4'd0)
                    out <= 4'd9;
                else
                    out <= out - 1;
            end
        end
    end

    assign bcdout = out;

endmodule
