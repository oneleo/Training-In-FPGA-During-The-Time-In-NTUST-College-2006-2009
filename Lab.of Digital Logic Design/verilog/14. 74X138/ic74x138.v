module ic74x138(G1,G2A,G2B,C,B,A,Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0);
  input G1,G2A,G2B,C,B,A;
  output Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0;
  assign Y7=~(G1&~G2A&~G2B&C&B&A);
  assign Y6=~(G1&~G2A&~G2B&C&B&~A);
  assign Y5=~(G1&~G2A&~G2B&C&~B&A);
  assign Y4=~(G1&~G2A&~G2B&C&~B&~A);
  assign Y3=~(G1&~G2A&~G2B&~C&B&A);
  assign Y2=~(G1&~G2A&~G2B&~C&B&~A);
  assign Y1=~(G1&~G2A&~G2B&~C&~B&A);
  assign Y0=~(G1&~G2A&~G2B&~C&~B&~A);
endmodule