/*module comparator(a,b,out);
  input [3:0] a,b;
  output out;
  assign out=~(a[3]^b[3])&~(a[2]^b[2])&~(a[1]^b[1])&~(a[0]^b[0]);
endmodule*/

module comparator(a,b,out);
  input [3:0] a,b;
  output out;
  assign out=((a^b)==0)?1:0;
endmodule

/*module comparator(a,b,out);
  input [3:0] a,b;
  output out;
  wire [3:0] r;
  comparator_1bit(a[3],b[3],r[3]);
  comparator_1bit(a[2],b[2],r[2]);
  comparator_1bit(a[1],b[2],r[1]);
  comparator_1bit(a[0],b[0],r[0]);
  assign out=r[3]&r[2]&r[1]&r[0];
endmodule*/

/*module comparator(a,b,out);
  input [3:0] a,b;
  output out;
  reg out;
  always@(a or b) begin
    case(a^b)
      0:out=1;
      default:out=0;
    endcase
  end
endmodule*/

/*module comparator(a,b,out);
  input [3:0] a,b;
  output out;
  reg out;
  always@(a or b) begin
    if((a^b)==0)
      out=1;
    else
      out=0;
  end
endmodule*/