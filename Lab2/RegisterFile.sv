module RegisterFile (
	input logic [1:0] RA1,RA2,RA3,
	input logic [7:0] WD3,RD1,RD2
	input logic WE3, reset, CLK,
);

	logic [7:0] Register [3:0];//4 registers of 8-bits each
	
	//8-bits outputs
	assign RD1 = Register[RA1];
	assign RD2 = Register[RA2];
	
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin//reset registers
			for (int i = 0; i<4; ++i) 
							Register[i] = 8'h00;	
		end 
			else if (!WE3) begin//enable
					Register[RA3] = WD3;
		end
	end

endmodule

module RegisterFile_tb ();
	
	logic [1:0] RA1,RA2,RA3;
	logic [7:0] WD3,RD1,RD2;
	logic WE3,reset,CLK;
	
	localparam delay = 10us;
	
	RegisterFile REG(RA1,RA2,RA3,WD3,RD1,RD2,WE3,Reset,CLK);
		
		
		always #(delay/2) CLK = ~CLK;
		
		initial begin
			
			CLK = 1'b0;
			Reset = 1'b1;
			WE3 = 1'b1;
			WD3 = 8'b00000011;
			#delay;
			
			Reset = 1'b0;
			
			#delay;
			WE3 = 1'b0;
			RA1 = 2'b01;
			RA2 = 2'b10;
			RA3 = 2'b11;
			
			#(delay*10);
			RA3 = 2'b01;
			
			#(delay*10);
			$stop;
			
		end
	
	

endmodule
