module xor_1bit(a,b,f);
  input a,b;
  output f;
  assign f=(~a&b)|(a&~b);
endmodule

module xor_4bit(i,f);
  input [3:0]i;
  output f;
  wire [1:0]re;
  xor_1bit(i[3],i[2],re[1]);
  xor_1bit(i[1],i[0],re[0]);
  xor_1bit(re[1],re[0],f);
endmodule