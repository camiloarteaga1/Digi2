module RegisterFile (
	input logic [1:0] RA1,RA2,RA3,
	output logic [7:0] RD1,RD2,
	input logic [7:0] WD3,
	input logic WE3, reset, CLK
);

	logic [7:0] Register [3:0];//4 registers of 8-bits each
	
	always_ff @(posedge CLK, posedge reset) begin
		if (reset) begin//reset registers 
			Register[0] <= 8'h00;
			Register[1] <= 8'h00;
			Register[2] <= 8'h00;
			Register[3] <= 8'h00;
		end 
			else if (WE3) begin//enable
					Register[RA3] <= WD3;
		end
	end

	//8-bits outputs
	assign RD1 = Register[RA1];
	assign RD2 = Register[RA2];
	
endmodule

module RegisterFile_tb ();
	
	logic [1:0] RA1,RA2,RA3;
	logic [7:0] WD3,RD1,RD2;
	logic WE3,reset,CLK;
	
	localparam delay = 30ps;
	
	RegisterFile REG(.RA1(RA1),.RA2(RA2),.RA3(RA3),.RD1(RD1),.RD2(RD2),.WD3(WD3),.WE3(WE3),.reset(reset),.CLK(CLK));
		
		initial begin
			
			CLK = 1'b0;
			reset = 1'b1;
			WE3 = 1'b1;
			WD3 = 8'b00000011;
			#delay;
			
			reset = 1'b0;
			
			#delay;
			WE3 = 1'b0;
			RA1 = 2'b01;
			RA2 = 2'b10;
			RA3 = 2'b11;
			
			#delay;
			RA3 = 2'b01;
			
			#delay;
			
			$stop;
			
		end
		
			always #(delay/2) CLK = ~CLK;
	
endmodule