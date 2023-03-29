module Datapath #(
    parameter N = 8 //Number of bits
) (
    //Port definitions
    input logic [1:0] RSrc1, //Array to select register
    input logic [1:0] RDst3, //Array to select register
    input logic Reset, //Reset button
    input logic CLK, //Clock
    input logic [N-1:0] Src2, //Array with data
    input logic WE, //Write enable signal
    input logic ALUSrc2, //Mux2 control
    input logic ALUorM, //Mux3 control
    input logic [2:0] ALUCntr, //ALU operation control
    input logic ReadP2, //Button
    input logic [N-1:0] ReadP3, //Switchs
    output logic [3:0] ALUFlags, //Flags
    output logic [N-1:0] WriteP1 //Seven segments
);

    //Signals
    logic [N-1:0] Result; //ALU result
    logic [N-1:0] RD1; //Register from register file
    logic [N-1:0] WriteData; //Register from register file same as RD2
    logic [N-1:0] ReadData; //Data from the memory module
    logic [1:0] M1; //Signal from Multiplexer 1
    logic [N-1:0] M2; //Signal from Multiplexer 2
    logic [N-1:0] M3; //Signal from Multiplexer 3

    //Modules definitions
    RegisterFile REG(.RA1(RSrc1),.RA2(M1),.RA3(RDst3),.RD1(RD1),.RD2(WriteData),.WD3(M3),.WE3(~WE),.reset(Reset),.CLK(CLK));

    Muxes mx (.Src2(Src2), .RDst3(RDst3), .RD2(WriteData), .R(Result), .ReadData(ReadData), //Input signals
            .RA2(M1), .B(M2), .Result(M3), //Ouput signals
            .WE(WE), .ALUSrc2(ALUSrc2), .ALUorM(ALUorM)); //Control signals

    ALU alu (.A(RD1), .B(M2), .Cntr(ALUCntr), .ALUFlags(ALUFlags), .Result(Result)); //ALU

    Data_Memory Memory (.Addr(Result), .WriteData(WriteData), .WE(WE), .clk(CLK), .ReadP2(ReadP2), .ReadP3(ReadP3), .ReadData(ReadData), .WriteP1(WriteP1));

endmodule

module Datapath_tb();
    
    //Port definitions
    localparam N = 8;
    logic [1:0] RSrc1; //Array to select register
    logic [1:0] RDst3; //Array to select register
    logic Reset; //Reset button
    logic CLK; //Clock
    logic [N-1:0] Src2; //Array with data
    logic WE;//Write enable signal
    logic ALUSrc2; //Mux2 control
    logic ALUorM; //Mux3 control
    logic [2:0] ALUCntr; //ALU operation control
    logic ReadP2; //Button
    logic [N-1:0] ReadP3; //Switchs
    logic [3:0] ALUFlags; //Flags
    logic [N-1:0] WriteP1; //Seven segments

    Datapath datap(.RSrc1(RSrc1), .RDst3(RDst3), .Reset(~Reset), .CLK(CLK), .Src2(Src2), .WE(WE), .ALUSrc2(ALUSrc2), .ALUorM(ALUorM), .ALUCntr(ALUCntr), .ReadP2(ReadP2), .ReadP3(ReadP3), .ALUFlags(ALUFlags), .WriteP1(WriteP1));

    localparam delay=10us;
    
    initial begin
        CLK=0;
        Reset=0;
        WE=1;
        #delay;

        Reset=1;
        WE=0;
        #delay;
		  
	     ALUCntr=3'b101;
		  RDst3=2'b00;
		  RSrc1=2'b00;
		  ALUSrc2=1;
		  Src2=8'h00;
		  WE=0;
		  ALUorM=0;  
		  #delay;
		  
		  ReadP3=8'HF3;
		  ALUCntr=3'b000;
		  RDst3=2'b10;
		  RSrc1=2'b00;
		  ALUSrc2=1;
		  Src2=8'hFF;
		  WE=0;
		  ALUorM=1;  
		  #delay;
		  
		  ALUCntr=3'b000;
		  RDst3=2'b10;
		  RSrc1=2'b00;
		  ALUSrc2=1;
		  Src2=8'hFD;
		  WE=1;
		  ALUorM=0;
		  #delay;
		  Reset=0;
        
    end
    
    always #(delay/2)CLK=~CLK;
endmodule