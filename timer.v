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
module timer(
    input clk,
    input reset,
    output [3:0] bcdout
    );
    reg [25:0] count;
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
            if(count==(~26'b0))
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
