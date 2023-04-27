module ALU_tb ();

    //Arrays size
    localparam N = 32;
    localparam delay = 30ps;
    
    //Signals
    logic [N-1:0] A; //Array to operate with
    logic [N-1:0] B; //Array to operate with
    logic unsigned [2:0] Cntr; //Defines the type of operation
    logic [N-1:0] Result; //Result
    logic unsigned [3:0] ALUFlags; //4-bits state of differents operations result: N (Negative), Z (Zero), C (Carry out), V (Overflow)

    //Definition of ALU
    ALU alu (.A(A), .B(B), .Cntr(Cntr), .Result(Result), .ALUFlags(ALUFlags));

    //Block
    initial begin
        
        A = 15;     B = 10;     Cntr = 00; #delay;
        A = 15;     B = -10;    Cntr = 01; #delay;
        A = 255;    B = 255;    Cntr = 01; #delay;
        A = -120;   B = 88;     Cntr = 01; #delay;
        A = 42;     B = 10;     Cntr = 10; #delay;
        A = 55;     B = -2;     Cntr = 11; #delay;
        A = 20;     B = 128;    Cntr = 10; #delay;
        A = 37;     B = 154;    Cntr = 01; #delay;
        A = -76;    B = 95;     Cntr = 10; #delay;
        A = 234;    B = -43;    Cntr = 11; #delay;

        $stop;
    end
endmodule