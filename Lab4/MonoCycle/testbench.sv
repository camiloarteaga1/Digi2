module testbench();

    logic clk;
    logic reset;
	 logic button;
	 logic [7:0] sw;
	 logic [13:0] displays;
    logic [31:0] WriteData, DataAdr;
    logic MemWrite;

	 localparam delay = 50;
	 
    // instantiate device to be tested
    top dut(clk, reset, button, sw, displays, WriteData, DataAdr, MemWrite);
    

    // initialize test
    initial begin
        reset <= 0; button <= 1;
		  # 22; 
		  reset <= 1;
		  sw <= 8'h25;
		  #delay; button <= 0; #delay; button <= 1; #delay;
		  sw <= 8'h38;
		  #delay; button <= 0; #delay; button <= 1; #delay;
		  $stop;
		  
    end

    // generate clock to sequence tests
    always begin
        clk <= 1; # 5; clk <= 0; # 5;
    end

    // check that 7 gets written to address 0x64
    // at end of program
	 /*
    always @(negedge clk) begin
        if(MemWrite) begin
            if(DataAdr === 100 & WriteData === 7) begin
                $display("Simulation succeeded");
                $stop;
            end
            
            else if (DataAdr !== 96) begin
                $display("Simulation failed");
                $stop;
            end
        end
    end
	 */
    
endmodule