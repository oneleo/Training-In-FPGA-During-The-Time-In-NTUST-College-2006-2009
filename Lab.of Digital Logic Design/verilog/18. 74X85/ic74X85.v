module ic74X85(a,b,altbin,aeqbin,agtbin,altbout,aeqbout,agtbout);
  input [3:0]a,b;
  input altbin,aeqbin,agtbin;
  output altbout,aeqbout,agtbout;
  assign altbout=(a>b)|((a==b)&agtbin);
  assign aeqbout=(a==b)&aeqbin;
  assign agtbout=(a<b)|((a==b)&altbin);
endmodule