module datapath (
	input logic clk,
	input logic [2:0] stat,
	input logic signed [7:0] switch,
	input logic button,
	input logic reset,
	output logic aux,
	output logic [34:0] display
);

	//Signals
	logic signed [15:0] a, b;
	logic signed [31:0] s;
	reg [1:0] Q;
	logic [3:0] Hex_in1, Hex_in2, Hex_in3, Hex_in4, Hex_in5;
	

	//Module instantiate
	//Multiplier
	multiplier mp (.x(a), .y(b), .out(s));
	
	//SevenSegments
	SevenSegmentDisplay s1 (.Hex_in(Hex_in1),.Segment_out(display[6:0]));
	SevenSegmentDisplay s2 (.Hex_in(Hex_in2),.Segment_out(display[13:7]));
	SevenSegmentDisplay s3 (.Hex_in(Hex_in3),.Segment_out(display[20:14]));
	SevenSegmentDisplay s4 (.Hex_in(Hex_in4),.Segment_out(display[27:21]));
	SevenSegmentDisplay s5 (.Hex_in(Hex_in5),.Segment_out(display[34:28]));

	always_ff @(posedge clk, posedge reset) begin

		if (reset) begin
			Q[0] <= 0;
			Q[1] <= 1;
		end

		else begin
			Q[1] <= ~Q[0];
			Q[0] <= button;
		end
	end

    assign aux = Q[0] & Q[1];

	always @(posedge clk) begin
			//clk_secondReset = 0;
			case (stat)
				3'b000: begin
						
						a = 0;
						b = 0;
						Hex_in1 = 4'h0;
						Hex_in2 = 4'h0;
						Hex_in3 = 4'h0;
						Hex_in4 = 4'h0;
						Hex_in5 = 4'h0;
						
						//s = 0;
					end
					
				3'b001:	begin
						
						a[7:0] = switch;
						Hex_in1 = a[3:0];
						Hex_in2 = a[7:4];
						Hex_in5 = 4'hA;
						
					end
					
				3'b010: begin
						
						a[15:8] = switch;
						Hex_in3 = a[11:8];
						Hex_in4 = a[15:12];
						Hex_in5 = 4'hA;
						
					end
					
				3'b011: begin
						
						b[7:0] = switch;
						Hex_in1 = b[3:0];
						Hex_in2 = b[7:4];
						Hex_in3 = 4'h0;
						Hex_in4 = 4'h0;
						Hex_in5 = 4'hB;
						
						
					end
					
				3'b100: begin	
						
						b[15:8] = switch;
						Hex_in3 = b[11:8];
						Hex_in4 = b[15:12];
						Hex_in5 = 4'hB;
						
					end
					
				3'b101:	begin
						
						Hex_in1 = s[3:0];
						Hex_in2 = s[7:4];
						Hex_in3 = s[11:8];
						Hex_in4 = s[15:12];	
						Hex_in5 = 4'h5;
						
					end
					
				default: begin		
							a = 0;
							b = 0;
							//s = 0;
						end
			endcase
		end	


endmodule