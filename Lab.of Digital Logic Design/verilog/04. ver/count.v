module count (clk,du,cout);
input clk,du;
output [3:0] cout;
reg [3:0] cout;
always @( posedge clk) begin
if(~du) begin
cout=cout+1;
if(cout==10)
cout=0;/*"="是條件成立後再做"<="是條件同時做*/
end
else begin
cout=cout-1;
if(cout==15)
cout=9;
end
end
endmodule