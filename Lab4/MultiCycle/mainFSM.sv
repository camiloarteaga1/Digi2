module FSM (
    input logic clk, reset,
    input logic [1:0] Op,
    input logic [5:0] Funct,
    input logic [3:0] Rd,
	 output logic RegW, MemW, IRWrite, NextPC, 
    output logic AdrSrc, ALUSrcA, BranchS, ALUOp,
    output logic [1:0] ResultSrc, ALUSrcB
 );

    //Definition of states
    typedef enum logic [3:0] {Fetch, Decode, MemAdr, MemRead, MemWB, MemWrite,
                            ExecuteR, ExecuteI, ALUWB, Branch} State;

    //Signals
    //logic clk_secondsReset;
    //logic signed [15:0] a_aux, b_aux, s_aux;
    State currentState, nextState;

    logic [3:0] stat;

    //Sequential circuit to change the states
    always_ff @(posedge reset, posedge clk) begin
		if (reset) begin
			currentState <= Fetch;
        end
		else begin
			currentState <= nextState;
        end
    end

    //FSM
    always_comb begin
		//clk_secondReset = 0;
		AdrSrc = 0;
		ALUSrcA = 0;
      ALUSrcB = 2'b00;
      ALUOp = 0;
	   ResultSrc = 2'b00;
		IRWrite = 0;
		NextPC = 0;
		BranchS = 0;
		MemW = 0;
		RegW = 0;		
		
		case (currentState)
			Fetch: begin
                stat = 0000;

                AdrSrc = 0;
                ALUSrcA = 1;
                ALUSrcB = 2'b10;
                ALUOp = 0;
                ResultSrc = 2'b10;
                IRWrite = 1;
                NextPC = 1;

                nextState = Decode; //Next state
            end
				
			Decode: begin
                stat = 4'b0001;

                ALUSrcA = 1;
                ALUSrcB = 2'b10;
                ALUOp = 0;
                ResultSrc = 2'b10;

                //Next state
                if (Op == 2'b01)
                    nextState = MemAdr;

                else if ((Op == 2'b00) && (Funct[5] == 0))
                    nextState = ExecuteR;

                else if ((Op == 2'b00) && (Funct[5] == 1))
                    nextState = ExecuteI;
                
                else if (Op == 2'b10)
                    nextState = Branch;

                else
                    nextState = Fetch;

            end
				
			MemAdr: begin
                stat = 4'b0010;
                
                ALUSrcA = 0;
                ALUSrcB = 2'b01;
                ALUOp = 0;

                //Next state
                if (Funct[0] == 1)
                    nextState = MemRead;

                else
                    nextState = MemWrite;
            end
				
			MemRead: begin
                stat = 4'b0011;
                
                ResultSrc = 2'b00;
                AdrSrc = 1;

                nextState = MemWB; //Next state
            end
				
			MemWB: begin	
                stat = 4'b0100;
                
                ResultSrc = 2'b01;
                RegW = 1;
                
                nextState = Fetch; //Next state
            end
				
			MemWrite: begin
                stat = 4'b0101;
                
                ResultSrc = 2'b00;
                AdrSrc = 1;
                MemW = 1;

                nextState = Fetch; //Next state
            end

            ExecuteR: begin
                stat = 4'b0110;

                ALUSrcA = 0;
                ALUSrcB = 2'b00;
                ALUOp = 1;

                nextState = ALUWB; //Next state
            end

            ExecuteI: begin
                stat = 4'b0111;
                
                ALUSrcA = 0;
                ALUSrcB = 2'b01;
                ALUOp = 1;

                nextState = ALUWB; //Next state
            end

            ALUWB: begin
                stat = 4'b1000;
                
                ResultSrc = 2'b00;
                RegW = 1;

                nextState = Fetch; //Next state
            end

            Branch: begin
                stat = 4'b1001;
                
                ALUSrcA = 0;
                ALUSrcB = 2'b01;
                ALUOp = 0;
                ResultSrc = 2'b10;
                BranchS = 1;

                nextState = Fetch; //Next state
            end
			
			default:		
				nextState = Fetch;
		endcase
	end	
endmodule