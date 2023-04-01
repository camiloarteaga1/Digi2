module SimpleCPU (
    //Ports definition
    input logic clk,
    input logic reset,
    input logic ReadP2, //Button
    input logic [7:0] ReadP3, //Switchs
    output logic [20:0] displays //Seven segments displays
);
    //Signals
    logic [7:0] WriteP1; //Number for seven segments
    logic [3:0] ALUFlags; //Result Flags from ALU
    logic WE; //Write Enable signal
    logic ALUorM; //Mux choose signal
    logic [2:0] ALUCntr; //ALU operation definition
    logic ALUSrc2; //Choose register or value
    logic [1:0] RDst3; //Final Register
    logic [1:0] RSrc1; //Register
    logic [7:0] Src2; //Register
	logic [1:0] state; //7segment

    //Modules connections
    Controller_Unit_FSM controller(.clk(clk), .reset(~reset), .ALUFlags(ALUFlags), .WE(WE), .ALUorM(ALUorM), 
                                    .ALUCntr(ALUCntr), .ALUSrc2(ALUSrc2), .RDst3(RDst3), .RSrc1(RSrc1), .Src2(Src2), 
                                    .state(state));
												
    Datapath datap(.RSrc1(RSrc1), .RDst3(RDst3), .Reset(~reset), .CLK(clk), .Src2(Src2), .WE(WE), .ALUSrc2(ALUSrc2), 
                                    .ALUorM(ALUorM), .ALUCntr(ALUCntr), .ReadP2(~ReadP2), .ReadP3(ReadP3), 
                                    .ALUFlags(ALUFlags), .WriteP1(WriteP1));

    //Seven Segments Displays
    SevenSegmentDisplay display1(.Hex_in(WriteP1[7:4]), .Segment_out(displays[13:7]));
    SevenSegmentDisplay display2(.Hex_in(WriteP1[3:0]), .Segment_out(displays[6:0]));
	 
	 always_comb begin
		case(state)
			2'b00: displays[20:14] = 7'b1001000;//X
			2'b01: displays[20:14] = 7'b1000100;//Y
			2'b10: displays[20:14] = 7'b0010010;//Z
			2'b11: displays[20:14] = 7'b0001000;//Answer
			default: displays[20:14] = 7'b1111111;
		endcase
	 end

endmodule

module SimpleCPU_tb ();
    
    logic clk;
    logic reset;
    logic ReadP2; //Button
    logic [7:0] ReadP3; //Switchs
    logic [20:0] displays; //Seven segments displays

    //Connection
    SimpleCPU CPUS(.clk(clk), .reset(reset), .ReadP2(ReadP2), .ReadP3(ReadP3), .displays(displays));

    localparam delay = 2ps;

    initial begin
        
        clk = 0;
        reset = 1;
		  ReadP2 = 1;
        #delay;

        reset = 0;
        #delay

        reset =1;
        ReadP2 = 0;
        ReadP3 = 8'H01;//X
        #(delay+50);
			
		  
        ReadP2 = 0;
        ReadP3 = 8'h01;//Y
        #(delay+50);

        ReadP2 = 0;
        ReadP3 = 8'h01;//Z
        #(delay+50);

		  $stop;
    end

    always #(delay/2)clk=~clk;

endmodule