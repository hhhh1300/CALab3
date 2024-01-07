// `include "./supplied/PC.v"
// `include "./supplied/Instruction_Memory.v"
// `include "./supplied/Register.v"

module CPU
(
    clk_i, 
    rst_i,
);

// Ports
input               clk_i;
input               rst_i;

// Wires & Registers
wire  [31:0]      instr_o;
wire  [31:0]      pc_i;
wire  [31:0]      pc_o;
wire  [31:0]      IFID_PC_o;
wire  [1:0]       IDEX_ALUOp;
wire  [1:0]       IDEX_ALUOp_o;
wire              IDEX_ALUSrc;
wire              IDEX_ALUSrc_o;
wire              IDEX_RegWrite;
wire              IDEX_RegWrite_o;
wire              IDEX_MemToReg;
wire              IDEX_MemToReg_o;
wire              IDEX_MemRead;
wire              IDEX_MemRead_o;
wire              IDEX_MemWrite;
wire              IDEX_MemWrite_o;
wire              IDEX_branch;
wire              IDEX_branch_o;
wire              IDEX_BranchPredict;
wire              IDEX_BranchPredict_o;
wire  [31:0]      IDEX_Branch_PC;
wire  [31:0]      IDEX_Branch_PC_o;
wire  [31:0]      IDEX_RS1data; 
wire  [31:0]      IDEX_RS1data_o; 
wire  [31:0]      IDEX_RS2data;
wire  [31:0]      IDEX_RS2data_o;
wire  [31:0]      IDEX_extended_im_o;
wire  [6:0]       IDEX_func7_o;
wire  [2:0]       IDEX_func3_o;
wire  [4:0]       IDEX_RegisterR1_o;
wire  [4:0]       IDEX_RegisterR2_o;
wire  [4:0]       IDEX_RegisterRd_o;
wire  [31:0]      IDEX_PC_o;
wire              EXMEM_RegWrite;
wire              EXMEM_MemtoReg;
wire              EXMEM_RegWrite_o;
wire              EXMEM_MemToReg_o;
wire              EXMEM_MemRead_o;
wire              EXMEM_MemWrite_o;
wire  [31:0]      EXMEM_ALUres_o;
wire  [31:0]      EXMEM_RS2data_o;
wire  [4:0]       EXMEM_RegisterRd_o;
wire              MEMWB_RegWrite_o;
wire              MEMWB_MemToReg_o;
wire  [31:0]      MEMWB_ALUres_o;
wire  [31:0]      MEMWB_ReadData_o;
wire  [4:0]       MEMWB_RegisterRd_o;


// wire  [31:0]      RS2data_o;
wire  [31:0]      extended_im;
wire  [2:0]       ALUctrl;
wire  [31:0]      ALUres;
wire              ALU_predict_o;            
wire              Branch_predictor_predict_o;            
wire              Xor_EXpredict_IDpredict_data_o;            
wire              And_IDEXBranch_Xor_data_o;            

wire              ID_FlushIF;
wire              PCWrite;
wire              stall;
wire              NoOp;
wire  [31:0]      Add_PC_pc_o;
wire  [31:0]      Branch_PC_o;
wire  [31:0]      MUX_PC_o;
wire  [31:0]      MUX_branch_o;
// wire  [31:0]      PC_o;
wire  [31:0]      MUX_WB_o;
wire  [31:0]      MUX_ALUSrc_o;
wire  [31:0]      Register_RS1data_o;
wire  [31:0]      Register_RS2data_o;
wire              And_rd1_rd2_branch_data_o;
wire  [31:0]      Instruction_Memory_instr_o;
wire  [31:0]      Sign_Extend_extended_im;
wire  [31:0]      Data_Memory_data_o;
wire  [31:0]      ALU_ALUres;
wire  [2:0]       ALU_ALUctrl;
wire  [31:0]      MUX3_RD1_data_o;
wire  [31:0]      MUX3_RD2_data_o;
wire  [1:0]       MUX3_RD1_signal;
wire  [1:0]       MUX3_RD2_signal;
// wire              MEMWB_RegWrite_o;
// wire  [4:0]       MEMWB_register_RegisterRd_o;

// reg               And_rd1_rd2_branch_data_o_reg = 1'b0;
reg               Branch_predictor_predict_o_reg = 1'b0;
reg               Xor_EXpredict_IDpredict_data_o_reg = 1'b0;
reg               And_IDEXBranch_Xor_data_o_reg = 1'b0;
reg               PCWrite_reg = 1'b1;
reg               stall_reg = 1'b0;
reg               NoOp_reg = 1'b0;
reg               MEMWB_RegWrite_o_reg = 1'b0;
// always @(And_rd1_rd2_branch_data_o) begin
// 	And_rd1_rd2_branch_data_o_reg <= And_rd1_rd2_branch_data_o;
// end
always @(Branch_predictor_predict_o) begin
	Branch_predictor_predict_o_reg <= Branch_predictor_predict_o;
end
always @(Xor_EXpredict_IDpredict_data_o) begin
	Xor_EXpredict_IDpredict_data_o_reg <= Xor_EXpredict_IDpredict_data_o;
end
always @(And_IDEXBranch_Xor_data_o) begin
	And_IDEXBranch_Xor_data_o_reg <= And_IDEXBranch_Xor_data_o;
end
always @(PCWrite) begin
	PCWrite_reg <= PCWrite;
end
always @(stall) begin
	stall_reg <= stall;
end
always @(NoOp) begin
	NoOp_reg <= NoOp;
end
always @(MEMWB_RegWrite_o) begin
	MEMWB_RegWrite_o_reg <= MEMWB_RegWrite_o;
end
assign ID_FlushIF = And_rd1_rd2_branch_data_o;

Control Control(
    .ctrlCode (instr_o[6:0]), 
    .NoOp (NoOp_reg),
    .ALUOp (IDEX_ALUOp), 
    .ALUSrc (IDEX_ALUSrc), 
    .RegWrite (IDEX_RegWrite), 
    .MemToReg (IDEX_MemToReg), 
    .MemRead (IDEX_MemRead), 
    .MemWrite (IDEX_MemWrite), 
    .Branch_o (IDEX_branch)
);

PCAdder Add_PC(
    .pc_o (Add_PC_pc_o), 
    .pc_i (pc_o)
);

Adder Branch_PC (
    .src1 (Sign_Extend_extended_im << 1),
    .src2 (IFID_PC_o),
    .AdderRes (Branch_PC_o)
);

MUX32 MUX_branch(
    .ALUSrc (And_IDEXBranch_Xor_data_o_reg),
    .readData1 (Branch_PC_o),
    .im (IDEX_Branch_PC_o),
    .readData2 (MUX_branch_o)
);

MUX32 MUX_PC(
    .ALUSrc (And_IDEXBranch_Xor_data_o_reg ? !IDEX_BranchPredict_o : Branch_predictor_predict_o_reg),
    .readData1 (And_IDEXBranch_Xor_data_o_reg ? IDEX_PC_o+4 : Add_PC_pc_o),
    .im (MUX_branch_o),
    .readData2 (MUX_PC_o)
);

PC PC(
    .rst_i (rst_i), 
    .clk_i (clk_i), 
    .PCWrite_i (PCWrite_reg),
    .pc_i (MUX_PC_o), 
    .pc_o (pc_o)
);

Instruction_Memory Instruction_Memory(
    .addr_i (pc_o), 
    .instr_o (Instruction_Memory_instr_o)
);

Registers Registers(
    .rst_i (rst_i), 
    .clk_i (clk_i), 
    .RS1addr_i (instr_o[19:15]), 
    .RS2addr_i (instr_o[24:20]), 
    .RDaddr_i (MEMWB_RegisterRd_o), 
    .RDdata_i (MUX_WB_o), 
    .RegWrite_i (MEMWB_RegWrite_o_reg), 
    .RS1data_o (Register_RS1data_o), 
    .RS2data_o (Register_RS2data_o)
);

MUX32 MUX_ALUSrc(
    .ALUSrc (IDEX_ALUSrc_o),
    .readData1 (MUX3_RD2_data_o),
    .im (IDEX_extended_im_o),
    .readData2 (MUX_ALUSrc_o)
);

MUX32 MUX_WB(
    .ALUSrc (MEMWB_MemToReg_o),
    .readData1 (MEMWB_ALUres_o),
    .im (MEMWB_ReadData_o),
    .readData2 (MUX_WB_o)
);


Sign_Extend Sign_Extend(
    .im (instr_o[31:0]),
    .extended_im (Sign_Extend_extended_im)
);
  
ALU ALU(
    .branch_i (IDEX_branch_o),
    .ALUctrl (ALU_ALUctrl), 
    .readData1 (MUX3_RD1_data_o), 
    .readData2 (MUX_ALUSrc_o),
    .ALUres (ALU_ALUres),
    .predict_o (ALU_predict_o)
);

ALU_Control ALU_Control(
    .ALUOp (IDEX_ALUOp_o), 
    .func7 (IDEX_func7_o), 
    .func3 (IDEX_func3_o), 
    .ALUctrl (ALU_ALUctrl)
);

MUX3 MUX3_RD1 (
    .data1_i (IDEX_RS1data_o),
    .data2_i (MUX_WB_o),
    .data3_i (EXMEM_ALUres_o),
    .signal (MUX3_RD1_signal),
    .data_o (MUX3_RD1_data_o)
);

MUX3 MUX3_RD2 (
    .data1_i (IDEX_RS2data_o),
    .data2_i (MUX_WB_o),
    .data3_i (EXMEM_ALUres_o),
    .signal (MUX3_RD2_signal),
    .data_o (MUX3_RD2_data_o)
);

ForwardingUnit ForwardingUnit (
    .IDEX_Rs1 (IDEX_RegisterR1_o),
    .IDEX_Rs2 (IDEX_RegisterR2_o),
    .EXMEM_RegWrite (EXMEM_RegWrite_o),
    .EXMEM_Rd (EXMEM_RegisterRd_o),
    .MEMWB_RegWrite (MEMWB_RegWrite_o),
    .MEMWB_Rd (MEMWB_RegisterRd_o),

    .ForwardA (MUX3_RD1_signal),
    .ForwardB (MUX3_RD2_signal)
);

Data_Memory Data_Memory(
    .clk_i (clk_i),
    .addr_i (EXMEM_ALUres_o),
    .MemRead_i (EXMEM_MemRead_o),
    .MemWrite_i (EXMEM_MemWrite_o),  
    .data_i (EXMEM_RS2data_o),
    .data_o (Data_Memory_data_o)
);

HazardDetectingUnit Hazard_Detection(
    .IFID_Rs1 (instr_o[19:15]), 
    .IFID_Rs2 (instr_o[24:20]),
    .IDEX_MemRead (IDEX_MemRead_o),
    .IDEX_Rd (IDEX_RegisterRd_o),
    .PCWrite (PCWrite),
    .NoOp (NoOp),
    .Stall_o (stall)
);

And And_rd1_rd2_branch(
    .data1_i (IDEX_branch),
    .data2_i ((Register_RS1data_o == Register_RS2data_o ? 1'b1 : 1'b0)),
    .data_o (And_rd1_rd2_branch_data_o)
);

And And_IDEXBranch_Xor(
    .data1_i (IDEX_branch_o),
    .data2_i (Xor_EXpredict_IDpredict_data_o_reg),
    .data_o (And_IDEXBranch_Xor_data_o)
);


Xor Xor_EXpredict_IDpredict(
    .data1_i (ALU_predict_o),
    .data2_i (IDEX_BranchPredict_o),
    .data_o (Xor_EXpredict_IDpredict_data_o) // 1 if the prev prediction is wrong
);

Branch_predictor branch_predictor(
    .branch_i (IDEX_branch),
    .branch_taken_i (ALU_predict_o),
    .branch_taken_valid_i (IDEX_branch_o),
    .prediction_o (Branch_predictor_predict_o)
);

IFID_register IF_ID(
    .rst_i (rst_i),
    .clk_i (clk_i),

    .IFID_stall_i (stall_reg),
    .IFID_flush_i (Branch_predictor_predict_o_reg || And_IDEXBranch_Xor_data_o_reg),
    .flush_i (Branch_predictor_predict_o_reg || And_IDEXBranch_Xor_data_o_reg),
    .PC_i (pc_o),
    .instruction_i (Instruction_Memory_instr_o),

    .PC_o (IFID_PC_o),
    .instruction_o (instr_o)
);

IDEX_register ID_EX(
    .rst_i (rst_i),
    .clk_i (clk_i),
    .PC_i (IFID_PC_o),
    .RegWrite_i (IDEX_RegWrite),
    .MemToReg_i (IDEX_MemToReg),
    .MemRead_i (IDEX_MemRead),
    .MemWrite_i (IDEX_MemWrite),
    .ALUOp_i (IDEX_ALUOp),
    .ALUSrc_i (IDEX_ALUSrc),
    .Branch_i (IDEX_branch),
    .BranchPredict_i (Branch_predictor_predict_o_reg),
    .Branch_PC_i (Branch_PC_o),
    .RS1data_i (Register_RS1data_o),
    .RS2data_i (Register_RS2data_o),
    .extended_im_i (Sign_Extend_extended_im),
    .func7_i (instr_o[31:25]),
    .func3_i (instr_o[14:12]),
    .RegisterR1_i (instr_o[19:15]),
    .RegisterR2_i (instr_o[24:20]),
    .RegisterRd_i (instr_o[11:7]),
    .IDEX_flush_i (And_IDEXBranch_Xor_data_o_reg),

    .PC_o (IDEX_PC_o),
    .RegWrite_o (IDEX_RegWrite_o),
    .MemToReg_o (IDEX_MemToReg_o),
    .MemRead_o (IDEX_MemRead_o),
    .MemWrite_o (IDEX_MemWrite_o),
    .ALUOp_o (IDEX_ALUOp_o),
    .ALUSrc_o (IDEX_ALUSrc_o),
    .Branch_o (IDEX_branch_o),
    .BranchPredict_o (IDEX_BranchPredict_o),
    .Branch_PC_o (IDEX_Branch_PC_o),
    .RS1data_o (IDEX_RS1data_o),
    .RS2data_o (IDEX_RS2data_o),
    .extended_im_o (IDEX_extended_im_o),
    .func7_o (IDEX_func7_o),
    .func3_o (IDEX_func3_o),
    .RegisterR1_o (IDEX_RegisterR1_o),
    .RegisterR2_o (IDEX_RegisterR2_o),
    .RegisterRd_o (IDEX_RegisterRd_o)
);

EXMEM_register EXMEM_register(
    .rst_i (rst_i),
    .clk_i (clk_i),
    .RegWrite_i (IDEX_RegWrite_o),
    .MemToReg_i (IDEX_MemToReg_o),
    .MemRead_i (IDEX_MemRead_o),
    .MemWrite_i (IDEX_MemWrite_o),
    .ALUres_i (ALU_ALUres),
    .RS2data_i (MUX3_RD2_data_o),
    .RegisterRd_i (IDEX_RegisterRd_o),

    .RegWrite_o (EXMEM_RegWrite_o),
    .MemToReg_o (EXMEM_MemToReg_o),
    .MemRead_o (EXMEM_MemRead_o),
    .MemWrite_o (EXMEM_MemWrite_o),
    .ALUres_o (EXMEM_ALUres_o),
    .RS2data_o (EXMEM_RS2data_o),
    .RegisterRd_o (EXMEM_RegisterRd_o)
);

MEMWB_register MEMWB_register(
    .rst_i (rst_i),
    .clk_i (clk_i),
    .RegWrite_i (EXMEM_RegWrite_o),
    .MemToReg_i (EXMEM_MemToReg_o),
    .ALUres_i (EXMEM_ALUres_o),
    .ReadData_i (Data_Memory_data_o),
    .RegisterRd_i (EXMEM_RegisterRd_o),

    .RegWrite_o (MEMWB_RegWrite_o),
    .MemToReg_o (MEMWB_MemToReg_o),
    .ALUres_o (MEMWB_ALUres_o),
    .ReadData_o (MEMWB_ReadData_o),
    .RegisterRd_o (MEMWB_RegisterRd_o)
);

endmodule

