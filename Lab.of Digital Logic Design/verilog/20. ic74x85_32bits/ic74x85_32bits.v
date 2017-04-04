module ic74x85(a,b,altbin,aeqbin,agtbin,altbout,aeqbout,agtbout);
  input [3:0]a,b;
  input altbin,aeqbin,agtbin;
  output altbout,aeqbout,agtbout;
  assign altbout=(a<b)|((a==b)&altbin);
  assign aeqbout=(a==b)&aeqbin;
  assign agtbout=(a>b)|((a==b)&agtbin);
endmodule

module ic74x85_32bits(a,b,altbout,aeqbout,agtbout);
  input [31:0]a,b;
  output altbout,aeqbout,agtbout;
  wire [6:0]alt,aeq,agt;
  ic74x85(a[31:28],b[31:28],0,1,0,alt[6],aeq[6],agt[6]);
  ic74x85(a[27:24],b[27:24],alt[6],aeq[6],agt[6],alt[5],aeq[5],agt[5]);
  ic74x85(a[23:20],b[23:20],alt[5],aeq[5],agt[5],alt[4],aeq[4],agt[4]);
  ic74x85(a[19:16],b[19:16],alt[4],aeq[4],agt[4],alt[3],aeq[3],agt[3]);
  ic74x85(a[15:12],b[15:12],alt[3],aeq[3],agt[3],alt[2],aeq[2],agt[2]);
  ic74x85(a[11:8],b[11:8],alt[2],aeq[2],agt[2],alt[1],aeq[1],agt[1]);
  ic74x85(a[7:4],b[7:4],alt[1],aeq[1],agt[1],alt[0],aeq[0],agt[0]);
  ic74x85(a[3:0],b[3:0],alt[0],aeq[0],agt[0],altbout,aeqbout,agtbout);
endmodule