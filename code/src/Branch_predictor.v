// a two bit branch predictor
module Branch_predictor
(
  input         branch_i,
  input         branch_taken_i,
  input         branch_taken_valid_i,
  output reg    prediction_o
);
//2'b00: Strongly taken, 2'b01: Weakly taken, 2'b10: Weakly not taken, 2'b11: Strongly not taken
reg [1:0] state = 2'b00;
reg predict_o;


always @(branch_i or branch_taken_i or branch_taken_valid_i) begin
  if (branch_taken_valid_i) begin
    if (state == 2'b00) begin
      state <= branch_taken_i ? 2'b00 : 2'b01;
    end else if (state == 2'b01) begin
      state <= branch_taken_i ? 2'b00 : 2'b10;
    end else if (state == 2'b10) begin
      state <= branch_taken_i ? 2'b01 : 2'b11;
    end else if (state == 2'b11) begin
      state <= branch_taken_i ? 2'b10 : 2'b11;
    end
  end
    predict_o <= (state == 2'b00 || state == 2'b01) ? 1 : 0;
    if (branch_i) begin
      prediction_o <= (state == 2'b00 || state == 2'b01) ? 1 : 0;
    end else begin
      prediction_o <= 0;
    end
end


endmodule