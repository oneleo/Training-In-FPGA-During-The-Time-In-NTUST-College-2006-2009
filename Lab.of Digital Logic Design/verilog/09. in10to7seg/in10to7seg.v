module in10to7seg(in14,in_scan,seg,seg_scan);
  input [13:0]in14;
  input [1:0]in_scan;
  output [3:0]seg_scan;
  output [6:0]seg;
  wire [15:0]single_bit;
  wire [27:0]sin_bit_tran;
  reg [6:0]seg;
  reg [3:0]seg_scan;
  assign single_bit[3:0]=(in14%10);
  assign single_bit[7:4]=(in14/10)%100;
  assign single_bit[11:8]=(in14/100)%1000;
  assign single_bit[15:12]=(in14/1000);
  print_7 s0(single_bit[3:0],sin_bit_tran[6:0]);
  print_7 s1(single_bit[7:4],sin_bit_tran[13:7]);
  print_7 s2(single_bit[11:8],sin_bit_tran[20:14]);
  print_7 s3(single_bit[15:12],sin_bit_tran[27:21]);
  always@(in_scan or in14)
    begin
    case(in_scan)
      0:  begin
          seg=sin_bit_tran[6:0];
          seg_scan=4'b1110;
          end
      1:  begin
          seg=sin_bit_tran[13:7];
          seg_scan=4'b1101;
          end
      2:  begin
          seg=sin_bit_tran[20:14];
          seg_scan=4'b1011;
          end
      3:  begin
          seg=sin_bit_tran[27:21];
          seg_scan=4'b0111;
          end
      default:  seg=0;
    endcase
    end
endmodule
module print_7(z,a);
  input [3:0]z;
  output [6:0]a;
  assign a[0]=(z==0)|(z==2)|(z==3)|(z==5)|(z==6)|(z==7)|(z==8)|(z==9)|(z==10)|(z==12)|(z==14)|(z==15);
  assign a[1]=(z==0)|(z==1)|(z==2)|(z==3)|(z==4)|(z==7)|(z==8)|(z==9)|(z==10)|(z==13);
  assign a[2]=(z==0)|(z==1)|(z==3)|(z==4)|(z==5)|(z==6)|(z==7)|(z==8)|(z==9)|(z==11)|(z==13);
  assign a[3]=(z==0)|(z==2)|(z==3)|(z==5)|(z==6)|(z==8)|(z==9)|(z==10)|(z==11)|(z==12)|(z==13)|(z==14);
  assign a[4]=(z==0)|(z==2)|(z==6)|(z==8)|(z==10)|(z==11)|(z==12)|(z==13)|(z==14)|(z==15);
  assign a[5]=(z==0)|(z==4)|(z==5)|(z==6)|(z==8)|(z==9)|(z==10)|(z==11)|(z==12)|(z==14)|(z==15);
  assign a[6]=(z==2)|(z==3)|(z==4)|(z==5)|(z==6)|(z==8)|(z==9)|(z==10)|(z==11)|(z==13)|(z==14)|(z==15);
endmodule