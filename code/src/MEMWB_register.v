module MEMWB_register
(
  input              rst_i,
  input              clk_i,  
  input              RegWrite_i,
  input              MemToReg_i, 
  input  [31:0]      ALUres_i,
  input  [31:0]      ReadData_i,
  input  [4:0]       RegisterRd_i,

  output reg             RegWrite_o,
  output reg             MemToReg_o, 
  output reg [31:0]      ALUres_o,
  output reg [31:0]      ReadData_o,
  output reg [4:0]       RegisterRd_o
);

reg              RegWrite;
reg              MemToReg; 
reg              MemRead;
reg              MemWrite;
reg  [31:0]      ALUres; 
reg  [31:0]      ReadData;
reg  [4:0]       RegisterRd;


always@(posedge clk_i or negedge clk_i) begin
    if (clk_i) begin
      RegWrite <= RegWrite_i;
      MemToReg <= MemToReg_i; 
      ALUres <= ALUres_i;
      ReadData <= ReadData_i;
      RegisterRd <= RegisterRd_i;
    end
    if(!clk_i) begin
      RegWrite_o <= RegWrite;
      MemToReg_o <= MemToReg; 
      ALUres_o <= ALUres;
      ReadData_o <= ReadData;
      RegisterRd_o <= RegisterRd;
    end
end

endmodule