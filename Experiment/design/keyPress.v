`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:13:43 05/13/2018
// Design Name:
// Module Name:    keyPress
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
module keyPress(
    input key_i,        // 高电平有效
    output pressed_o,   // 高电平有效
    input clk_i         // 5ms
    );

    parameter DURATION = 10; // 50ms

    reg [3:0] cnt; // see also: DURATION

    initial
    begin
        cnt <= 0;
    end

    always@(posedge clk_i)
    begin
        if(key_i == 1)
        begin
            if(cnt < DURATION)
                cnt <= cnt + 1;
            else
                cnt <= DURATION;
        end
        else
            cnt <= 0;
    end

    assign pressed_o = (cnt == DURATION);

endmodule
