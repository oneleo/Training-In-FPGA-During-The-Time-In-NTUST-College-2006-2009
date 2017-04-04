module FPS51(Enable_7Seg, display_7Seg,scan_clk);


output [3:0] Enable_7Seg; //致能七段信號
output [7:0] display_7Seg;// 七段顯示信號
input scan_clk;
wire [3:0] much_plus_sel;

reg [3:0] buffer;	    // 暫存number
reg [15:0] number;  	// 放千位百位十位個位
reg [1:0] how_much; 	// 判斷幾位數字
reg [1:0] scan_signal;  // 判斷掃描信號
reg [3:0] Enable_7Seg;  
reg [7:0] display_7Seg; 
reg [1:0] P3_Sel;
wire  show_clk; 
reg [13:0] P0P2_HL14;

Freq_Div(.clkout(show_clk), .clkin(scan_clk));



always @ (negedge show_clk)
  begin
     number[3:0] <= number[3:0] + 4'b0001 ;
     if(number[3:0] >= 4'b1001)
	 begin
	   number[3:0] <= 4'b0000;
	   number[7:4] <= number[7:4] + 4'b0001;
	   if(number[7:4] >= 4'b1001)
	   begin
	     number[7:4] <= 4'b0000;
	     number[11:8] <= number[11:8] + 4'b0001;
	     if(number[11:8] >= 4'b1001)
	     begin
	       number[11:8] <= 4'b0000;
	       number[15:12] <= number[15:12] + 4'b0001;
	       if(number[15:12] >= 4'b1001)
	          number[15:12] <= 4'b0000;
	     end
	   end 
	 end
  end 


always @ (scan_clk)
 begin
    P3_Sel = P3_Sel + 1; if(P3_Sel > 3 ) P3_Sel = 0;
 end

always @ (number)
  begin
	P0P2_HL14 = number[15:12] + number[11:8] * 100 + number[7:4] * 10 + number[3:0];
  end


assign	much_plus_sel[3] = P3_Sel[1];
assign	much_plus_sel[2] = P3_Sel[0];
assign	much_plus_sel[1] = how_much[1];
assign	much_plus_sel[0] = how_much[0];


always @ ( P0P2_HL14 ) // 判斷幾位數
  begin
      if(P0P2_HL14<10)	 				       how_much = 2'b00; // 十~千位都是0 輸出個位數00
	  if((P0P2_HL14>=10) && (P0P2_HL14<100))   how_much = 2'b01; // 十位不是0 輸出為01
	  if((P0P2_HL14>=100) && (P0P2_HL14<1000)) how_much = 2'b10; // 百位不是0 輸出為10
	  if(P0P2_HL14>=1000) 					   how_much = 2'b11; // 千位不是0 輸出為11	   
  end
																

always @ (P3_Sel or P0P2_HL14) // 判斷掃描信號
  begin
    case(much_plus_sel)
	  5 : scan_signal<=2'b01;
	  6 : scan_signal<=2'b01;
	  7 : scan_signal<=2'b01;
	  4'hA : scan_signal<=2'b10;
	  4'hB : scan_signal<=2'b10;
	  4'hD : scan_signal<=2'b01;
	  4'hF : scan_signal<=2'b11;
	  default:scan_signal=2'b00;
	endcase
  end

always @ (P3_Sel) //由掃描信號決定亮哪一顆
  begin
    case(scan_signal)
		0 : Enable_7Seg <= 4'b1110;
		1 : Enable_7Seg <= 4'b1101;      
		2 : Enable_7Seg <= 4'b1011;
		3 : Enable_7Seg <= 4'b0111;
		default: Enable_7Seg <= Enable_7Seg;
	endcase	
  end

always @ (scan_signal) // 由掃描信號決定輸出哪一位數
  begin
    case(scan_signal)
     	0 : buffer = number[3:0];
		1 : buffer = number[7:4];
		2 : buffer = number[11:8];
		3 : buffer = number[15:12];
	endcase
  end

always @ (buffer) //其實是把number解碼成七段碼
  begin
    case(buffer)
          0 : display_7Seg=8'hc0;//192
          1 : display_7Seg=8'hf9;//249
          2 : display_7Seg=8'ha4;//164
          3 : display_7Seg=8'hb0;//176
          4 : display_7Seg=8'h99;//153
          5 : display_7Seg=8'h92;//146
          6 : display_7Seg=8'h82;//130
          7 : display_7Seg=8'hf8;//248
          8 : display_7Seg=8'h80;//128
          9 : display_7Seg=8'h90;//144
    default : display_7Seg=8'hfd;//253
    endcase
  end
endmodule
module Freq_Div(clkout, clkin);

input  clkin; 
output clkout;

wire [8:0] tmp;

T_FF U6 (.Q(tmp[0]), .T(0), .clk(clkin));     // tmp16 640 Hz
T_FF U7 (.Q(tmp[1]), .T(0), .clk(tmp[0]));     // tmp17 320 Hz
T_FF U8 (.Q(tmp[2]), .T(0), .clk(tmp[1]));     // tmp18 160 Hz
T_FF U9 (.Q(tmp[3]), .T(0), .clk(tmp[2]));     // tmp19 80 Hz
T_FF U10(.Q(tmp[4]), .T(0), .clk(tmp[3]));     // tmp20 40 Hz
T_FF U11(.Q(tmp[5]), .T(0), .clk(tmp[4]));     // tmp21 20 Hz
T_FF U12(.Q(tmp[6]), .T(0), .clk(tmp[5]));     // tmp22 10 Hz
T_FF U13(.Q(tmp[7]), .T(0), .clk(tmp[6]));     // tmp23 5 Hz
T_FF U14(.Q(tmp[8]), .T(0), .clk(tmp[7]));     // tmp24 2.5 Hz 
T_FF U15(.Q(clkout) , .T(0), .clk(tmp[8]));     // clkout 1.25 Hz = 0.8 sec..

endmodule 
/*T型正反器*/
module T_FF(Q, T, clk);
input T, clk;
output Q;
reg Q;
always @ (negedge clk)
 begin
   if( T == 0 )  Q <= ~Q;
   if( T == 1 )  Q <= Q;
 end
endmodule

