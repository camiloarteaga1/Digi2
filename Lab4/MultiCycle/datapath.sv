module datapath(input logic clk, reset,
                input logic PCWrite,
                input logic AdrSrc,
                input logic IRWrite,
                input logic [1:0] RegSrc,
                input logic RegWrite,
                input logic [1:0] ImmSrc,
                input logic ALUSrcA,
                input logic [1:0] ALUSrcB,
                input logic [1:0] ALUControl,
                output logic [3:0] ALUFlags,
                input logic [1:0] ResultSrc,
                
                output logic [31:0] Adr,
                output logic [31:0] WriteData,
                input logic [31:0] ReadData,
					 output logic [31:0] Instr);

    logic [31:0] PCNext,PC,Data;
    logic [31:0] RD1, RD1Aux, RD2, ExtImm, SrcA, SrcB, ALUOut, ALUResult, Result;
    logic [3:0] RA1, RA2;
    
	 assign PCNext = Result;
	 
    //PC LOGIC
    flopenr #(32) pcreg(clk,reset,PCWrite,PCNext,PC);
    mux2 #(32) pcmux(PC,Result, AdrSrc, Adr);
    
    //Register file logic
    flopenr #(32) rfRegister(clk,reset,IRWrite,ReadData,Instr);
    flopr #(32) rfRegister2(clk, reset,ReadData,Data);
    mux2 #(4) ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1);
    mux2 #(4) ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2);
    
    regfile rf(clk, RegWrite, RA1, RA2,
                Instr[15:12], Result, Result,
                RD1, RD2);
    extend ext(Instr[23:0], ImmSrc, ExtImm);
    
    //ALU logic
    Register2in #(32) regst(clk,reset,RD1,RD2,RD1Aux,WriteData);
    mux2 #(32) srcAmux(RD1Aux, PC, ALUSrcA, SrcA);
    mux3 #(32) srcBmux(WriteData,ExtImm,32'b100,ALUSrcB,SrcB);
    ALU #(32) alu (.A(SrcA), .B(SrcB), .Cntr(ALUControl), .Result(ALUResult), .ALUFlags(ALUFlags));

    flopr #(32) rfRegister3(clk, reset,ALUResult,ALUOut);
    mux3 #(32) Alumux(ALUOut,Data,ALUResult,ResultSrc,Result);

endmodule