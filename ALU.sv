module ALU(
	input logic [31:0] SrcA,
	input logic [31:0] SrcB,
	input logic [2:0] ALUControl,
	output logic [31:0] ALUResult
	);
	logic [31:0] sum, SrcBout;
	assign SrcBout = ALUControl[2] ? ~SrcB : SrcB;
	assign sum = SrcA + SrcBout + ALUControl[2];
	assign ALUResult = sum;
endmodule