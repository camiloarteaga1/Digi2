module Mux_tb ();
    
    //Parameters
    localparam N = 8; //Array size, number of bits
    localparam delay = 30ps; //Time delay

    //Signals
    logic unsigned [N-1:0] Src2; //Signals for Mux1, Mux2
    logic unsigned [1:0] RDst3; //Signal for Mux1
    logic unsigned [N-1:0] RD2; //Signal for Mux2
    logic unsigned [N-1:0] R; //Signal for Mux3
    logic unsigned [N-1:0] ReadData; //Signal for Mux3
    
    logic unsigned [1:0] RA2; //Output signal for Mux1
    logic unsigned [N-1:0] B; //Output signal for Mux2
    logic unsigned [N-1:0] Result; //Ouput signal for Mux3
    
    logic unsigned WE; //Mux1 control
    logic unsigned ALUSrc2; //Mux2 control
    logic unsigned ALUorM; //Mux3 control

    ///Definition of Mux
    Mux mx (.Src2(Src2), .RDst3(RDst3), .RD2(RD2), .R(R), .ReadData(ReadData), //Input signals
            .RA2(RA2), .B(B), .Result(Result), //Ouput signals
            .WE(WE), .ALUSrc2(ALUSrc2), .ALUorM(ALUorM); //Control signals

    //Block
    initial begin
        
        Src2 = 25; RDst3 = 2; WE = 1; //Mux1
        RD2 = 100; ALUSrc2 = 0; //Mux2
        R = 128; ReadData = 232; ALUorM = 0; //Mux3
        #delay;

        Src2 = 25; RDst3 = 2; WE = 0; //Mux1
        RD2 = 100; ALUSrc2 = 1; //Mux2
        R = 128; ReadData = 232; ALUorM = 0; //Mux3
        #delay;

        Src2 = 25; RDst3 = 2; WE = 0; //Mux1
        RD2 = 100; ALUSrc2 = 0; //Mux2
        R = 128; ReadData = 232; ALUorM = 1; //Mux3
        #delay;

        Src2 = 25; RDst3 = 2; WE = 1; //Mux1
        RD2 = 100; ALUSrc2 = 1; //Mux2
        R = 128; ReadData = 232; ALUorM = 1; //Mux3
        #delay;

        Src2 = 25; RDst3 = 2; WE = 0; //Mux1
        RD2 = 100; ALUSrc2 = 0; //Mux2
        R = 128; ReadData = 232; ALUorM = 0; //Mux3
        #delay;

        $stop
    end
    
endmodule