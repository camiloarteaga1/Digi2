module Data_Memory #(
    parameter N = 8; //Number of bits for the arrays
) (
    input logic unsigned [N-1:0] Addr; //Memory address
    input logic unsigned [N-1:0] WriteData; //Memory address
    input logic WE; //Write Enable
    input logic clk; //Clock
    input logic ReadP2; //Switch
    input logic unsigned [N-1:0] ReadP3; //Read data
    output logic 
);
    
endmodule