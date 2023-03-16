module ControllerUnit(
	input logic [15:0] ReadInstr,
	output logic WE,ALUorM,
	output logic [2:0] ALUCntr;
	

);					 					 					 
		
	always_comb 
		begin
		
			case(ReadInstr)
				16'h0000 : begin
						WE = 1'b0;
						ALUorM = 1'b0;

						end
				
				default : begin

						end
			endcase
		
		end
endmodule