/*module prime(n,f);
  input [3:0]n;
  output f;
  assign f=(n==1)|(n==2)|(n==3)|(n==5)|(n==7)|(n==11)|(n==13);
endmodule*/

/*module prime(n,f);
  input [3:0]n;
  output f;
  assign f=(~n[3]&~n[2]&~n[1]&n[0])|(~n[3]&~n[2]&n[1]&~n[0])|(~n[3]&~n[2]&n[1]&n[0])|(~n[3]&n[2]&~n[1]&n[0])|(~n[3]&n[2]&n[1]&n[0])|(n[3]&~n[2]&n[1]&n[0])|(n[3]&n[2]&~n[1]&n[0]);
endmodule*/

module prime(v,w,x,y,z,f);
  input v,w,x,y,z;
  output f;
  reg f;
  always@(v or w or x or y or z)
    begin
    case({v,w,x,y,z})
      0,1,2,3,4,5,10,11,14,20,21,24,25,26,27,28,29,30:
        f=1;
      default:
        f=0;
    endcase
    end
endmodule


/*module prime(n,f);
  input [3:0]n;
  output f;
  reg f;
  always@(n)
    begin
    case(n)
      1,2,3,5,7,11,13:
        f=1;
      default:
        f=0;
    endcase
    end
endmodule*/

//------------------------

/*module prime(n,f);
  input [3:0]n ;
  output f;
  wire [6:0]and_n;
  wire [3:0]not_n;
  not_gate(n[3],not_n[3]);
  not_gate(n[2],not_n[2]);
  not_gate(n[1],not_n[1]);
  not_gate(n[0],not_n[0]);
  and_gate(not_n[3],not_n[2],not_n[1],n[0],and_n[6]);
  and_gate(not_n[3],not_n[2],n[1],not_n[0],and_n[5]);
  and_gate(not_n[3],not_n[2],n[1],n[0],and_n[4]);
  and_gate(not_n[3],n[2],not_n[1],n[0],and_n[3]);
  and_gate(not_n[3],n[2],n[1],n[0],and_n[2]);
  and_gate(n[3],not_n[2],n[1],n[0],and_n[1]);
  and_gate(n[3],n[2],not_n[1],n[0],and_n[0]);
  or_gate(and_n,f);
endmodule

module and_gate(a,b,c,d,f);	//and¹h
  input a,b,c,d;
  output f;
  assign f=a&b&c&d;
endmodule

module or_gate(n,f);	//or¹h
  input [6:0]n;
  output f;
  assign y=n[6]|n[5]|n[4]|n[3]|n[2]|n[1]|n[0];
endmodule

module not_gate(n,f);	//not¹h
  input n;
  output f;
  f=~n;
endmodule*/