module div_1(add_bit,d_dend,d_sor,quo,rem);
  input d_dend;
  input [3:0]d_sor,add_bit;
  output quo;
  output [3:0]rem;
  assign quo=({add_bit,d_dend}<d_sor)?0:1;
  assign rem=({add_bit,d_dend}<d_sor)?{add_bit,d_dend}:({add_bit,d_dend}-d_sor);
endmodule
module div(dend,sor,quo,rem);
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
