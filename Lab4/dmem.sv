module dmem(input logic clk, we,
            input logic [31:0] a, wd,
            output logic [31:0] rd);

    logic [31:0] RAM[63:0];

    initial RAM [0] = 32'hC000_0000;

    assign rd = RAM[a[31:2]]; // word aligned

    always_ff @(posedge clk)
        if (we) begin
            RAM[a[31:2]] <= wd;
            
        end
        
endmodule