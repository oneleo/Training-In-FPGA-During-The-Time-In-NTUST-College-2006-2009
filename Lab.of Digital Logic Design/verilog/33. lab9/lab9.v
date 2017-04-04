module lab9(clk,in,detect_mealy,detect_moore);
  input clk,in;
  output detect_mealy,detect_moore;
  parameter a=0,b=1,c=2,d=3,e=4;
  reg detect_moore;
  reg [2:0]state;
  assign detect_mealy=detect_moore&in; //Turn mealy machine.
  always@(posedge clk)
    begin
    if(detect_moore==1)
      detect_moore<=0;
    case(state)
      a:
        if(in==0)
          state<=a;
        else
          state<=b;
      b:
        if(in==0)
          state<=c;
        else
          state<=b;
      c:
        if(in==0)
          state<=a;
        else
          state<=d;
      d:
        if(in==0)
          state<=e;
        else
          state<=b;
      e:
        if(in==0)
          state<=a;
        else
          begin
          state<=d;
          detect_moore<=1;
          end
    endcase
    end
endmodule