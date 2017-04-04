module count9999(clk,s0,s1,s2,s3,z0,z1,z2,z3);
  input clk;
  output [3:0] s0,s1,s2,s3;
  output [6:0] z0,z1,z2,z3;
  reg [3:0] s0,s1,s2,s3;
  print_7(s0,z0);
  print_7(s1,z1);
  print_7(s2,z2);
  print_7(s3,z3);
  always @ (negedge clk) begin
    if (s0>=9) begin
      s0=0;
      s1=s1+1;
    end
    else begin
      s0=s0+1;
    end
    if (s1>=10) begin
      s1=0;
      s2=s2+1;
    end
    if (s2>=10) begin
      s2=0;
      s3=s3+1;
    end
    if (s3>=10) begin
      s3=0;
    end
  end
endmodule