module seg7(
	input [3:0] in,
	output a,
	output b,
	output c,
	output d,
	output e,
	output f,
	output g
	);
	
	assign {a,b,c,d,e,f,g} =
		(in == 4'd0) ? 7'b1111110 :
		(in == 4'd1) ? 7'b0110000 :
		(in == 4'd2) ? 7'b1101101 :
		(in == 4'd3) ? 7'b1111001 :
		(in == 4'd4) ? 7'b0110011 :
		(in == 4'd5) ? 7'b1011011 :
		(in == 4'd6) ? 7'b1011111 :
		(in == 4'd7) ? 7'b1110000 :
		7'bx;
	
endmodule
