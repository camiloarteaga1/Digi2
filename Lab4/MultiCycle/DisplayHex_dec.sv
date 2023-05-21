module DisplayHex_dec(
input signed [7:0] HexNum,
output logic [27:0] Displays
 );
 
	logic [3:0] HexCentenas,HexDecenas,HexUnidades;
	logic [7:0] Abs_num;
	
	assign Displays[27:21] = HexNum[7] ? 7'b1111110 : 7'b1111111;//Signo
	assign Abs_num = HexNum[7] ? -HexNum : HexNum;
	assign HexCentenas = (Abs_num)/100;
	assign HexDecenas = (Abs_num%100)/10;
	assign HexUnidades = (Abs_num%10);

   SevenSegmentDisplay deco1(HexUnidades, Displays[6:0]);
	SevenSegmentDisplay deco2(HexDecenas, Displays[13:7]);
   SevenSegmentDisplay deco3s(HexCentenas, Displays[20:14]);


endmodule

module Testbench();
	logic [7:0] HexNum;
	logic [27:0] Displays;

	DisplayHex_dec dec(HexNum,Displays);

	localparam delay = 10ps;

	initial begin
	HexNum = 8'b11111111; #delay;
	HexNum = 8'b01111111; #delay;
	HexNum = 8'b00011111; #delay;
	HexNum = 8'b00000000; #delay;


	$stop;
	end


endmodule