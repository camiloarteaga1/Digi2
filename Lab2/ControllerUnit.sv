module ControllerUnit(
	//Ports definition
	input logic [15:0] ReadInstr,
	output logic WE,
	output logic ALUorM,
	output logic [2:0] ALUCntr
);					 					 					 

	always_comb begin
	
		if (ReadInstr[15:13] == 3'b110) begin
			ALUorM = 1;
			WE = 0;
			ALUCntr = 3'b000;
		end
		
		else if (ReadInstr == 3'b111) begin
			ALUorM = 0;
			WE = 1;
			ALUCntr = 3'b000;
		end
		
		else begin
			ALUorM = 0;
			WE = 0;
			ALUCntr = ReadInstr[15:13];
		end
	end
endmodule