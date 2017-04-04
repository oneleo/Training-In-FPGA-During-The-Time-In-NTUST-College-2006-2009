//structure
/*module full_adder(a,b,ci,co,s);
  input a,b,ci;
  output co,s;
  assign s=a^b^ci;
  assign co=a&b|b&ci|a&ci;
endmodule

module adder(x,y,co,s);
  input [15:0]x,y;
  output [15:0]s;
  output co;
  wire [15:0]z;
  full_adder(x[0],y[0],0,z[0],s[0]);
  full_adder(x[1],y[1],z[0],z[1],s[1]);
  full_adder(x[2],y[2],z[1],z[2],s[2]);
  full_adder(x[3],y[3],z[2],z[3],s[3]);
  full_adder(x[4],y[4],z[3],z[4],s[4]);
  full_adder(x[5],y[5],z[4],z[5],s[5]);
  full_adder(x[6],y[6],z[5],z[6],s[6]);
  full_adder(x[7],y[7],z[6],z[7],s[7]);
  full_adder(x[8],y[8],z[7],z[8],s[8]);
  full_adder(x[9],y[9],z[8],z[9],s[9]);
  full_adder(x[10],y[10],z[9],z[10],s[10]);
  full_adder(x[11],y[11],z[10],z[11],s[11]);
  full_adder(x[12],y[12],z[11],z[12],s[12]);
  full_adder(x[13],y[13],z[12],z[13],s[13]);
  full_adder(x[14],y[14],z[13],z[14],s[14]);
  full_adder(x[15],y[15],z[14],z[15],s[15]);
  assign co=z[15];
endmodule*/

//concatenation operator{}
/*module adder(x,y,co,s);
  input [15:0]x,y;
  output [15:0]s;
  output co;
  assign {co,s}=x+y;
endmodule*/

//Carry-Lookahead Adders
module cla_4bits(a,b,ci,co,s);//ic74x283
  input [3:0]a,b;
  input ci;
  output [3:0]s;
  output co;
  wire [3:0]g,p,hs;
  wire [2:0]c;
  assign g=a&b;
  assign p=a|b;
  assign hs=((~a)&b)|(a&(~b));
  assign c[0]=g[0]|(p[0]&ci);
  assign c[1]=g[1]|(p[1]&g[0])|(p[1]&p[0]&ci);
  assign c[2]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&ci);
  assign co=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&ci);
  assign s[0]=((~hs[0])&ci)|(hs[0]&(~ci));
  assign s[1]=((~hs[1])&c[0])|(hs[1]&(~c[0]));
  assign s[2]=((~hs[2])&c[1])|(hs[2]&(~c[1]));
  assign s[3]=((~hs[3])&c[2])|(hs[3]&(~c[2]));
endmodule

module adder(x,y,co,s);
  input [15:0]x,y;
  output [15:0]s;
  output co;
  wire [2:0]c;
  cla_4bits(x[3:0],y[3:0],0,c[0],s[3:0]);
  cla_4bits(x[7:4],y[7:4],c[0],c[1],s[7:4]);
  cla_4bits(x[11:8],y[11:8],c[1],c[2],s[11:8]);
  cla_4bits(x[15:12],y[15:12],c[2],co,s[15:12]);
endmodule