module register_file(
	input logic clk,
	input logic rst,
	input logic WE3, // WE3=1, write register file
	input logic [4:0] A1,A2,A3, // address input
	input logic [31:0] WD3, //data from data memory
	output logic [31:0] RD1, // output port 1 for regfile, lw operation
	output logic [31:0] RD2, // output port 2 for regfile, add or sub operation
	output logic [31:0] probe_rf
	);
	reg [31:0] rf[31:0];
	always@(posedge clk or negedge rst)
		begin
			if(!rst)
			begin
				for(int i=0; i<32; i++)
				begin
					rf[i] <= i;
				end
			end
			else
				begin
					RD1 = rf[A1];
					RD2 = rf[A2];
						if(WE3)
							rf[A3] <= WD3;
				end
		end
		assign probe_rf = rf[A3];
endmodule