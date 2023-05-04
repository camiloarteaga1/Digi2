module top(input logic clk, reset, button,
            input logic [7:0] sw,
            output logic [13:0] displays,
            output logic [31:0] WriteData, DataAdr,
            output logic MemWrite);
                    
        logic [31:0] PC, Instr, ReadData;
        logic [7:0] deco_displays_seven_segments;
        
        // instantiate processor and memories
        arm arm(clk, ~reset, PC, Instr, MemWrite, DataAdr,
                WriteData, ReadData);

        imem imem(PC, Instr);
        dmem dmem(clk, MemWrite, ~button, sw, DataAdr, WriteData, ReadData, deco_displays_seven_segments);

        //Seven segments display
        SevenSegmentDisplay deco1(deco_displays_seven_segments[7:4], displays[13:7]);
        SevenSegmentDisplay deco2(deco_displays_seven_segments[3:0], displays[6:0]);

endmodule