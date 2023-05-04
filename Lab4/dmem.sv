module dmem(input logic clk, we, button,
            input logic [7:0] sw,
            input logic [31:0] a, wd,
            output logic [31:0] rd,
            output logic [7:0] deco_displays_seven_segments);

    localparam address = 32'hC000_0000;
    logic [31:0] RAM[63:0];

    initial RAM [0] = address;

    //assign rd = RAM[a[31:2]]; // word aligned
    assign rd = (a == address) ? 32'b0 : (a == address+4) ? 31'b0+button : (a == address+8) ? 24'b0+sw : RAM[a[31:2]];

    always_ff @(posedge clk)
        if (we) begin
            RAM[a[31:2]] <= wd;
            
            if (a == address)
                deco_displays_seven_segments <= wd[7:0];
        end
        
endmodule