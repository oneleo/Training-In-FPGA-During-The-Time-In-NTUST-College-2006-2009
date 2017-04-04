module stupid_car(clk,rst,stupid_in,r,l,halt,led);
  input clk,rst,stupid_in,r,l,halt;
  output [5:0]led;
  parameter l3=6'b111_000,l2=6'b011_000,l1=6'b001_000,
            r1=6'b000_100,r2=6'b000_110,r3=6'b000_111,
            idle=6'b000_000,haz=6'b111_1111;
  reg [5:0]state,stupid_count;
  assign led=~state;
  always@(negedge div_clk)
    case(state)
      idle:
        if(rst==0)
          state<=idle;
        else if((stupid_in==1)||((stupid_count>=1)&&(stupid_count<=20)&&(stupid_count%2==0)))
          begin
          state<=idle;
          stupid_count<=stupid_count+1;
          end
        else if((stupid_in==1)||((stupid_count>=1)&&(stupid_count<=20)&&(stupid_count%2==1)))
          begin
          state<=haz;
          stupid_count<=stupid_count+1;
          end
        else
          begin
          stupid_count<=0;
          if(halt==1||((l==1)&&(r==1)))
            state<=haz;
          else
            if((l==0)&&(r==0))
              state<=idle;
            else if((l==0)&&(r==1))
              state<=r1;
            else if((l==1)&&(r==0))
              state<=l1;
          end
      haz:
        if((stupid_in==1)||((stupid_count>=1)&&(stupid_count<=20)&&(stupid_count%2==0)))
          begin
          state<=idle;
          stupid_count<=stupid_count+1;
          end
        else if((stupid_in==1)||((stupid_count>=1)&&(stupid_count<=20)&&(stupid_count%2==1)))
          begin
          state<=haz;
          stupid_count<=stupid_count+1;
          end
        else if(((l==1)&&(r==1))||(halt==1))
          begin
          stupid_count<=0;
          state<=haz;
          end
        else
          begin
          stupid_count<=0;
          state<=idle;
          end
      l3:
        state<=idle;
      l2:
        if(rst==0)
          state<=idle;
        else
          state<=l3;
      l1:
        if(rst==0)
          state<=idle;
        else
          state<=l2;
      r1:
        if(rst==0)
          state<=idle;
        else
          state<=r2;
      r2:
        if(rst==0)
          state<=idle;
        else
          state<=r3;
      r3:
        state<=idle;
    endcase
endmodule