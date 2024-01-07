module ALU
(
  input                   branch_i,
  input [2:0]             ALUctrl,
  input signed [31:0]     readData1,
  input signed [31:0]     readData2,
  output reg [31:0]       ALUres,
  output reg              predict_o
);
reg [31:0] data_o;
//add 000, sub 001, and 010, xor 011, sll 100, mul 101, srai 110, addi 111

always @(*) begin
  case(ALUctrl)
    3'b000: ALUres = readData1 + readData2;
    3'b001: ALUres = readData1 - readData2;
    3'b010: ALUres = readData1 & readData2;
    3'b011: ALUres = readData1 ^ readData2;
    3'b100: ALUres = readData1 << readData2;
    3'b101: ALUres = readData1 * readData2;
    3'b110: ALUres = readData1 >>> readData2[4:0];
    3'b111: ALUres = readData1 + readData2;
    default: ALUres = 32'b0;
  endcase
  data_o = ALUres; 
  if (branch_i) begin
    if (ALUres == 32'b0) begin
      predict_o = 1;
    end else begin
      predict_o = 0;
    end
  end
end

endmodule