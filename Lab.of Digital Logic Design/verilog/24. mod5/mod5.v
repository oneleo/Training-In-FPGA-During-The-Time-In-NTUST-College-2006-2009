/*module mod5(clk,en,up,q);//onehot-dataflow
  input clk,en,up;
  output [4:0]q;
  wire [4:0]d;
  assign d[0]=(q==0)?1:((~en)&(q[0]))|((en)&(~up)&(q[1]))|((en)&(up)&(q[4]));
  assign d[1]=((~en)&(q[1]))|((en)&(~up)&(q[2]))|((en)&(up)&(q[0]));
  assign d[2]=((~en)&(q[2]))|((en)&(~up)&(q[3]))|((en)&(up)&(q[1]));
  assign d[3]=((~en)&(q[3]))|((en)&(~up)&(q[4]))|((en)&(up)&(q[2]));
  assign d[4]=((~en)&(q[4]))|((en)&(~up)&(q[0]))|((en)&(up)&(q[3]));
  d_ff d0(.clk(clk),.clrn(1),.d(d[0]),.prn(1),.q(q[0]));
  d_ff d1(.clk(clk),.clrn(1),.d(d[1]),.prn(1),.q(q[1]));
  d_ff d2(.clk(clk),.clrn(1),.d(d[2]),.prn(1),.q(q[2]));
  d_ff d3(.clk(clk),.clrn(1),.d(d[3]),.prn(1),.q(q[3]));
  d_ff d4(.clk(clk),.clrn(1),.d(d[4]),.prn(1),.q(q[4])); 
endmodule

module d_ff(clk,clrn,d,prn,q);
  input clk,clrn,d,prn;
  output q;
  reg q;
  always@(negedge clk)
    begin
      if(clrn==0)
        begin
          q<=0;
        end
      else
        begin
          if(prn==0)
            begin
              q<=1;
            end
          else
            begin
              if(d==0)
                begin
                  q<=0;
                end
              else if(d==1)
                begin
                  q<=1;
                end
              else
                begin
                  q<=0;
                end
            end
        end
    end
endmodule*/

/*module mod5(clk,en,up,q);//onehot-behavior
  input clk,en,up;
  output [4:0]q;
  parameter s0=5'b00001,s1=5'b00010,s2=5'b00100,s3=5'b01000,s4=5'b10000;
  reg [4:0]q,state;
  always@(negedge clk)
    begin
      if(en==0)
        begin
          q<=q;
        end
      else
        begin
          case(state)
		    s0:
		      begin
		        q<=s0;
		        if(up==0)
		          begin
		            state<=s4;
		          end
		        else
		          begin
		            state<=s1;
		          end
		      end
		    s1:
		      begin
		        q<=s1;
		        if(up==0)
		          begin
		            state<=s0;
		          end
		        else
		          begin
		            state<=s2;
		          end
		      end
		    s2:
		      begin
		        q<=s2;
		        if(up==0)
		          begin
		            state<=s1;
		          end
		        else
		          begin
		            state<=s3;
		          end
		      end
		    s3:
		      begin
		        q<=s3;
		        if(up==0)
		          begin
		            state<=s2;
		          end
		        else
		          begin
		            state<=s4;
		          end
		      end
		    s4:
		      begin
		        q<=s4;
		        if(up==0)
		          begin
		            state<=s3;
		          end
		        else
		          begin
		            state<=s0;
		          end
		      end
		    default:
		      begin
		        state<=s0;
		        q<=s0;
		      end
	      endcase
        end
    end
endmodule*/

module mod5(clk,en,up,q);//mod5-behavior
  input clk,en,up;
  output [2:0]q;
  parameter s0=0,s1=1,s2=2,s3=3,s4=4;
  reg [2:0]q,state;
  always@(negedge clk)
    begin
      if(en==0)
        begin
          q<=q;
        end
      else
        begin
          case(state)
		    s0:
		      begin
		        q<=s0;
		        if(up==0)
		          begin
		            state<=s4;
		          end
		        else
		          begin
		            state<=s1;
		          end
		      end
		    s1:
		      begin
		        q<=s1;
		        if(up==0)
		          begin
		            state<=s0;
		          end
		        else
		          begin
		            state<=s2;
		          end
		      end
		    s2:
		      begin
		        q<=s2;
		        if(up==0)
		          begin
		            state<=s1;
		          end
		        else
		          begin
		            state<=s3;
		          end
		      end
		    s3:
		      begin
		        q<=s3;
		        if(up==0)
		          begin
		            state<=s2;
		          end
		        else
		          begin
		            state<=s4;
		          end
		      end
		    s4:
		      begin
		        q<=s4;
		        if(up==0)
		          begin
		            state<=s3;
		          end
		        else
		          begin
		            state<=s0;
		          end
		      end
		    default:
		      begin
		        state<=s0;
		        q<=s0;
		      end
	      endcase
        end
    end
endmodule