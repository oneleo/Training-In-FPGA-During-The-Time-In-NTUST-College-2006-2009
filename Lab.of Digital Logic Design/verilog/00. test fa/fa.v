module fa(a,b,ci,co,s);
  input a,b,ci;
  output co,s;
  assign s=a^b^ci;
  assign co=a&b|b&ci|a&ci;
endmodule