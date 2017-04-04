/*module mod6counter(en,clk,reset,even,q);
  input clk,en,reset;
  output even;
  output [2:0]q;
  reg [2:0]q;
  assign even=(q==0)|(q==2)|(q==4);
  always@(negedge clk or posedge reset)
  begin
    if(reset==1)
    begin
      q<=0;
    end
    else
    begin
      q[0]<=~en&~q[2]&~q[1]&q[0]|~en&~q[2]&q[1]&q[0]|~en&q[2]&~q[1]&q[0]|en&~q[2]&~q[1]&~q[0]|en&~q[2]&q[1]&~q[0]|en&q[2]&~q[1]&~q[0];
      q[1]<=~en&~q[2]&q[1]&~q[0]|~en&~q[2]&q[1]&q[0]|en&~q[2]&~q[1]&q[0]|en&~q[2]&q[1]&~q[0];
      q[2]<=~en&q[2]&~q[1]&~q[0]|~en&q[2]&~q[1]&q[0]|en&~q[2]&q[1]&q[0]|en&q[2]&~q[1]&~q[0];
    end
  end
endmodule*/

/*module mod6counter(en,clk,reset,even,q);
  input en,clk,reset;
  output [2:0]q;
  output even;
  wire [2:0]d;
  assign even=(q==0)|(q==2)|(q==4);
  assign d[0]=~en&~q[2]&~q[1]&q[0]|~en&~q[2]&q[1]&q[0]|~en&q[2]&~q[1]&q[0]|en&~q[2]&~q[1]&~q[0]|en&~q[2]&q[1]&~q[0]|en&q[2]&~q[1]&~q[0];
  assign d[1]=~en&~q[2]&q[1]&~q[0]|~en&~q[2]&q[1]&q[0]|en&~q[2]&~q[1]&q[0]|en&~q[2]&q[1]&~q[0];
  assign d[2]=~en&q[2]&~q[1]&~q[0]|~en&q[2]&~q[1]&q[0]|en&~q[2]&q[1]&q[0]|en&q[2]&~q[1]&~q[0];
  d_ff u0(q[0],d[0],clk,reset);
  d_ff u1(q[1],d[1],clk,reset);
  d_ff u2(q[2],d[2],clk,reset);
endmodule
module d_ff(q,d,clk,reset);
  input d,clk,reset;
  output q;
  reg q;
  always@(negedge clk or posedge reset)
  begin
    if(reset==1)
    begin
      q<=0;
    end
    else
    begin
      q<=d;
    end
  end
endmodule*/
module mod6counter(en,clk,reset,even,q);
  input clk,en,reset;
  output even;
  output [2:0]q;
  reg [2:0]q;
  assign even=(q==0)|(q==2)|(q==4);
  always@(negedge clk or posedge reset)
    begin
    if(reset==1)
      begin
      q<=0;
      end
    else if(en==0)
      begin
      q<=q;
      end
    else
      begin
      case(q)
        0:  q<=1;
        1:  q<=2;
        2:  q<=3;
        3:  q<=4;
        4:  q<=5;
        5:  q<=0;
        default:  q<=0;
      endcase
      end
    end
endmodule
