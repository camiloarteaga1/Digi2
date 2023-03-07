module ALU (

    //Port definition
    input logic signed [7:0] A, //Array to operate with
    input logic signed [7:0] B, //Array to operate with
    input logic unsigned [2:0] Cntr, //Defines the type of operation
    output logic unsigned [3:0] ALUFlags, //4-bits state of differents operations result: N (Negative), Z (Zero), C (Carry out), V (Overflow)
    output logic signed [7:0] R //Result
);

    //Parameters
    localparam N = 8; //Number of bits of the two arrays to operate
    localparam Add = 000; //R = A + B
    localparam Sub = 001; //R = A - B
    localparam And = 010; //R = A AND B
    localparam Or = 011; //R = A OR B
    localparam Not = 100; //R = NOT B
    localparam Equal = 101; //R = B
    localparam Nimp1 = 110; //No implementation
    localparam Nimp2 = 111; //No implementation
    localparam zeroFlag = 0000; //Zero Flag
    localparam negativeFlag = 0001; //Negative Flag
    localparam carryFlag = 0010; //Carry out Flag
    localparam overflowFlag = 0011; //Overflow Flag 
    localparam carryOverFlag = 0100; //Carry and overflow Flag
    localparam negOverFlag = 0101; //Negative and overflow Flag
    localparam negCarryFlag = 0110; //Negative and carry Flag
    localparam negCarryOverFlag = 0111; //Negative, carry and overflow Flag
    localparam noFlag = 1000; //No Flag

    //Signals
    reg [7:0] R_aux;
    //logic [3:0] Flag;
    logic [2:0] operation;  /*Addition = 000;
                            Substraction = 001; 
                            And = 010; 
                            Or = 011; 
                            Not = 100; 
                            Equal = 101; 
                            Nimp1 = 110; 
                            Nimp2 = 111;
                            */

    //Assigments
    assign R_aux <= R; //Ask if this is posible

    //Functions
    //Function that detects a carry out flag
    function logic carry_out(logic signed [N-1:0] a, logic signed [N-1:0] b, logic op);
        
        logic carry = 0;

        for (int i = 0; i < N; ++i) begin

            logic op1 = op ? a[i] & ~carry : a[i];
            logic op2 = op ? ~b[i] & ~carry : b[i];
            logic sum = op1 + op2 + carry;
            carry = (sum > 1) ? 1 : 0;

        end

        return carry; //0 if there is not carry out, 1 if there is carry out

    endfunction

    //Function that detects an overflow flag
    function logic overflow_detector(logic signed [N-1:0] a, logic signed [N-1:0] b, logic op); //Ask if it is possible to have the same names for both functions

        logic carry = 0;
        logic sign_a = a[N-1];
        logic sign_b = b[N-1];
        logic sign_res;

        for (int i = 0; i < N; ++i) begin
            logic op1 = op ? a[i] & ~carry : a[i];
            logic op2 = op ? ~b[i] & ~carry : b[i];
            logic sum = op1 + op2 + carry;
            carry = (sum > 1) ? 1 : 0;
        end

        sign_res = op ? ~(a[N-1] ^ b[N-1]) & a[N-1] : (sign_a ^ sign_b);

        return (sign_res ^ sign_a) && (sign_res ^ sign_b); //0 if there is not overflow, 1 if there is overflow

    endfunction

    //Function that detects a zero flag
    function logic zero_detector(logic signed [N-1:0] a, logic signed [N-1:0] b, logic [2:0] op);

        logic zeroD = 0;

        if ((a+b) == 0) && (op == add) begin
            zeroD = 1;
        end

        if ((a-b) == 0) && (op == Sub) begin
            zeroD = 1;
        end

        if ((a&b) == 0) && (op == And) begin
            zeroD = 1;
        end

        if ((a|b) == 0) && (op = Or) begin
            zeroD = 1;
        end

        if ((~b) == 0) && (op == Not) begin
            zeroD = 1;
        end

        if (b == 0) && (op == Equal) begin
            zeroD = 1;
        end

        else begin
            zeroD = 0;
        end

        return zeroD;

    endfunction

    //Function that detects a negative flag
    function logic negative_detector(logic signed [N-1:0] a, logic signed [N-1:0] b, logic [2:0] op);

        logic negative = 0;

        if ((a+b) < 0) && (op == Add) begin
            negative = 1;
        end

        if ((a-b) < 0) && (op == Sub) begin
            negative = 1;
        end

        if ((a&b) < 0) && (op == And) begin
            negative = 1;
        end

        if ((a|b) < 0) && (op = Or) begin
            negative = 1;
        end

        if ((~b) < 0) && (op == Not) begin
            negative = 1;
        end

        if (b < 0) && (op == Equal) begin
            negative = 1;
        end

        else begin
            negative = 0;
        end

        return negative;

    endfunction

    //Function that definites the flag to appear
    function logic flagDefinition(logic signed [N-1:0] a, logic signed [N-1:0] b, logic [2:0] op);
    
        logic [3:0] flagDef = 0;

        if (carry_out(a, b, op[0]) && overflow_detector(a, b, op[0])) begin //If there is an overflow and carry out Flag
            flagDef = carryOverFlag; 
        end

        if (carry_out(a, b, op[0]) && negative_detector(a, b, op)) begin //If there is an negative and carry out Flag
            flagDef = negCarryFlag; 
        end

        if (overflow_detector(a, b, op[0]) && negative_detector(a, b, op)) begin //If there is an overflow and negative Flag
            flagDef = negOverFlag;
        end

        if (overflow_detector(a, b, op[0]) && negative_detector(a, b, op) && carry_out(a, b, op[0])) begin //If there is an overflow, negative and carry out Flag
            flagDef = negCarryOverFlag;
        end

        if (carry_out(a, b, op[0])) begin //If there is a carry out Flag
            flagDef = carryFlag;
        end

        if (overflow_detector(a, b, op[0])) begin //If there is an overflow Flag
            flagDef = overflowFlag;
        end

        if (negative_detector(a, b, op)) begin //If there is a negative Flag
            flagDef = overflowFlag;
        end

        if (zero_detector(a, b, op)) begin //If there is a zero Flag
            flagDef = zeroFlag;
        end

        else begin //If there is not Flag
            flagDef = noFlag;
        end

        return flagDef;
    
    endfunction

    //ALU definition
    always_comb begin

        case(Cntr)
        
            Add: begin
                R = A + B;
                operation = Add;

                ALUFlags = flagDefinition(A, B, operation);
            end

            Sub: begin
                R = A - B;
                operation = Sub;

                ALUFlags = flagDefinition(A, B, operation);
            end

            And : begin
                R = A & B;
                operation = And;

                ALUFlags = flagDefinition(A, B, operation);
            end

            Or: begin
                R = A | B;
                operation = Or;

                ALUFlags = flagDefinition(A, B, operation);
            end

            Not: begin
                R = ~B;
                operation = Not;

                ALUFlags = flagDefinition(A, B, operation);
            end

            Equal: begin
                R = B;
                operation = Equal;

                ALUFlags = flagDefinition(A, B, operation);
            end

            Nimp1: begin
                $display("Not implemented function");
                operation = Nimp1;

                ALUFlags = flagDefinition(A, B, operation);
            end

            Nimp2: begin
                $display("Not implemented function");
                operation = Nimp2;

                ALUFlags = flagDefinition(A, B, operation);
            end

            default: begin
                R = R_aux[7:0];
            end

        endcase
    end

endmodule