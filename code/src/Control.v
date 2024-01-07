module Control(

  input [6:0]ctrlCode,
  input NoOp,
  output reg [1:0]ALUOp,
  output reg ALUSrc,
  output reg RegWrite,
  output reg MemToReg, 
  output reg MemRead, 
  output reg MemWrite,
  output reg Branch_o
);

always @(*) begin
  if (NoOp == 1'b1) begin
    ALUOp = 2'b00;
    ALUSrc = 0;
    RegWrite = 0;
    MemToReg = 0;
    MemRead = 0;
    MemWrite = 0;
    Branch_o = 0;
  end else begin
    if (ctrlCode == 7'b0110011) begin
      // and xor sll add sub mul
      ALUSrc = 0;
      ALUOp = 2'b10;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      MemToReg = 0;
      Branch_o = 0;
    end else if (ctrlCode == 7'b0100011) begin
      // sw
      ALUSrc = 1;
      ALUOp = 2'b00;
      RegWrite = 0;
      MemRead = 0;
      MemWrite = 1;
      MemToReg = 0;
      Branch_o = 0;
    end else if (ctrlCode == 7'b1100011) begin
      // beq
      ALUSrc = 0;
      ALUOp = 2'b01;
      RegWrite = 0;
      MemRead = 0;
      MemWrite = 0;
      MemToReg = 0;
      Branch_o = 1;
    end else if (ctrlCode == 7'b0010011) begin 
      // addi srai
      ALUSrc = 1;
      ALUOp = 2'b11; // The only diff, originally it should be 10
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      MemToReg = 0;
      Branch_o = 0;
    end else if (ctrlCode == 7'b0000011) begin 
      // lw
      ALUSrc = 1;
      ALUOp = 2'b00;
      RegWrite = 1;
      MemRead = 1;
      MemWrite = 0;
      MemToReg = 1;
      Branch_o = 0;
    end else begin
      ALUSrc = 0;
      ALUOp = 2'b00;
      RegWrite = 0;
      MemRead = 0;
      MemWrite = 0;
      MemToReg = 0;
      Branch_o = 0;
    end
  end
end

  // assign ALUOp = (ctrlCode[5] ? 2'b10 : 2'b00);
  // assign ALUSrc = (~ctrlCode[5]);
  // assign RegWrite = 1;

endmodule