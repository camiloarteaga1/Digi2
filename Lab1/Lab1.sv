module Lab1 (
	input clk,
	input logic signed [7:0] switch,
	input logic reset,
	input logic button,
	output logic [34:0] display
);

	//Signals
	logic aux;
	logic [2:0] stat;
	
	//Instantiate modules
	control ctrl (.aux(aux), .reset(~reset), .clk(clk), .stat(stat));
	datapath datap (.clk(clk), .stat(stat), .switch(switch), .button(~button), .reset(~reset), .aux(aux), .display(display));
	
endmodule