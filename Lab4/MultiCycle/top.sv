module top(input logic clk, reset, button,
            input logic [7:0] sw,
            output logic [27:0] displays,
            output logic [31:0] WriteData, DataAdr,
            output logic MemWrite);
                    
        logic [31:0] ReadData;
        logic [7:0] deco_displays_seven_segments;
        
        // instantiate processor and memories
        arm arm(clk, ~reset, DataAdr, MemWrite, WriteData, ReadData);

        mem mem(clk, MemWrite, ~button, sw, DataAdr, WriteData, ReadData, deco_displays_seven_segments);

        //Seven segments displays
        DisplayHex_dec DisplayDeco(deco_displays_seven_segments,displays);

endmodule