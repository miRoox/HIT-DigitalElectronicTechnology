module vFullAdd(
	input a,
	input b,
	input c0,
	output s,
	output c
	);
	
	assign {c,s} = a + b + c0;
	
endmodule
