module FSM_Unit (
    //Ports definition
    input logic clk,
    input logic reset,
    input logic [3:0] ALUFlags,
    output logic [7:0] InstrAddr
);

    //Sequential circuit to change the states
//   always_ff@(posedge clk, posedge reset) begin
//	if(reset==1) begin
//		InstrAddr <=0;
//		end
//	else begin
//		if ((InstrAddr==2 || InstrAddr==8 || InstrAddr==11 || InstrAddr==13 || InstrAddr==17 || InstrAddr==23) && ALUFlags[0]==1) begin
//			InstrAddr <= InstrAddr-1;
//			end
//		else begin
//			InstrAddr <= InstrAddr+1;
//			end
//		end
//	end

   always_ff@(posedge clk, posedge reset) begin
		if(reset==1) begin
			InstrAddr <=0;
			end
		else begin
			if ((InstrAddr==4 || InstrAddr==12 || InstrAddr==23) && ALUFlags[0]==1) begin
				InstrAddr <= InstrAddr-3;
				end
			else if((InstrAddr==8 || InstrAddr==15 || InstrAddr==19 || InstrAddr==26) && ALUFlags[0]==0) begin
				InstrAddr<=InstrAddr-1;
			end
			else if(InstrAddr==31) begin
				InstrAddr<=31;
			end
			else begin
				InstrAddr <= InstrAddr+1;
				end
			end
	end
    
    
endmodule

//   always_ff@(posedge clk, posedge reset) begin
//		if(reset==1) begin
//			InstrAddr <=0;
//			end
//		else begin
//			if ((InstrAddr==4 || InstrAddr==12 || InstrAddr==23) && ALUFlags[0]==1) begin
//				InstrAddr <= InstrAddr-3;
//				end
//			else if((InstrAddr==8 || InstrAddr==15 || InstrAddr==18 || InstrAddr==26) && ALUFlags[0]==0) begin
//				InstrAddr<=InstrAddr-1;
//			end
//			else if(InstrAddr==27) begin
//				InstrAddr<=27;
//			end
//			else begin
//				InstrAddr <= InstrAddr+1;
//				end
//			end
//	end
