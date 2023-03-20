module FSM_Unit (
    //Ports definition
    input logic clk,
    input logic reset,
    input logic [3:0] ALUFlags,
    output logic [7:0] InstrAddr
);

    //Definition of states
    typedef enum logic [5:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17} State;

    //Signals
    State currentState, nextState;

    //Sequential circuit to change the states
    always_ff @(posedge reset, posedge clk) begin
		if (reset) begin
			currentState <= S0;
        end
		else begin
			currentState <= nextState;
        end
    end  

    always_comb begin

        case(currentState)

            S0: begin
                InstrAddr = 8'h00;
                nextState = S1;
            end

            S1: begin
                InstrAddr = 8'h01;
                nextState = S2;
            end

            S2: begin
                InstrAddr = 8'h02;
                nextState = S3;
            end

            S3: begin
                InstrAddr = 8'h03;
                nextState = S4;
            end

            S4: begin
                InstrAddr = 8'h04;
                nextState = S5;
            end

            S5: begin
                InstrAddr = 8'h05;
                nextState = S6;
            end

            S6: begin
                InstrAddr = 8'h06;
                nextState = S7;
            end

            S7: begin
                InstrAddr = 8'h07;
                nextState = S8;
            end

            S8: begin
                InstrAddr = 8'h08;
                nextState = S9;
            end

            S9: begin
                InstrAddr = 8'h09;
                
                if (ALUFlags[0] == 0) begin
                    nextState = S8;                
                end
                else begin
                    nextState = S10;
                end
            end

            S10: begin
                InstrAddr = 8'h10;
                nextState = S11;
            end

            S11: begin
                InstrAddr = 8'h11;
                nextState = S12;
            end

            S12: begin
                InstrAddr = 8'h12;
                nextState = S13;
            end

            S13: begin
                InstrAddr = 8'h13;
                nextState = S14;
            end

            S14: begin
                InstrAddr = 8'h14;
                
                if (ALUFlags[0] == 0) begin
                    nextState = S13;                
                end
                else begin
                    nextState = S15;
                end
            end

            S15: begin
                InstrAddr = 8'h15;
                nextState = S16;
            end

            S16: begin
                InstrAddr = 8'h16;
                nextState = S17;
            end

            S17: begin
                InstrAddr = 8'h17;
                nextState = S0;
            end

            default:
                InstrAddr = 8'h00;
                nextState = S0;
        endcase
    end


    
endmodule