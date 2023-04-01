module multiplier_tb ();
	
	//Connections
	logic signed [15:0] a, b;
	logic signed [31:0] s;
	
	//Definition of multiplier
	multiplier mp (.x(a), .y(b), .out(s));
	
	//Delay
	localparam delay = 30ps;
	
	//Block
	initial begin
		
		a = 5; b = 6; #delay;
		a = 10; b = 20; #delay;
		a = -4; b = -80; #delay;
		a = -2; b = 360; #delay;
		a = 1428; b = -1992; #delay;
		a = 15671; b = -6; #delay;
		a = 3; b = -7; #delay;
		a = -1; b = 10; #delay;
		
		$stop;
	end

endmodule