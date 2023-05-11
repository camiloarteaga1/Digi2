module decoder(input logic clk, reset,
            input logic [1:0] Op,
            input logic [5:0] Funct,
            input logic [3:0] Rd,
            output logic BranchS, PCS, RegW, MemW,
            output logic IRWrite, NextPC, AdrSrc, ALUSrcA,
            output logic [1:0] ResultSrc, ALUSrcB,
            output logic [1:0] ALUControl, FlagW,
            output logic [1:0] ImmSrc, RegSrc);

    FSM machine (clk, reset, Op, Funct, Rd, RegW, MemW, IRWrite, 
                NextPC, AdrSrc, ALUSrcA, BranchS, ResultSrc, ALUSrcB);

    // ALU Decoder
    always_comb
        if (ALUOp) begin // which DP Instr?
            case(Funct[4:1])
                4'b0100: ALUControl = 2'b00; // ADD
                4'b0010: ALUControl = 2'b01; // SUB
                4'b0000: ALUControl = 2'b10; // AND
                4'b1100: ALUControl = 2'b11; // ORR
                default: ALUControl = 2'bx; // unimplemented
            endcase

            // update flags if S bit is set (C & V only for arith)
            FlagW[1] = Funct[0];
            FlagW[0] = Funct[0] &
                (ALUControl == 2'b00 | ALUControl == 2'b01);
                
        end else begin
            ALUControl = 2'b00; // add for non-DP instructions
            FlagW = 2'b00; // don't update Flags
        end

    // PC Logic
    assign PCS = ((Rd == 4'b1111) & RegW) | Branch;

    //Instruction Decoder
    assign RegSrc = {Op[0], Op[1]}
    assign ImmSrc[1:0] = Op;
    
endmodule