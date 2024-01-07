module Adder
(
  input  [31:0]         src1,
  input  [31:0]         src2,

  output [31:0]        AdderRes
);

assign AdderRes = src1 + src2;

endmodule