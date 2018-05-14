`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    20:23:42 05/13/2018
// Design Name:
// Module Name:    clkGen
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
module clkGen(
    input clk50MHz_i,
    output clk5ms_o
    );

    parameter TIMES = 250_000; // 5ms

    reg [18:0] cnt; // see alse TIMES
    reg out;

    initial
    begin
        cnt <= 0;
        out <= 0;
    end

    always@(posedge clk50MHz_i)
    begin
        if(cnt < (TIMES-1))
            cnt <= cnt +1;
        else
            cnt <= 0;
    end

    always@(posedge clk50MHz_i)
    begin
        if(cnt == 0)
            out <= 1;
        else if(cnt == (TIMES/2))
            out <= 0;
        else
            out <= out;
    end

    assign clk5ms_o = out;

endmodule
