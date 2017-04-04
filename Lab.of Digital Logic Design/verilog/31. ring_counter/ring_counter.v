module d_ff(clk,clr,d,q);
  input clk,clr,d;
  output q;
  reg q;
  always@(negedge clk)
  begin
    if(clr==0)
      q<=0;
    else
      q<=d;
  end
endmodule

module ic74x194(clk,clr,s1,s0,lin,d,c,b,a,rin,qd,qc,qb,qa);
  input clk,clr,s1,s0,lin,d,c,b,a,rin;
  output qd,qc,qb,qa;
  wire [3:0]d_wire,q_wire;
  d_ff(.clk(~clk),.clr(clr),.d(d_wire[3]),.q(q_wire[3]));
  d_ff(.clk(~clk),.clr(clr),.d(d_wire[2]),.q(q_wire[2]));
  d_ff(.clk(~clk),.clr(clr),.d(d_wire[1]),.q(q_wire[1]));
  d_ff(.clk(~clk),.clr(clr),.d(d_wire[0]),.q(q_wire[0]));
  assign d_wire[3]=(lin&s1&~s0)|(q_wire[3]&~s1&~s0)|(d&s1&s0)|(q_wire[2]&~s1&s0);
  assign d_wire[2]=(q_wire[3]&s1&~s0)|(q_wire[2]&~s1&~s0)|(c&s1&s0)|(q_wire[1]&~s1&s0);
  assign d_wire[1]=(q_wire[2]&s1&~s0)|(q_wire[1]&~s1&~s0)|(b&s1&s0)|(q_wire[0]&~s1&s0);
  assign d_wire[0]=(q_wire[1]&s1&~s0)|(q_wire[0]&~s1&~s0)|(a&s1&s0)|(rin&~s1&s0);
  assign qd=q_wire[3];
  assign qc=q_wire[2];
  assign qb=q_wire[1];
  assign qa=q_wire[0];
endmodule

module ring_counter(clock,reset,q0,q1,q2,q3);
  input clock,reset;
  output q0,q1,q2,q3;
  wire q3_wire;
  ic74x194(.clk(clock),.clr(1),.s1(1),.s0(reset),.lin(q3_wire),.d(1),.c(0),.b(0),.a(0),.rin(),.qd(q0),.qc(q1),.qb(q2),.qa(q3_wire));
  assign q3=q3_wire;
endmodule