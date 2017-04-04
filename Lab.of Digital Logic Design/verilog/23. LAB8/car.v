module car(clk,rst,r,l,halt,led);//主程式
  input clk,rst,r,l,halt;
  output [5:0]led;
  wire div_clk;
  reg [5:0]led;
  div_fre div_one(.clk(clk),.div(div_clk));
  always@(negedge clk)
    begin
    if(rst==0)
      begin
      led<=6'b111111;
      end
    else
      begin
      if(halt==1)
        begin
        led<=6'b000000;
        end
      else
        begin
        if((l==0)&&(r==1))
          begin
          led[5:3]<=3'b111;
          led[0]<=(led[2:0]==3'b111)||(led[2:0]==3'b011)||(led[2:0]==3'b000);
          led[1]<=(led[2:0]==3'b111)||(led[2:0]==3'b000);
          led[2]<=(led[2:0]==3'b000);
          end
        else if((l==1)&&(r==0))
          begin
          led[2:0]<=3'b111;
          led[3]<=(led[5:3]==3'b000);
          led[4]<=(led[5:3]==3'b111)||(led[5:3]==3'b000);
          led[5]<=(led[5:3]==3'b111)||(led[5:3]==3'b110)||(led[5:3]==3'b000);
          end
        else if((r==1)&&(l==1))
          begin
          led<=6'b000000;
          end
        else
          begin
          led<=6'b111111;
          end
        end
      end
    end
endmodule

module div_fre(clk,div);//除頻電路
input clk;
output div;
reg [23:0]div_reg;
assign div=div_reg[23];
always@(negedge clk)
  begin
  div_reg<=div_reg+1;
  end
endmodule