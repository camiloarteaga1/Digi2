module dmem(input logic clk, we, button,
            input logic [7:0] sw,
            input logic [31:0] a, wd,
            output logic [31:0] rd,
            output logic [7:0] deco_displays_seven_segments);

    localparam address1 = 32'hC000_0000;
	 localparam address2 = 32'hC000_0004;
	 localparam address3 = 32'hC000_0008;
	 
    logic [31:0] RAM[63:0];

    // initial RAM [0] = address1;

    //assign rd = RAM[a[31:2]]; // word aligned
    //assign rd = (a == address1) ? 32'b0 : (a == address2) ? {31'b0, button} : (a == address3) ? {24'b0, sw} : RAM[a[31:2]];

	 always_comb begin
		
		if (a == address1)
			rd = 32'b0;
		
		else if (a == address2)
			rd = {31'b0, button};
		
		else if (a == address3)
			rd = {24'b0, sw};
			
		else if (a == 0)
			rd = address1;
			
		else
			rd = RAM[a[31:2]];
		
	 end
	 
    always_ff @(posedge clk)
        if (we) begin
                       
            if (a == address1)
                deco_displays_seven_segments <= wd[7:0];
					 
				else
					RAM[a[31:2]] <= wd;
        end
        
endmodule