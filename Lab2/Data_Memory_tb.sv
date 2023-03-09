module Data_Memory_tb ();

    //Parameters
    localparam N = 8;
    localparam clockCycle = 30ps;

    ///signals
    logic signed [N-1:0] Addr; //Memory address
    logic signed [N-1:0] WriteData; //Memory address
    logic WE; //Write Enable
    logic clk; //Clock
    logic ReadP2; //Button
    logic signed [N-1:0] ReadP3; //Switchs
    logic signed [N-1:0] ReadData; //Read Data
    logic signed [N-1:0] WriteP1; //Seven segments display

    Data_Memory Memory (.Addr(Addr), .WriteData(WriteData), .WE(WE), .clk(clk), .ReadP2(ReadP2), .ReadP3(ReadP3), .ReadData(ReadData), .WriteP1(WriteP1));

    initial begin
        
        clk = 1'b0;

        Addr = 120; WriteData = 8; WE = 1; ReadP2 = 1; ReadP3 = 12;
        #clockCycle;
        Addr = 254; WriteData = 15; WE = 0; ReadP2 = 1; ReadP3 = 20;
        #clockCycle;
        Addr = 253; WriteData = 24; WE = 1; ReadP2 = 0; ReadP3 = 35;
        #clockCycle;
        Addr = 255; WriteData = 48; WE = 0; ReadP2 = 0; ReadP3 = 62;
        #clockCycle;

        $stop;
    end

    always #(clockCycle/2) clk = ~clk;
    
endmodule