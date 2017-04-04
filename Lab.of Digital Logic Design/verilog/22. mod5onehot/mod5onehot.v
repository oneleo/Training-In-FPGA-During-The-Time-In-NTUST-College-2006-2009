module mod5onehot(clk,en,up,reset,max,q);
  input clk,en,up,reset;
  output max;
  output [4:0]q;
  reg [4:0]q;
  assign max=(q[4]==1);
  always@(negedge clk)
  begin
    if(reset==1)
    begin
      q<=5'b00001;
    end
    else
    begin
      if(en==0)
      begin
        q<=q;
      end
      else
      begin
        if(up==0)
        begin
          q[0]<=q[1];
          q[1]<=q[2];
          q[2]<=q[3];
          q[3]<=q[4];
          q[4]<=q[0];
        end
        else
        begin
          q[0]<=q[4];
          q[1]<=q[0];
          q[2]<=q[1];
          q[3]<=q[2];
          q[4]<=q[3];
        end
      end
    end
  end
endmodule