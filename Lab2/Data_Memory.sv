module Data_Memory #(
    parameter N = 8, M = 8; //Number of bits for the arrays and Number of rows for the memory
) (
    input logic signed [N-1:0] Addr; //Memory address
    input logic signed [N-1:0] WriteData; //Memory address
    input logic WE; //Write Enable
    input logic clk; //Clock
    input logic ReadP2; //Button
    input logic signed [N-1:0] ReadP3; //Switchs
    output logic signed [N-1:0] ReadData; //Read Data
    output logic signed [N-1] WriteP1; //Seven segments display
);
    
    logic [N-1:0] RAM [2**M-1:0];

    always_ff @(posedge clk) begin
        if (WE)
            RAM[Addr] <= WriteData
        end

    assign ReadData = RAM[Addr];

endmodule