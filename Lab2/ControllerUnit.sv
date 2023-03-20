module ControllerUnit(
	//Ports definition
	input logic [15:0] ReadInstr,
	output logic WE,
	output logic ALUorM,
	output logic [2:0] ALUCntr
);					 					 					 
	
	assign ALUCntr = ReadInstr[15:13];

	always_comb begin

		case(ReadInstr)

			16'hA100 : begin
				WE = 0;
				ALUorM = 0;
			end

			16'hD1FE : begin
				WE = 0;
				ALUorM = 1;
			end

			16'hD1FF : begin
				WE = 0;
				ALUorM = 1;
			end

			16'h1C80 : begin
				WE = 0;
				ALUorM = 0;
			end

			16'hF900 : begin
				WE = 1;
				ALUorM = 1'b0;
			end

			16'hA906 : begin
				WE = 1'b0;
				ALUorM = 1'b0;
			end

			16'hD9FE : begin
				WE = 1'b0;
				ALUorM = 1;
			end

			16'hD9FF : begin
				WE = 1'b0;
				ALUorM = 1;
			end

			16'h00C0 : begin
				WE = 1'b0;
				ALUorM = 1'b0;
			end

			16'h2B01 : begin
				WE = 1'b0;
				ALUorM = 1'b0;
			end

			16'hD3FE : begin
				WE = 1'b0;
				ALUorM = 1;
			end

			16'hD3FF : begin
				WE = 1'b0;
				ALUorM = 1;
			end

			16'hB905 : begin
				WE = 1'b0;
				ALUorM = 1'b0;
			end

			16'h0A80 : begin
				WE = 1'b0;
				ALUorM = 1'b0;
			end

			16'h3F01 : begin
				WE = 1'b0;
				ALUorM = 1'b0;
			end

			16'h3040 : begin
				WE = 1'b0;
				ALUorM = 1'b0;
			end

			16'hCF00 : begin
				WE = 1'b0;
				ALUorM = 1;
			end

			16'h0280 : begin
				WE = 1'b0;
				ALUorM = 1'b0;
			end
				
			default : begin
				WE = 0;
				ALUorM = 0;
			end
		endcase
	end
endmodule