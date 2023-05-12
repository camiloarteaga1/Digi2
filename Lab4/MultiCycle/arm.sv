module arm(input logic clk, reset,
            output logic [31:0] Adr,
            output logic MemWrite,
            output logic [31:0] WriteData,
            input logic [31:0] ReadData);
        
    logic [3:0] ALUFlags;
    logic PCWrite, AdrSrc, IRWrite, RegWrite, ALUSrcA;
    logic [1:0] RegSrc, ImmSrc, ALUSrcB, ALUControl, ResultSrc;

    controller c(clk, reset, Instr[31:12], ALUFlags,
                RegSrc, PCWrite, AdrSrc, MemWrite, IRWrite,
                ResultSrc, ALUControl, ALUSrcB, ALUSrcA,
                ImmSrc, RegWrite);

    datapath dp(clk,reset,
                PCWrite,AdrSrc,IRWrite,
                RegSrc,RegWrite,ImmSrc,
                ALUSrcA, ALUSrcB, ALUControl,
                ALUFlags, ResultSrc, Adr,
                WriteData, ReadData
                );               
endmodule