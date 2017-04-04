module div_fre(clk,div);//°£ÀW¹q¸ô
input clk;
output div;
reg [23:0]div_reg;
assign div=div_reg[23];
always@(negedge clk)
  begin
  div_reg<=div_reg+1;
  end
endmodule

module car(clk,rst,r,l,halt,led);
  input clk,rst,r,l,halt;
  output [5:0]led;
  parameter l3=6'b111_000,l2=6'b011_000,l1=6'b001_000,
            r1=6'b000_100,r2=6'b000_110,r3=6'b000_111,
            idle=6'b000_000,haz=6'b111_1111;
  reg [5:0]state;
  assign led=~state;
  div_fre div_one(.clk(clk),.div(div_clk));
  always@(negedge clk)
    case(state)
      idle:
        if(rst==0)
          state<=idle;
        else
          if(halt==1||((l==1)&&(r==1)))
            state<=haz;
          else
            if((l==0)&&(r==0))
              state<=idle;
            else if((l==0)&&(r==1))
              state<=r1;
            else if((l==1)&&(r==0))
              state<=l1;
      haz:
        if(((l==1)&&(r==1))||(halt==1))
          state<=haz;
        else
          state<=idle;
      l3:
        state<=idle;
      l2:
        if(rst==0)
          state<=idle;
        else
          if(~(halt==0)||~(l==1)||~(r==0))
            state<=idle;
          else
            state<=l3;
      l1:
        if(rst==0)
          state<=idle;
        else
          if(~(halt==0)||~(l==1)||~(r==0))
            state<=idle;
          else
            state<=l2;
      r1:
        if(rst==0)
          state<=idle;
        else
          if(~(halt==0)||~(l==0)||~(r==1))
            state<=idle;
          else
            state<=r2;
      r2:
        if(rst==0)
          state<=idle;
        else
          if(~(halt==0)||~(l==0)||~(r==1))
            state<=idle;
          else
            state<=r3;
      r3:
        state<=idle;
    endcase
endmodule