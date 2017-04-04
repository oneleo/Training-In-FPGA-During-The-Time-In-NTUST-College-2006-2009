module count9999(clk,scan,seg);/*主程式*/
input clk;
output [3:0]scan;
output [6:0]seg;
wire div_1b;
wire [1:0]div_2b;
wire [15:0]num;
wire [1:0]sel;
wire [3:0]out_num;
div_fre(clk,div_1b,div_2b);
count(div_1b,num);
scan_com(num,div_2b,sel,scan);
mul_16to4(num,sel,out_num);
print_7(out_num,seg);
endmodule

module scan_com(num,scan,sel,seg_scan);/*掃描解碼電路*/
  input [15:0]num;
  input [1:0]scan;
  output [1:0]sel;
  output [3:0]seg_scan;
  assign sel[1]=((num[15:12]==0)&(num[11:8]!=0)&(scan==2'b10))|((num[15:12]!=0)&(scan==2'b10))|((num[15:12]!=0)&(scan==2'b11));
  assign sel[0]=((num[15:8]==0)&(num[7:4]!=0)&(scan==2'b01))|((num[15:8]==0)&(num[7:4]!=0)&(scan==2'b11))|((num[15:12]==0)&(num[11:8]!=0)&(scan==2'b01))|((num[15:12]==0)&(num[11:8]!=0)&(scan==2'b11))|((num[15:12]!=0)&(scan==2'b01))|((num[15:12]!=0)&(scan==2'b11));
  assign seg_scan[3]=((sel==2'b00)|(sel==2'b01)|(sel==2'b10));
  assign seg_scan[2]=((sel==2'b00)|(sel==2'b01)|(sel==2'b11));
  assign seg_scan[1]=((sel==2'b00)|(sel==2'b10)|(sel==2'b11));
  assign seg_scan[0]=((sel==2'b01)|(sel==2'b10)|(sel==2'b11));
endmodule

module mul_16to4(num,sel,out_num);/*16to4多工器*/
  input [15:0]num;
  input [1:0]sel;
  output [3:0]out_num;
  assign out_num=(sel==0)?num[3:0]:(sel==1)?num[7:4]:(sel==2)?num[11:8]:num[15:12];
endmodule

module div_fre(clk,div_1b,div_2b);/*除頻電路*/
input clk;
output div_1b;
output [1:0]div_2b;
reg [15:0]div_reg;
assign div_1b=div_reg[15];
assign div_2b=div_reg[2:1];
always@(negedge clk)
  begin
  div_reg<=div_reg+1;
  end
endmodule

module count(clk,con_num);/*0to9999計數電路*/
  input clk;
  output [15:0]con_num;
  reg [15:0]con_num;
  always@(negedge clk)
    begin
    con_num[3:0]<=con_num[3:0]+1;
    if(con_num[3:0]>=9)
      begin
      con_num[3:0]<=0;
      con_num[7:4]<=con_num[7:4]+1;
      if(con_num[7:4]>=9)
        begin
        con_num[7:4]<=0;
        con_num[11:8]<=con_num[11:8]+1;
        if(con_num[11:8]>=9)
          begin
          con_num[11:8]<=0;
          con_num[15:12]<=con_num[15:12]+1;
          if(con_num[15:12]>=9)
            begin
            con_num[15:12]<=0;
            end
          end
        end
      end
    end
endmodule

module print_7(bcd,seg);/*七段解碼電路*/
  input [3:0]bcd;
  output [6:0]seg;
  assign seg[0]=~((bcd==0)|(bcd==2)|(bcd==3)|(bcd==5)|(bcd==6)|(bcd==7)|(bcd==8)|(bcd==9)|(bcd==10)|(bcd==12)|(bcd==14)|(bcd==15));
  assign seg[1]=~((bcd==0)|(bcd==1)|(bcd==2)|(bcd==3)|(bcd==4)|(bcd==7)|(bcd==8)|(bcd==9)|(bcd==10)|(bcd==13));
  assign seg[2]=~((bcd==0)|(bcd==1)|(bcd==3)|(bcd==4)|(bcd==5)|(bcd==6)|(bcd==7)|(bcd==8)|(bcd==9)|(bcd==11)|(bcd==13));
  assign seg[3]=~((bcd==0)|(bcd==2)|(bcd==3)|(bcd==5)|(bcd==6)|(bcd==8)|(bcd==9)|(bcd==10)|(bcd==11)|(bcd==12)|(bcd==13)|(bcd==14));
  assign seg[4]=~((bcd==0)|(bcd==2)|(bcd==6)|(bcd==8)|(bcd==10)|(bcd==11)|(bcd==12)|(bcd==13)|(bcd==14)|(bcd==15));
  assign seg[5]=~((bcd==0)|(bcd==4)|(bcd==5)|(bcd==6)|(bcd==8)|(bcd==9)|(bcd==10)|(bcd==11)|(bcd==12)|(bcd==14)|(bcd==15));
  assign seg[6]=~((bcd==2)|(bcd==3)|(bcd==4)|(bcd==5)|(bcd==6)|(bcd==8)|(bcd==9)|(bcd==10)|(bcd==11)|(bcd==13)|(bcd==14)|(bcd==15));
endmodule