module HazardDetectingUnit
(
  input  [4:0]     IFID_Rs1,
  input  [4:0]     IFID_Rs2,
  input            IDEX_MemRead,
  input  [4:0]     IDEX_Rd,
  output reg       PCWrite,
  output reg       Stall_o,
  output reg       NoOp
);

always @(*) begin
  Stall_o = 0;
  PCWrite = 1;
  NoOp = 0;
  if (IDEX_MemRead && (IDEX_Rd == IFID_Rs1 || IDEX_Rd == IFID_Rs2)) begin
    Stall_o = 1;
    PCWrite = 0;
    NoOp = 1;
  end
end

endmodule