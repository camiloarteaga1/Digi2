module ALU #(
    parameter N = 8 //Number of bits of the arrays
) (
    //Port definition
    input logic signed [N-1:0] A, //Array to operate with
    input logic signed [N-1:0] B, //Array to operate with
    input logic unsigned [2:0] Cntr, //Defines the type of operation
    output logic unsigned [3:0] ALUFlags, //4-bits state of differents operations result: N (Negative), Z (Zero), C (Carry out), V (Overflow)
    output logic [N-1:0] R //Result
);

    //Parameters
    localparam Add = 000; //R = A + B
    localparam Sub = 001; //R = A - B
    localparam And = 010; //R = A AND B
    localparam Or = 011; //R = A OR B
    localparam Not = 100; //R = NOT B
    localparam Move = 101; //R = B
    localparam Nimp1 = 110; //No implementation
    localparam Nimp2 = 111; //No implementation

    /*ALUFlags[0] = 1 - Zero Flag
      ALUFlags[0] = 0 - !Zero Flag
      ALUFlags[1] = 1 - Carry Flag
      ALUFlags[1] = 0 - !Carry Flag
      ALUFlags[2] = 1 - Negative Flag
      ALUFlags[2] = 0 - !Negative Flag
      ALUFlags[3] = 1 - Overflow Flag
      ALUFlags[3] = 0 - !Overflow Flag
    */

    //Signals
    logic [N:0] R_aux;
    logic [N:0] sum;

    //Assigments
    assign R = R_aux[N-1:0]; //Ask if this is posible
    assign bTemp = Cntr[0] == 0 ? B : ~B;

    //Flags
    assign ALUFlags[0] = R == 0 ? 1 : 0; //Zero Flag
    assign ALUFlags[1] = ~Cntr[1] & sum[N]; //Carry Flag
    assign ALUFlags[2] = R_aux[N]; //Negative Flag
    assign ALUFlags[3] = (Cntr[0] ~^ A ~^ B) & (A ^ sum[N]) & (~Cntr[1]); //Overflow Flag

    //ALU definition
    always @* begin

        casez(Cntr)
        
            3'b00? : begin //Addition and substraction
                sum = A + bTemp + Cntr[0];
                R_aux = sum;
            end

            And : begin
                R_aux = A & B;
            end

            Or: begin
                R_aux = A | B;
            end

            Not: begin
                R_aux = ~B;
            end

            Move: begin
                R_aux = B;
            end

            Nimp1: begin
                $display("Not implemented function");
                R_aux = 0;
            end

            Nimp2: begin
                $display("Not implemented function");
                R_aux = 0;
            end

            default: begin
                R_aux = 0;
            end
        endcase
    end

endmodule