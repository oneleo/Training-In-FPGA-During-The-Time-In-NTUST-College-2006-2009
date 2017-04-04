module div_1(add_bit,d_dend,d_sor,quo,rem);	/*1bits÷4bits對1bits商4bits餘除法器*/
  input d_dend;
  input [3:0]d_sor,add_bit;
  output quo;
  output [3:0]rem;
  assign quo=({add_bit,d_dend}<d_sor)?0:1;
  assign rem=({add_bit,d_dend}<d_sor)?{add_bit,d_dend}:({add_bit,d_dend}-d_sor);
endmodule

module div(dend,sor,quo,rem);	/*14bits÷4bits對14bits商4bits餘除法器*/
  input [13:0]dend;
  input [3:0]sor;
  output [13:0]quo;
  output [3:0]rem;
  wire [51:0]rem_reg;
  div_1(0,dend[13],sor,quo[13],rem_reg[51:48]);
  div_1(rem_reg[51:48],dend[12],sor,quo[12],rem_reg[47:44]);
  div_1(rem_reg[47:44],dend[11],sor,quo[11],rem_reg[43:40]);
  div_1(rem_reg[43:40],dend[10],sor,quo[10],rem_reg[39:36]);
  div_1(rem_reg[39:36],dend[9],sor,quo[9],rem_reg[35:32]);
  div_1(rem_reg[35:32],dend[8],sor,quo[8],rem_reg[31:28]);
  div_1(rem_reg[31:28],dend[7],sor,quo[7],rem_reg[27:24]);
  div_1(rem_reg[27:24],dend[6],sor,quo[6],rem_reg[23:20]);
  div_1(rem_reg[23:20],dend[5],sor,quo[5],rem_reg[19:16]);
  div_1(rem_reg[19:16],dend[4],sor,quo[4],rem_reg[15:12]);
  div_1(rem_reg[15:12],dend[3],sor,quo[3],rem_reg[11:8]);
  div_1(rem_reg[11:8],dend[2],sor,quo[2],rem_reg[7:4]);
  div_1(rem_reg[7:4],dend[1],sor,quo[1],rem_reg[3:0]);
  div_1(rem_reg[3:0],dend[0],sor,quo[0],rem);
endmodule

module  sing_bit(in14,out16_4);	/*轉換電路*/
  input [13:0]in14;
  output [15:0]out16_4;
  wire [55:0]reg_out16_4;
  div(in14,10,reg_out16_4[55:42],out16_4[3:0]);
  div(reg_out16_4[55:42],10,reg_out16_4[41:28],out16_4[7:4]);
  div(reg_out16_4[41:28],10,reg_out16_4[27:14],out16_4[11:8]);
  div(reg_out16_4[27:14],10,reg_out16_4[13:0],out16_4[15:12]);
/*  assign out16_4[15:12]=(in14/1000)%10;
  assign out16_4[11:8]=(in14/100)%10;
  assign out16_4[7:4]=(in14/10)%10;
  assign out16_4[3:0]=(in14%10);*/
endmodule

module scan_com(in14,in2_scan,out2_sel,out4_scan);	/*掃描解碼電路*/
  input [13:0]in14;
  input [1:0]in2_scan;
  output [1:0]out2_sel;
  output [3:0]out4_scan;
  assign out2_sel[1]=(((in14>=100)&(in14<1000)&(in2_scan==2'b10))|((in14>=1000)&(in2_scan==2'b10))|((in14>=1000)&(in2_scan==2'b11)));
  assign out2_sel[0]=(((in14>=10)&(in14<100)&(in2_scan==2'b01))|((in14>=10)&(in14<100)&(in2_scan==2'b11))|((in14>=100)&(in14<1000)&(in2_scan==2'b01))|((in14>=100)&(in14<1000)&(in2_scan==2'b11))|((in14>=1000)&(in2_scan==2'b01))|((in14>=1000)&(in2_scan==2'b11)));
  assign out4_scan[3]=((out2_sel==2'b00)|(out2_sel==2'b01)|(out2_sel==2'b10));
  assign out4_scan[2]=((out2_sel==2'b00)|(out2_sel==2'b01)|(out2_sel==2'b11));
  assign out4_scan[1]=((out2_sel==2'b00)|(out2_sel==2'b10)|(out2_sel==2'b11));
  assign out4_scan[0]=((out2_sel==2'b01)|(out2_sel==2'b10)|(out2_sel==2'b11));
endmodule

module mul_16to4(in16_sing_bit,in2_sel,out4_sing_bit);	/*多工器*/
  input [15:0]in16_sing_bit;
  input [1:0]in2_sel;
  output [3:0]out4_sing_bit;
  assign out4_sing_bit=(in2_sel==0)?in16_sing_bit[3:0]:(in2_sel==1)?in16_sing_bit[7:4]:(in2_sel==2)?in16_sing_bit[11:8]:in16_sing_bit[15:12];
endmodule

module print_7(in4_sing_bit,out7_seg);	/*七段顯示器解碼電路*/
  input [3:0] in4_sing_bit;
  output [6:0]out7_seg;
  assign out7_seg[0]=~((in4_sing_bit==0)|(in4_sing_bit==2)|(in4_sing_bit==3)|(in4_sing_bit==5)|(in4_sing_bit==6)|(in4_sing_bit==7)|(in4_sing_bit==8)|(in4_sing_bit==9)|(in4_sing_bit==10)|(in4_sing_bit==12)|(in4_sing_bit==14)|(in4_sing_bit==15));
  assign out7_seg[1]=~((in4_sing_bit==0)|(in4_sing_bit==1)|(in4_sing_bit==2)|(in4_sing_bit==3)|(in4_sing_bit==4)|(in4_sing_bit==7)|(in4_sing_bit==8)|(in4_sing_bit==9)|(in4_sing_bit==10)|(in4_sing_bit==13));
  assign out7_seg[2]=~((in4_sing_bit==0)|(in4_sing_bit==1)|(in4_sing_bit==3)|(in4_sing_bit==4)|(in4_sing_bit==5)|(in4_sing_bit==6)|(in4_sing_bit==7)|(in4_sing_bit==8)|(in4_sing_bit==9)|(in4_sing_bit==11)|(in4_sing_bit==13));
  assign out7_seg[3]=~((in4_sing_bit==0)|(in4_sing_bit==2)|(in4_sing_bit==3)|(in4_sing_bit==5)|(in4_sing_bit==6)|(in4_sing_bit==8)|(in4_sing_bit==9)|(in4_sing_bit==10)|(in4_sing_bit==11)|(in4_sing_bit==12)|(in4_sing_bit==13)|(in4_sing_bit==14));
  assign out7_seg[4]=~((in4_sing_bit==0)|(in4_sing_bit==2)|(in4_sing_bit==6)|(in4_sing_bit==8)|(in4_sing_bit==10)|(in4_sing_bit==11)|(in4_sing_bit==12)|(in4_sing_bit==13)|(in4_sing_bit==14)|(in4_sing_bit==15));
  assign out7_seg[5]=~((in4_sing_bit==0)|(in4_sing_bit==4)|(in4_sing_bit==5)|(in4_sing_bit==6)|(in4_sing_bit==8)|(in4_sing_bit==9)|(in4_sing_bit==10)|(in4_sing_bit==11)|(in4_sing_bit==12)|(in4_sing_bit==14)|(in4_sing_bit==15));
  assign out7_seg[6]=~((in4_sing_bit==2)|(in4_sing_bit==3)|(in4_sing_bit==4)|(in4_sing_bit==5)|(in4_sing_bit==6)|(in4_sing_bit==8)|(in4_sing_bit==9)|(in4_sing_bit==10)|(in4_sing_bit==11)|(in4_sing_bit==13)|(in4_sing_bit==14)|(in4_sing_bit==15));
endmodule

module in16tofpga(in14,in2_scan,out4_scan,out7_seg);	/*主程式*/
  input [13:0]in14;
  input [1:0]in2_scan;
  output [3:0]out4_scan;
  output [6:0]out7_seg;
  wire [15:0]io16_4;
  wire [3:0]io4_sing_bit;
  wire [1:0]io2_sel;
  sing_bit(in14,io16_4);
  mul_16to4(io16_4,io2_sel,io4_sing_bit);
  print_7(io4_sing_bit,out7_seg);
  scan_com(in14,in2_scan,io2_sel,out4_scan);
endmodule