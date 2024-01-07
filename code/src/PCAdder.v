module PCAdder(
  input   [31:0]      pc_i,
  output reg [31:0]      pc_o
);
  always @(*) begin
    pc_o = pc_i + 4;
  end

endmodule