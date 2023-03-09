module RegisterFile (
	input logic [1:0] RA1,RA2,RA3,
	input logic [7:0] WD3,
	input logic WE3, reset, CLK,
	output logic [7:0] RD1,RD2
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

endmodule
