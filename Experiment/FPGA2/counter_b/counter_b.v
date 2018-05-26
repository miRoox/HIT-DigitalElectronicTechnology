module counter_b(clk,rst,mode,cs,a,b,c,d,e,f,g,dp);
	output a,b,c,d,e,f,g,dp;
	output cs;
	input clk,rst;
	input mode;

	wire cs;
	wire a,b,c,d,e,f,g,dp;
	reg [3:0] count;
	reg clk_reg;
	reg [31:0] clk_cnt;

	initial
	begin
		clk_cnt <= 0;
	end

	assign cs = 0;

	always@(posedge clk)
	begin
		if(clk_cnt == 32'd25000000)
		begin
			clk_reg <= ~clk_reg;
			clk_cnt <= 0;
		end
		else
			clk_cnt <= clk_cnt + 1;
	end

	always@(posedge clk_reg or negedge rst)
	begin
		if(!rst)
			count <= 0;
		else
		begin
			if(mode)
				count <= count + 1;
			else
				count <= count - 1;
		end
	end

	assign dp = 0;
	assign {a,b,c,d,e,f,g} = cs ? 7'bx :
		(count == 4'h0) ? 7'b1111110 :
		(count == 4'h1) ? 7'b0110000 :
		(count == 4'h2) ? 7'b1101101 :
		(count == 4'h3) ? 7'b1111001 :
		(count == 4'h4) ? 7'b0110011 :
		(count == 4'h5) ? 7'b1011011 :
		(count == 4'h6) ? 7'b1011111 :
		(count == 4'h7) ? 7'b1110000 :
		(count == 4'h8) ? 7'b1111111 :
		(count == 4'h9) ? 7'b1111011 :
		(count == 4'hA) ? 7'b1110111 :
		(count == 4'hB) ? 7'b0011111 :
		(count == 4'hC) ? 7'b1001110 :
		(count == 4'hD) ? 7'b0111101 :
		(count == 4'hE) ? 7'b1001111 :
		(count == 4'hF) ? 7'b1000111 :
		7'bx;

endmodule
