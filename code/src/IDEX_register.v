module IDEX_register
(
  input              rst_i,
  input              clk_i,  
  input  [31:0]      PC_i,
  input              RegWrite_i,
  input              MemToReg_i, 
  input              MemRead_i, 
  input              MemWrite_i,
  input  [1:0]       ALUOp_i,
  input              ALUSrc_i,
  input              Branch_i,
  input              BranchPredict_i,
  input  [31:0]      Branch_PC_i,
  input  [31:0]      RS1data_i, 
  input  [31:0]      RS2data_i,
  input  [31:0]      extended_im_i,
  input  [6:0]       func7_i,
  input  [2:0]       func3_i,
  input  [4:0]       RegisterR1_i,
  input  [4:0]       RegisterR2_i,
  input  [4:0]       RegisterRd_i,
  input              IDEX_flush_i,

  output reg [31:0]      PC_o,
  output reg             RegWrite_o,
  output reg             MemToReg_o, 
  output reg             MemRead_o, 
  output reg             MemWrite_o,
  output reg [1:0]       ALUOp_o,
  output reg             ALUSrc_o,
  output reg             Branch_o,
  output reg             BranchPredict_o,
  output reg [31:0]      Branch_PC_o,
  output reg [31:0]      RS1data_o, 
  output reg [31:0]      RS2data_o,
  output reg [31:0]      extended_im_o,
  output reg [6:0]       func7_o,
  output reg [2:0]       func3_o,
  output reg [4:0]       RegisterR1_o,
  output reg [4:0]       RegisterR2_o,
  output reg [4:0]       RegisterRd_o
);

reg  [31:0]      PC;
reg              RegWrite;
reg              MemToReg; 
reg              MemRead; 
reg              MemWrite;
reg  [1:0]       ALUOp;
reg              ALUSrc;
reg              Branch;
reg              BranchPredict;
reg  [31:0]      Branch_PC;
reg  [31:0]      RS1data; 
reg  [31:0]      RS2data;
reg  [31:0]      extended_im;
reg  [6:0]       func7;
reg  [2:0]       func3;
reg  [4:0]       RegisterR1;
reg  [4:0]       RegisterR2;
reg  [4:0]       RegisterRd;


always@(posedge clk_i or negedge clk_i) begin
    if (clk_i) begin
      PC <= PC_i;
      RegWrite <= RegWrite_i;
      MemToReg <= MemToReg_i; 
      MemRead <= MemRead_i; 
      MemWrite <= MemWrite_i;
      ALUOp <= ALUOp_i;
      ALUSrc <= ALUSrc_i;
      Branch <= Branch_i;
      BranchPredict <= BranchPredict_i;
      Branch_PC <= Branch_PC_i;
      RS1data <= RS1data_i; 
      RS2data <= RS2data_i;
      extended_im <= extended_im_i;
      func7 <= func7_i;
      func3 <= func3_i;
      RegisterR1 <= RegisterR1_i;
      RegisterR2 <= RegisterR2_i;
      RegisterRd <= RegisterRd_i;
      if (IDEX_flush_i) begin
        PC <= 32'b0;
        RegWrite <= 0;
        MemToReg <= 0; 
        MemRead <= 0; 
        MemWrite <= 0;
        ALUOp <= 2'b00;
        ALUSrc <= 0;
        Branch <= 0;
        BranchPredict <= 0;
        Branch_PC <= 32'b0;
        RS1data <= 32'b0; 
        RS2data <= 32'b0;
        extended_im <= 32'b0;
        func7 <= 7'b0;
        func3 <= 3'b0;
        RegisterR1 <= 5'b0;
        RegisterR2 <= 5'b0;
        RegisterRd <= 5'b0;
      end
    end
    if(!clk_i) begin
      PC_o <= PC;
      RegWrite_o <= RegWrite;
      MemToReg_o <= MemToReg; 
      MemRead_o <= MemRead; 
      MemWrite_o <= MemWrite;
      ALUOp_o <= ALUOp;
      ALUSrc_o <= ALUSrc;
      Branch_o <= Branch;
      BranchPredict_o <= BranchPredict;
      Branch_PC_o <= Branch_PC;
      RS1data_o <= RS1data; 
      RS2data_o <= RS2data;
      extended_im_o <= extended_im;
      func7_o <= func7;
      func3_o <= func3;
      RegisterR1_o <= RegisterR1;
      RegisterR2_o <= RegisterR2;
      RegisterRd_o <= RegisterRd;
    end
end

endmodule