`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:23:35 05/13/2018
// Design Name:
// Module Name:    controller
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
module controller(
    input rst_i,
    input toggle_i,
    input clk_i,        // 5ms
    output [3:0] dsec_o,
    output [3:0] sec0_o,
    output [3:0] sec1_o,
    output [3:0] min_o
    );

    parameter RESET = 0, STOP = 1, RUN = 2, OVERFLOW = 3;
    parameter BASE = 20; // 100ms

    reg [3:0] dsec_reg;
    reg [3:0] sec0_reg;
    reg [3:0] sec1_reg;
    reg [3:0] min_reg;
    reg [1:0] current_state, next_state;

    wire overflow;

    initial
    begin
        current_state <= RESET;
    end

    always@(posedge clk_i)
    begin
        current_state <= next_state;
    end

    always@(current_state or rst_i or toggle_i or overflow)
    begin
        case(current_state)
        RESET:
        begin
            if(rst_i)
                next_state <= RESET;
            else if(toggle_i)
                next_state <= RUN;
            else
                next_state <= STOP;
        end
        STOP:
        begin
            if(rst_i)
                next_state <= RESET;
            else if(toggle_i)
                next_state <= RUN;
            else if(overflow)
                next_state <= OVERFLOW;
            else
                next_state <= STOP;
        end
        RUN:
        begin
            if(rst_i)
                next_state <= RESET;
            else if(toggle_i)
                next_state <= STOP;
            else if(overflow)
                next_state <= OVERFLOW;
            else
                next_state <= RUN;
        end
        OVERFLOW:
        begin
            if(rst_i || toggle_i)
                next_state <= RESET;
            else
                next_state <= OVERFLOW;
        end
        default:
            next_state <= RESET;
        endcase
    end

    reg [4:0] basecnt; // see also BASE
    always@(posedge clk_i)
    begin
        case(current_state)
        RESET:
            basecnt <= 0;
        STOP:
            basecnt <= basecnt;
        RUN:
        begin
            if(basecnt == (BASE-1))
                basecnt <= 0;
            else
                basecnt <= basecnt + 1;
        end
        OVERFLOW:
            basecnt <= 0;
        endcase
    end

    wire carry_dsec; // 0.1s
    assign carry_dsec = ((dsec_reg == 9) && (basecnt == (BASE-1)));
    always@(posedge clk_i)
    begin
        case(current_state)
        RESET:
            dsec_reg <= 0;
        STOP:
            dsec_reg <= dsec_reg;
        RUN:
        begin
            if(carry_dsec)
                dsec_reg <= 0;
            else if(basecnt == (BASE-1))
                dsec_reg <= dsec_reg + 1;
            else
                dsec_reg <= dsec_reg;
        end
        OVERFLOW:
            dsec_reg <= 9;
        endcase
    end

    wire carry_sec0; // 1s
    assign carry_sec0 = (carry_dsec && (sec0_reg == 9));
    always@(posedge clk_i)
    begin
        case(current_state)
        RESET:
            sec0_reg <= 0;
        STOP:
            sec0_reg <= sec0_reg;
        RUN:
        begin
            if(carry_sec0)
                sec0_reg <= 0;
            else if(carry_dsec)
                sec0_reg <= sec0_reg + 1;
            else
                sec0_reg <= sec0_reg;
        end
        OVERFLOW:
            sec0_reg <= 9;
        endcase
    end

    wire carry_sec1; // 10s
    assign carry_sec1 = (carry_sec0 && (sec1_reg == 5));
    always@(posedge clk_i)
    begin
        case(current_state)
        RESET:
            sec1_reg <= 0;
        STOP:
            sec1_reg <= sec1_reg;
        RUN:
        begin
            if(carry_sec1)
                sec1_reg <= 0;
            else if(carry_sec0)
                sec1_reg <= sec1_reg + 1;
            else
                sec1_reg <= sec1_reg;
        end
        OVERFLOW:
            sec1_reg <= 5;
        endcase
    end

    // min
    assign overflow = (carry_sec1 && (min_reg == 9));
    always@(posedge clk_i)
    begin
        case(current_state)
        RESET:
            min_reg <= 0;
        STOP:
            min_reg <= min_reg;
        RUN:
        begin
            if(overflow)
                min_reg <= 9; // hold on
            else if(carry_sec1)
                min_reg <= min_reg + 1;
            else
                min_reg <= min_reg;
        end
        OVERFLOW:
            min_reg <= 9;
        endcase
    end

    assign dsec_o = dsec_reg;
    assign sec0_o = sec0_reg;
    assign sec1_o = sec1_reg;
    assign min_o  = min_reg;

endmodule
