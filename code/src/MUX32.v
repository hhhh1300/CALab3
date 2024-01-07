module MUX32 (
  input ALUSrc,
  input[31:0] readData1,
  input[31:0] im,
  output[31:0] readData2
);
  assign readData2 = ALUSrc ? im : readData1;

endmodule