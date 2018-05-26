module fulladd8(clk,a,b,ci,seg,co,sel);
	input clk;
	input [7:0] a,b;
	input ci;
	output [6:0] seg;
	output co;
	output [1:0] sel;

	reg [9:0] count;
	reg [1:0] sel;
	wire [7:0] s;
	reg [4:0] val;
	wire [6:0] seg;
	reg clk_reg;
	reg sel_cnt;

	initial
	begin
		count <= 0;
		clk_reg <= 0;
		sel_cnt <= 0;
	end

	assign {co,s} = a+b+ci;

	always@(posedge clk)
	begin
		if(count == 10'd1000)
		begin
			count <= 0;
			clk_reg <= ~clk_reg;
		end
		else
			count <= count + 1;
	end

	always@(posedge clk_reg)
	begin
		case(sel_cnt)
		1'd0: begin sel <= 2'b10; val <= s[3:0]; end
		1'd1: begin sel <= 2'b01; val <= s[7:4]; end
		endcase

		sel_cnt <= sel_cnt + 1;
	end

	assign seg =
		(val == 4'h0) ? 7'b1111110 :
		(val == 4'h1) ? 7'b0110000 :
		(val == 4'h2) ? 7'b1101101 :
		(val == 4'h3) ? 7'b1111001 :
		(val == 4'h4) ? 7'b0110011 :
		(val == 4'h5) ? 7'b1011011 :
		(val == 4'h6) ? 7'b1011111 :
		(val == 4'h7) ? 7'b1110000 :
		(val == 4'h8) ? 7'b1111111 :
		(val == 4'h9) ? 7'b1111011 :
		(val == 4'hA) ? 7'b1110111 :
		(val == 4'hB) ? 7'b0011111 :
		(val == 4'hC) ? 7'b1001110 :
		(val == 4'hD) ? 7'b0111101 :
		(val == 4'hE) ? 7'b1001111 :
		(val == 4'hF) ? 7'b1000111 :
		7'bx;

endmodule
