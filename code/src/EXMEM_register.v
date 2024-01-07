module EXMEM_register
(
  input              rst_i,
  input              clk_i,  
  input              RegWrite_i,
  input              MemToReg_i, 
  input              MemRead_i, 
  input              MemWrite_i,
  input  [31:0]      ALUres_i,
  input  [31:0]      RS2data_i,
  input  [4:0]       RegisterRd_i,

  output reg             RegWrite_o,
  output reg             MemToReg_o, 
  output reg             MemRead_o, 
  output reg             MemWrite_o,
  output reg [31:0]      ALUres_o,
  output reg [31:0]      RS2data_o,
  output reg [4:0]       RegisterRd_o
);

reg              RegWrite;
reg              MemToReg; 
reg              MemRead;
reg              MemWrite;
reg  [31:0]      ALUres; 
reg  [31:0]      RS2data;
reg  [4:0]       RegisterRd;


always@(posedge clk_i or negedge clk_i) begin
    if (clk_i) begin
      RegWrite <= RegWrite_i;
      MemToReg <= MemToReg_i; 
      MemRead <= MemRead_i; 
      MemWrite <= MemWrite_i;
      ALUres <= ALUres_i;
      RS2data <= RS2data_i;
      RegisterRd <= RegisterRd_i;
    end
    if(!clk_i) begin
      RegWrite_o <= RegWrite;
      MemToReg_o <= MemToReg; 
      MemRead_o <= MemRead; 
      MemWrite_o <= MemWrite;
      ALUres_o <= ALUres;
      RS2data_o <= RS2data;
      RegisterRd_o <= RegisterRd;
    end
end

endmodule