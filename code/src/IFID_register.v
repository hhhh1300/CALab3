module IFID_register
(
  input              rst_i,
  input              clk_i,  
  input              IFID_stall_i,
  input              IFID_flush_i, 
  input              flush_i,
  input  [31:0]      PC_i,
  input  [31:0]      instruction_i,

  output reg [31:0]      PC_o,
  output reg [31:0]      instruction_o
);

reg  [31:0]      PC; 
reg  [31:0]      instruction;


always@(posedge clk_i or negedge clk_i) begin
    if (clk_i && !IFID_stall_i) begin
      PC <= PC_i;
      instruction <= IFID_flush_i ? 32'b0 : instruction_i;
    end
    if(!clk_i) begin
      PC_o <= PC;
      instruction_o <= instruction;
    end
end

endmodule