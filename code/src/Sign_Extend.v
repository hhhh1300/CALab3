module Sign_Extend
(
  input [31:0] im,
  output reg [31:0] extended_im
);

// assign extended_im[31:12] = im[11] ? 20'b11111111111111111111 : 20'b00000000000000000000;

always @(*) begin
  if (im[6:0] == 7'b0010011 || im[6:0] == 7'b0000011) begin
    extended_im[11:0] = im[31:20];
  end else if (im[6:0] == 7'b0100011) begin
    extended_im[4:0] = im[11:7];
    extended_im[11:5] = im[31:25];
  end else if (im[6:0] == 7'b1100011) begin
    extended_im[3:0] = im[11:8];
    extended_im[10] = im[7];
    extended_im[9:4] = im[30:25];
    extended_im[11] = im[31];
  end
  extended_im[31:12] = extended_im[11] ? 20'b11111111111111111111 : 20'b00000000000000000000;
end

endmodule