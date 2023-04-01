module Controller_Unit_FSM (
    //Ports definiton
    input logic clk,
    input logic reset,
    input logic [3:0] ALUFlags,
    output logic WE,
    output logic ALUorM,
    output logic [2:0] ALUCntr,
    output logic ALUSrc2,
    output logic [1:0] RDst3,
    output logic [1:0] RSrc1,
    output logic [7:0] Src2,
	 output logic [1:0] state
);

    //Signals
    logic [7:0] InstrAddr;
    logic [15:0] ReadInstr;

    //Signals connections
    assign RDst3 = ReadInstr[12:11];
    assign RSrc1 = ReadInstr[10:9];
	 assign ALUSrc2 = ReadInstr[8];
    assign Src2 = ReadInstr[7:0];

    //Connections
    FSM_Unit machine(.clk(clk), .reset(reset), .ALUFlags(ALUFlags), .InstrAddr(InstrAddr));
    InstructionMemory instructions(.InstrAddr(InstrAddr), .ReadInstr(ReadInstr));
    ControllerUnit controller(.ReadInstr(ReadInstr), .WE(WE), .ALUorM(ALUorM), .ALUCntr(ALUCntr));
	 
	 
	 always_comb begin 
		if (InstrAddr>=0 && InstrAddr<9)
			state=2'b00;
		else if(InstrAddr>8 && InstrAddr<19)
			state=2'b01;
		else if (InstrAddr>18 && InstrAddr<31)
			state=2'b10;
		else 
			state=2'b11;
	end
endmodule 