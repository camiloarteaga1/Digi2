module InstructionMemory (
    //ports definition
    input logic [7:0] InstrAddr,
    output logic [15:0] ReadInstr
);

    //Signals
    reg [15:0] memory [255:0];
    
    initial begin
        $readmemh("instructions.hex", memory);
    end

    assign ReadInstr = memory[InstrAddr];
    
endmodule