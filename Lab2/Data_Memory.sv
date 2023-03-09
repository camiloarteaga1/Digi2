module Data_Memory #(
    parameter N = 8, M = 8 //Number of bits for the arrays, and number of rows for the memory
) (
    input logic signed [N-1:0] Addr, //Memory address
    input logic signed [N-1:0] WriteData, //Memory address
    input logic WE, //Write Enable
    input logic clk, //Clock
    input logic ReadP2, //Button
    input logic signed [N-1:0] ReadP3, //Switchs
    output logic signed [N-1:0] ReadData, //Read Data
    output logic signed [N-1:0] WriteP1 //Seven segments display
);
    
    reg [N-1:0] RAM [2**M-1:0];

    always_ff @(posedge clk) begin

        if (WE) begin
            RAM[Addr] <= WriteData;
				
				if (Addr == 253) begin
					WriteP1 = WriteData;
				end
				
        end
    end
    
    assign ReadData = ((Addr == 254)) ? ReadP2 : (Addr == 255) ? ReadP3 : RAM[Addr];

endmodule