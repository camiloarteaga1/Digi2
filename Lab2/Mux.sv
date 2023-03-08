module Mux #(
    //Array size, number of bits
    parameter N = 8;
)
(
    //Ports definition
    input logic unsigned [N-1:0] Src2; //Signals for Mux1, Mux2
    input logic unsigned [1:0] RDst3; //Signal for Mux1
    input logic unsigned [N-1:0] RD2; //Signal for Mux2
    input logic unsigned [N-1:0] R; //Signal for Mux3
    input logic unsigned [N-1:0] ReadData; //Signal for Mux3
    
    output logic unsigned [1:0] RA2; //Output signal for Mux1
    output logic unsigned [N-1:0] B; //Output signal for Mux2
    output logic unsigned [N-1:0] Result; //Output signal for Mux3
    
    input logic unsigned WE; //Mux1 control
    input logic unsigned ALUSrc2; //Mux2 control
    input logic unsigned ALUorM; //Mux3 control
);

    always_comb begin

        RA2 = (WE == 0) ? Src2[N-1:N-2] : RDst3;
        B = (ALUSrc2 == 0) ? RD2 : Src2;
        Result = (ALUorM == 0) ? R : ReadData;
    
    end
endmodule