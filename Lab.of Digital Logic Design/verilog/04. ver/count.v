module count (clk,du,cout);
input clk,du;
output [3:0] cout;
reg [3:0] cout;
always @( posedge clk) begin
if(~du) begin
cout=cout+1;
if(cout==10)
cout=0;/*"="�O���󦨥߫�A��"<="�O����P�ɰ�*/
end
else begin
cout=cout-1;
if(cout==15)
cout=9;
end
end
endmodule