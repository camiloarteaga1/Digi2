module InstructionMemory (
    //ports definition
    input logic [7:0] InstrAddr,
    output logic [15:0] ReadInstr
);

    //Signals
	always_comb begin
		case(InstrAddr)
			0: ReadInstr = 16'hA100;
			1: ReadInstr = 16'hD1FF;
			2: ReadInstr = 16'hE7FD;
//			3: ReadInstr = 16'hD1FF;
//			4: ReadInstr = 16'h1C80;
//			5: ReadInstr = 16'hF900;
//			6: ReadInstr = 16'hA906;
//			7: ReadInstr = 16'hD9FE;
//			8: ReadInstr = 16'hB8C0;
//			9: ReadInstr = 16'hD9FF;
//			10: ReadInstr = 16'h00C0;
//			11: ReadInstr = 16'h2B01;
//			12: ReadInstr = 16'hD3FE;
//			13: ReadInstr = 16'hB080;
//			14: ReadInstr = 16'hD3FF;
//			15: ReadInstr = 16'hB905;
//			16: ReadInstr = 16'h0A80;
//			17: ReadInstr = 16'h3F01;
//			18: ReadInstr = 16'h3040;
//			19: ReadInstr = 16'hCF00;
//			20: ReadInstr = 16'h0280;
//			21: ReadInstr = 16'hE7FD;
//			22: ReadInstr = 16'hD1FE;
//			23: ReadInstr = 16'hB080;
			default: ReadInstr = 0;
		endcase
	
	end
endmodule