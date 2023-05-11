module Register2in #(parameter WIDTH = 8)
                (input logic clk, reset,
                input logic [WIDTH-1:0] RD1,
                input logic [WIDTH-1:0] RD2,
                output logic [WIDTH-1:0] Q1,
                output logic [WIDTH-1:0] Q2;);

  logic [1:0] registro_q;

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      registro_q <= '0;
    end else begin
      registro_q <= {RD2, RD1};
    end
  end

  assign Q1 = registro_q[WIDTH-1:0];
  assign Q2 = registro_q[WIDTH*2-1:WIDTH];

endmodule
