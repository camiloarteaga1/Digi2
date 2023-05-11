module arm(input logic clk, reset,
            output logic [31:0] Adr,
            output logic MemWrite,
            output logic [31:0] WriteData,
            input logic [31:0] ReadData);
        
    logic [3:0] ALUFlags;
    logic PCWrite, AdrSrc, IRWrite, RegWrite, ALUSrcA, ResultSrc;
    logic [1:0] RegSrc, ImmSrc, ALUSrcB,ALUControl;

    controller c(clk, reset, Instr[31:12], ALUFlags,
                RegSrc, RegWrite, ImmSrc,
                ALUSrc, ALUControl,
                MemWrite, MemtoReg, PCSrc);

    datapath dp(clk,reset,
                PCWrite,AdrSrc,IRWrite,
                RegSrc,RegWrite,ImmSrc,
                ALUSrcA, ALUSrcB, ALUControl,
                ALUFlags, ResultSrc, Adr,
                WriteData, ReadData
                );               
endmodule