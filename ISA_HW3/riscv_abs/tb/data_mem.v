module data_mem (
	clk,
	memRead,
	memWrite,
	address,
	mem_in,
	mem_out
	);

input  clk, memRead, memWrite;
input [6:0] address;
input [31:0] mem_in;
output [31:0] mem_out;

reg [31:0] mem_out;

always @ (posedge clk)
begin
	mem_out = 32'b00000000000000000000000000000000;
	if (memRead) begin
		case (address)
			7'b0000000 : mem_out = 32'b00000000000000000000000000001010;
			7'b0000100 : mem_out = 32'b11111111111111111111111111010001;
			7'b0001000 : mem_out = 32'b00000000000000000000000000010110;
			7'b0001100 : mem_out = 32'b11111111111111111111111111111101;
			7'b0010000 : mem_out = 32'b00000000000000000000000000001111;
			7'b0010100 : mem_out = 32'b00000000000000000000000000011011;
			7'b0011000 : mem_out = 32'b11111111111111111111111111111100;
			7'b0011100 : mem_out = 32'b00000000000000000000000000000000;
		endcase
	end
end

endmodule
