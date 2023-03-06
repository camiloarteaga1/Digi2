module ALU (

    //Port definition
    input logic [7:0] A, //Array to operate with
    input logic [7:0] B, //Array to operate with
    input logic [2:0] Cntr, //Defines the type of operation
    input logic clk, //Clock
    output logic [3:0] ALUFlags, //4-bits state of differents operations result: N (Negative), Z (Zero), C (Carry out), V (Overflow)
    output logic [7:0] R //Result
);

    //Parameters
    localparam Add = 000; //R = A + B
    localparam Sub = 001; //R = A - B
    localparam And = 010; //R = A AND B
    localparam Or = 011; //R = A OR B
    localparam Not = 100; //R = NOT B
    localparam Equal = 101; //R = B
    localparam Nimp1 = 110; //No implementation
    localparam Nimp2 = 111; //No implementation

    // //Definition of control values
    // typedef enum logic [2:0] {Add, Sub, And, Or, Not, Equal, Nimp1, Nimp2} control;

    //Signals
    reg [7:0] R_aux;
    //control ctrl;

    //Assigments
    assign R_aux <= R; //Ask if this is posible

    //ALU definition
    always @(posedge clk) begin

        case(Cntr)
        
            Add: begin
                R = A + B;
            end

            Sub: begin
                R = A - B;
            end

            And : begin
                R = A & B;
            end

            Or: begin
                R = A | B;
            end

            Not: begin
                R = ~B;
            end

            Equal: begin
                R = B;
            end

            Nimp1: begin
                $display("Not implemented function");
            end

            Nimp2: begin
                $display("Not implemented function");
            end

            default: begin
                R = R_aux;
            end

        endcase
    end

endmodule