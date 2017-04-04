module add(a,b,ci,co,s);
  input a,b,ci;
  output s,co;
  assign s=a^b^ci;
  assign co=a&b|a&ci|b&ci;
endmodule