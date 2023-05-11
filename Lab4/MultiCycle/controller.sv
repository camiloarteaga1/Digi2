module controller(input logic clk, reset,
                input logic [31:12] Instr,
                input logic [3:0] ALUFlags,
                output logic [1:0] RegSrc,
                output logic PCWrite, AdrSrc, MemWrite,
                output logic IRWrite,
                output logic [1:0] ResultSrc,
                output logic [1:0] ALUControl,
                output logic [1:0] ALUSrcB,
                output logic ALUSrcA
                output logic [1:0] ImmSrc,
                output logic RegWrite);

    logic [1:0] FlagW;
    logic PCS, RegW, MemW, NextPC;

    decoder dec(clk, reset, Instr[27:26], Instr[25:20], Instr[15:12],
                PCS, RegW, MemW, IRWrite, NextPC, AdrSrc, ALUSrcA,
                ResultSrc, ALUSrcB, ALUControl, FlagW, ImmSrc, RegSrc);

    condlogic cl(clk, reset, Instr[31:28], ALUFlags,
                FlagW, PCS, RegW, MemW, NextPC,
                PCWrite, RegWrite, MemWrite);
endmodule