module ALU #(
    parameter N = 32 //Number of bits of the arrays
) (
    //Port definition
    input logic [N-1:0] A, //Array to operate with
    input logic [N-1:0] B, //Array to operate with
    input logic unsigned [2:0] Cntr, //Defines the type of operation
    output logic [N-1:0] Result, //Result
    output logic unsigned [3:0] ALUFlags //4-bits state of differents operations result: N (Negative), Z (Zero), C (Carry out), V (Overflow)
);

    //Parameters
    localparam Add = 2'b00; //Result = A + B
    localparam Sub = 2'b01; //Result = A - B
    localparam And = 2'b10; //Result = A AND B
    localparam Or = 2'b11; //Result = A OR B
    
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
    logic [N:0] sum;
	 logic [N-1:0] bTemp;

    //Assigments
    assign bTemp = Cntr[0] == 0 ? B : ~B;

    //Flags
    assign ALUFlags[0] = Result == 0 ? 1 : 0; //Zero Flag
    assign ALUFlags[1] = ~Cntr[1] & sum[N]; //Carry Flag
    assign ALUFlags[2] = Result[N-1]; //Negative Flag
    assign ALUFlags[3] = (Cntr[0] ~^ A[N-1] ~^ B[N-1]) & (A[N-1] ^ sum[N-1]) & (~Cntr[1]); //Overflow Flag

    //ALU definition
    always_comb begin

		  sum = A + bTemp + Cntr[0];
        casez(Cntr)
        
            2'b0? : begin //Addition and substraction
                Result = sum[N-1:0];
            end

            And : begin
                Result = A & B;
            end

            Or: begin
                Result = A | B;
            end

            default: begin
                Result = 0;
            end
        endcase
    end

endmodule