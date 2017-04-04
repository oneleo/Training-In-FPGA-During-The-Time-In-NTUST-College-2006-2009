module demul(s,i,f);
  input [2:0]s;
  input i;
  output [7:0]f;
  assign f[0]=(s==0)&i;
  assign f[1]=(s==1)&i;
  assign f[2]=(s==2)&i;
  assign f[3]=(s==3)&i;
  assign f[4]=(s==4)&i;
  assign f[5]=(s==5)&i;
  assign f[6]=(s==6)&i;
  assign f[7]=(s==7)&i;
endmodule