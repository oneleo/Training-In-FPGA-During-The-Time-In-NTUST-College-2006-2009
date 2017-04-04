module	comparator_1bit(a,b,out);
	input	a,b;
	output	out;
	assign	out=((a^b)==0)?1:0;
endmodule