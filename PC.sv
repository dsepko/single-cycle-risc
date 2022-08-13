module PC(
	input logic clk,
	input logic rst,
	input logic [2:0] instruction_A, // address for instruction memory
	input logic RegWrite, MemWrite, // write enable signals for register_file and data_memory
	output logic [31:0] probe_register_file,
	output logic [31:0] probe_data_memory
	);
	logic [31:0] instr;
	instruction_memory im(.clk(clk), .rst(rst), .A(instruction_A), .RD(instr));
	
	logic [4:0] A1;
	assign A1 = instr[25:21];
	
	logic [4:0] A2;
	assign A2 = instr[20:16];
	
	logic [4:0] A3;
	assign A3 = instr[15:11];
	
	logic RegDst;
	assign RegDst = instr[31];
	
	logic ALUSrc;
	assign ALUSrc = instr[30];
	
	logic [2:0] ALUControl;
	assign ALUControl = instr[29:27];
	
	logic MemtoReg;
	assign MemtoReg = instr[26];
	
	logic [31:0] SrcB;
	logic [4:0] RegDst_out;
	logic [31:0] MemtoReg_out;
	logic [31:0] SrcA;
	logic [31:0] RD1;
	logic [31:0] RD2;
	logic [31:0] SignImm;
	logic [31:0] ALUResult;
	logic [31:0] ALUSrc_out;
	logic [31:0] RD;
	logic [31:0] WD3;
	
	sign_extend sign_mux(.Imm(imm), .SignImm(SignImm));
	MUX_RegDst regmux (.RegDst(RegDst), .WriteReg(A3), .rt(A2), .RegDst_out(RegDst_out));
	register_file rf (.clk(clk), .rst(rst), .WE3(RegWrite), .A1(A1), .A2(A2), .A3(RegDst_out),
		.WD3(MemtoReg_out), .RD1(RD1), .RD2(RD2), .probe_rf(probe_register_file));
	MUX_ALUSrc alumux(.ALUSrc(ALUSrc), .SignImm(SignImm), .RD2(RD2), .ALUSrc_out(ALUSrc_out));
	ALU arithlu(.SrcA(RD1),.SrcB(ALUSrc_out), .ALUControl(ALUControl), .ALUResult(ALUResult));
	data_memory dm(.clk(clk), .rst(rst), .A(ALUResult), .WD(RD2), .WE(MemWrite),.RD(RD),.probe_dm(probe_data_memory));
	MUX_MemtoReg memmux(.MemtoReg(MemtoReg), .ALUResult(ALUResult), .RD(RD), .MemtoReg_out(MemtoReg_out));
endmodule