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
        end
    end

    always_comb begin

       WriteP1 = ((Addr == 253) && (WE)) ? WriteData : 0;
       ReadData[0] = ((Addr == 254) && (!WE)) ? ReadP2 : 0;
       ReadData = ((Addr == 255) && (!WE)) ? ReadP3 : RAM[Addr]; 
			

//        if ((Addr == 253) && (WE)) begin
//            WriteP1 = WriteData;
//        end
//
//        if ((Addr == 254) && (!WE)) begin
//            ReadData[0] = ReadP2;
//        end
//
//        if ((Addr == 255) && (!WE)) begin
//            ReadData = ReadP3;
//        end
//
//        else begin
//            ReadData = RAM[Addr];
//        end
    end

endmodule