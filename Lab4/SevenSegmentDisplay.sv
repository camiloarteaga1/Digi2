module SevenSegmentDisplay(
	input logic [3:0] Hex_in,
	output logic [6:0] Segment_out
	);
	
	 always_comb begin
									  //abcdefg
        case (Hex_in)					  //0123456
            4'h0: Segment_out[6:0] = 7'b0000001; // "0"
            4'h1: Segment_out[6:0] = 7'b1001111; // "1"
            4'h2: Segment_out[6:0] = 7'b0010010; // "2"
            4'h3: Segment_out[6:0] = 7'b0000110; // "3"
            4'h4: Segment_out[6:0] = 7'b1001100; // "4" 
            4'h5: Segment_out[6:0] = 7'b0100100; // "5"
            4'h6: Segment_out[6:0] = 7'b0100000; // "6"
            4'h7: Segment_out[6:0] = 7'b0001111; // "7"
            4'h8: Segment_out[6:0] = 7'b0000000; // "8"
            4'h9: Segment_out[6:0] = 7'b0000100; // "9"
            4'hA: Segment_out[6:0] = 7'b0001000; // "A"
            4'hB: Segment_out[6:0] = 7'b1100000; // "B"
            4'hC: Segment_out[6:0] = 7'b0110001; // "c"
            4'hD: Segment_out[6:0] = 7'b1000010; // "D"
            4'hE: Segment_out[6:0] = 7'b0110000; // "E"
            default : Segment_out[6:0] = 7'b0111000; //"F" 
        endcase

    end
	
endmodule