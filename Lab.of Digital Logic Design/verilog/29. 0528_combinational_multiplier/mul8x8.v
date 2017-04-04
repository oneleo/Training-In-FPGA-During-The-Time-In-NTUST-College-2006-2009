module mul8x8(x,y,p);
  input [7:0]x,y;
  output [15:0]p;
  wire [55:0]s,c;

  assign {c[0],s[0]}=(y[0]&x[1])+(y[1]&x[0]);
  assign {c[1],s[1]}=(y[0]&x[2])+(y[1]&x[1]);
  assign {c[2],s[2]}=(y[0]&x[3])+(y[1]&x[2]);
  assign {c[3],s[3]}=(y[0]&x[4])+(y[1]&x[3]);
  assign {c[4],s[4]}=(y[0]&x[5])+(y[1]&x[4]);
  assign {c[5],s[5]}=(y[0]&x[6])+(y[1]&x[5]);
  assign {c[6],s[6]}=(y[0]&x[7])+(y[1]&x[6]);

  assign {c[7],s[7]}=c[0]+s[1]+(y[2]&x[0]);
  assign {c[8],s[8]}=c[1]+s[2]+(y[2]&x[1]);
  assign {c[9],s[9]}=c[2]+s[3]+(y[2]&x[2]);
  assign {c[10],s[10]}=c[3]+s[4]+(y[2]&x[3]);
  assign {c[11],s[11]}=c[4]+s[5]+(y[2]&x[4]);
  assign {c[12],s[12]}=c[5]+s[6]+(y[2]&x[5]);
  assign {c[13],s[13]}=c[6]+(y[1]&x[7])+(y[2]&x[6]);

  assign {c[14],s[14]}=c[7]+s[8]+(y[3]&x[0]);
  assign {c[15],s[15]}=c[8]+s[9]+(y[3]&x[1]);
  assign {c[16],s[16]}=c[9]+s[10]+(y[3]&x[2]);
  assign {c[17],s[17]}=c[10]+s[11]+(y[3]&x[3]);
  assign {c[18],s[18]}=c[11]+s[12]+(y[3]&x[4]);
  assign {c[19],s[19]}=c[12]+s[13]+(y[3]&x[5]);
  assign {c[20],s[20]}=c[13]+(y[2]&x[7])+(y[3]&x[6]);

  assign {c[21],s[21]}=c[14]+s[15]+(y[4]&x[0]);
  assign {c[22],s[22]}=c[15]+s[16]+(y[4]&x[1]);
  assign {c[23],s[23]}=c[16]+s[17]+(y[4]&x[2]);
  assign {c[24],s[24]}=c[17]+s[18]+(y[4]&x[3]);
  assign {c[25],s[25]}=c[18]+s[19]+(y[4]&x[4]);
  assign {c[26],s[26]}=c[19]+s[20]+(y[4]&x[5]);
  assign {c[27],s[27]}=c[20]+(y[3]&x[7])+(y[4]&x[6]);

  assign {c[28],s[28]}=c[21]+s[22]+(y[5]&x[0]);
  assign {c[29],s[29]}=c[22]+s[23]+(y[5]&x[1]);
  assign {c[30],s[30]}=c[23]+s[24]+(y[5]&x[2]);
  assign {c[31],s[31]}=c[24]+s[25]+(y[5]&x[3]);
  assign {c[32],s[32]}=c[25]+s[26]+(y[5]&x[4]);
  assign {c[33],s[33]}=c[26]+s[27]+(y[5]&x[5]);
  assign {c[34],s[34]}=c[27]+(y[4]&x[7])+(y[5]&x[6]);

  assign {c[35],s[35]}=c[28]+s[29]+(y[6]&x[0]);
  assign {c[36],s[36]}=c[29]+s[30]+(y[6]&x[1]);
  assign {c[37],s[37]}=c[30]+s[31]+(y[6]&x[2]);
  assign {c[38],s[38]}=c[31]+s[32]+(y[6]&x[3]);
  assign {c[39],s[39]}=c[32]+s[33]+(y[6]&x[4]);
  assign {c[40],s[40]}=c[33]+s[34]+(y[6]&x[5]);
  assign {c[41],s[41]}=c[34]+(y[5]&x[7])+(y[6]&x[6]);

  assign {c[42],s[42]}=c[35]+s[36]+(y[7]&x[0]);
  assign {c[43],s[43]}=c[36]+s[37]+(y[7]&x[1]);
  assign {c[44],s[44]}=c[37]+s[38]+(y[7]&x[2]);
  assign {c[45],s[45]}=c[38]+s[39]+(y[7]&x[3]);
  assign {c[46],s[46]}=c[39]+s[40]+(y[7]&x[4]);
  assign {c[47],s[47]}=c[40]+s[41]+(y[7]&x[5]);
  assign {c[48],s[48]}=c[41]+(y[6]&x[7])+(y[7]&x[6]);

  assign {c[49],s[49]}=c[42]+s[43];
  assign {c[50],s[50]}=c[49]+c[43]+s[44];
  assign {c[51],s[51]}=c[50]+c[44]+s[45];
  assign {c[52],s[52]}=c[51]+c[45]+s[46];
  assign {c[53],s[53]}=c[52]+c[46]+s[47];
  assign {c[54],s[54]}=c[53]+c[47]+s[48];
  assign {c[55],s[55]}=c[54]+c[48]+(y[7]&x[7]);

  assign p[0]=(y[0]&x[0]);
  assign p[1]=s[0];
  assign p[2]=s[7];
  assign p[3]=s[14];
  assign p[4]=s[21];
  assign p[5]=s[28];
  assign p[6]=s[35];
  assign p[7]=s[42];
  assign p[8]=s[49];
  assign p[9]=s[50];
  assign p[10]=s[51];
  assign p[11]=s[52];
  assign p[12]=s[53];
  assign p[13]=s[54];
  assign p[14]=s[55];
  assign p[15]=c[55];
endmodule
