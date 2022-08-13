module MUX_RegDst(
	input logic RegDst,
	input logic [4:0] WriteReg,
	input logic [4:0] rt,
	output logic [4:0] RegDst_out
	);
	assign RegDst_out = RegDst ? WriteReg : rt;
endmodule