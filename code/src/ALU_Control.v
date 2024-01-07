module ALU_Control
(
  input [1:0]ALUOp,
  input [6:0]func7,
  input [2:0]func3,
  output reg [2:0]ALUctrl
);

//add 000, sub 001, and 010, xor 011, sll 100, mul 101, srai 110, addi 111
  
always @(*) begin
  if (ALUOp[1]) begin
    if (ALUOp[0] == 1) begin
      //addi srai
      if (func3[2]) begin
        //srai: 110
        ALUctrl = 3'b110;
      end else begin
        //addi: 111
        ALUctrl = 3'b111;
      end
    end else begin
      if (func7[5]) begin
        //sub
        ALUctrl = 3'b001;
      end else if (func7[0]) begin
        //mul
        ALUctrl = 3'b101;
      end else begin
        if (func3[2]) begin
          if (func3[1]) begin
            //and
            ALUctrl = 3'b010;
          end else begin
            //xor
            ALUctrl = 3'b011;
          end
        end else begin
          if (func3[0]) begin
            //sll
            ALUctrl = 3'b100;
          end else begin
            //add
            ALUctrl = 3'b000;
          end
        end
      end
    end
  end else begin
    if (ALUOp[0] == 1) begin
    //beq (sub)
      ALUctrl = 3'b001;
    end else begin
    //sw lw (addi)
      ALUctrl = 3'b111;
    end

    // //addi srai
    // if (func3[2]) begin
    //   //srai: 110
    //   ALUctrl = 3'b110;
    // end else begin
    //   //addi: 111
    //   ALUctrl = 3'b111;
    // end
  end
end

endmodule