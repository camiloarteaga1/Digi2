module control (
    input logic aux,
    input logic reset,
	 input logic clk,
	 output logic [2:0] stat
 );

    //Definition of states
    typedef enum logic [2:0] {Sin, Sa1, Sa2, Sb1, Sb2, Sout} State;

    //Signals
    //logic clk_secondsReset;
    //logic signed [15:0] a_aux, b_aux, s_aux;
    State currentState, nextState;

    //Sequential circuit to change the states
    always_ff @(posedge reset, posedge clk) begin
		if (reset) begin
			currentState <= Sin;
        end
		else begin
			currentState <= nextState;
        end
    end    

    // //Sequential circuit for clk controller
    // always_ff @(posedge clk) begin

    //     if (reset || clk_secondsReset) begin
    //         clkAux = 0;
    //     end

    //     else begin
    //         clkAux = clkAux + 1;
    //     end

    // end

    always_comb begin
		//clk_secondReset = 0;
		case (currentState)
			Sin: begin
					stat = 000;

					if(aux) begin
						nextState = Sa1;
						// a_aux = 0;
					  // b_aux = 0;
					  // s_aux = 0;
					end	
					else begin
						nextState = Sin;
					end
			
				end
				
			Sa1:	begin
               stat = 001;

					if(aux) begin
							  nextState = Sa2;
						
					end	
					else begin
						nextState = Sa1;
					end
				end
				
			Sa2: begin
					stat = 010;
					
					if(aux) begin
						nextState = Sb1;
					end	
					else begin
						nextState = Sa2;
					end
				end
				
			Sb1: begin
					stat = 011;
					
					if(aux) begin
						nextState = Sb2;
					end	
					else begin
						nextState = Sb1;
					end
				end
				
			Sb2: begin	
					stat = 100;
					
					if(aux) begin
						nextState = Sout;
					end	
					else begin
						nextState = Sb2;
					end
				end
				
			Sout:	begin
					stat = 101;
					
					if(aux) begin
						nextState = Sin;
					end	
					else begin
						nextState = Sout;
					end
				end
			
			default:		
				nextState = Sin;
		endcase
	end	

endmodule