module multiplier (
    //Port definition
    input logic signed [15:0] x,
    input logic signed [15:0] y,
    output logic signed [31:0] out
);

  //Aux variables
  logic signed [15:0] x_abs;
  logic signed [15:0] y_abs;
  logic signed sign;
  logic signed [15:0] tempOut;
  logic [31:0] finalOut;

  always_comb begin

    x_abs = (x < 0) ? (-x) : x;
    y_abs = (y < 0) ? (-y) : y;
    sign = (x < 0) ^ (y < 0);

    tempOut = 0;

    for (int i = 0; i < 16; ++i) begin

      if (y_abs[i]) begin

        tempOut = (tempOut + (x_abs << i));

      end
    end

    finalOut = (sign) ? -tempOut : tempOut;
    out = finalOut;

  end

endmodule