module lab10(clk,rst,x);
  input clk,rst;
  output [7:0]x;
  wire serin;
  reg [7:0]x;
  assign serin=x[3]^x[0];
  always@(posedge clk)
  begin
  if(x==0)
    x[1]=1;
  if(rst==0)
    x=0;
  else
    x={serin,x[7:1]};
  end
endmodule