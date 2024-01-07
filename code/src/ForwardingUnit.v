module ForwardingUnit
(
  input  [4:0]       IDEX_Rs1,
  input  [4:0]       IDEX_Rs2,
  input  [4:0]       EXMEM_Rd,
  input              EXMEM_RegWrite,
  input  [4:0]       MEMWB_Rd,
  input              MEMWB_RegWrite,

  output reg [1:0]       ForwardA,
  output reg [1:0]       ForwardB
);

always @(*) begin
  ForwardA = 2'b00;
  ForwardB = 2'b00;
  if (EXMEM_RegWrite && EXMEM_Rd != 0 && EXMEM_Rd == IDEX_Rs1) begin
    ForwardA = 2'b10;
  end else if (MEMWB_RegWrite && MEMWB_Rd != 0 && MEMWB_Rd == IDEX_Rs1) begin
    ForwardA = 2'b01; 
  end

  if (EXMEM_RegWrite && EXMEM_Rd != 0 && EXMEM_Rd == IDEX_Rs2) begin
    ForwardB = 2'b10;
  end else if (MEMWB_RegWrite && MEMWB_Rd != 0 && MEMWB_Rd == IDEX_Rs2) begin
    ForwardB = 2'b01; 
  end
end

endmodule