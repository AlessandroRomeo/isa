//`timescale 1ns

module tb_main ();

   wire CLK_i;
   wire RST_n_i;
    
   wire IMEM_READ_i;
   wire IMEM_WRITE_i;
   wire [31:0] IMEM_ADDR_i;
   wire [31:0] IMEM_IN_i;
   wire [31:0] IMEM_OUT_i;

   wire DMEM_READ_i;
   wire DMEM_WRITE_i;
   wire [31:0] DMEM_ADDR_i;
   wire [31:0] DMEM_IN_i;
   wire [31:0] DMEM_OUT_i;

assign IMEM_WRITE_i = 0; 
assign IMEM_IN_i = 0; 


   clk_gen CG(.END_SIM(END_SIM_i),
  	      .CLK(CLK_i),
	      .RST_n(RST_n_i));

   main UUT(.clk(CLK_i),
	     .rst_n(RST_n_i),
	     .I_mem_out(IMEM_OUT_i),
	     .D_mem_out(DMEM_OUT_i),
	     .I_mem_addr(IMEM_ADDR_i),
         .I_mem_read(IMEM_READ_i),
	     .D_mem_addr(DMEM_ADDR_i),
	     .D_mem_in(DMEM_IN_i),
	     .D_mem_read(DMEM_READ_i),
	     .D_mem_write(DMEM_WRITE_i));

  data_mem DATA_MEM(.clk(CLK_i),
			   .memRead(DMEM_READ_i),
			   .memWrite(DMEM_WRITE_i),
               .address(DMEM_ADDR_i[6:0]),
               .mem_in(DMEM_IN_i),
               .mem_out(DMEM_OUT_i));

  instr_mem INSTR_MEM(.clk(CLK_i),
			   .memRead(IMEM_READ_i),
			   .memWrite(IMEM_WRITE_i),
               .address(IMEM_ADDR_i[6:0]),
               .mem_in(IMEM_IN_i),
               .mem_out(IMEM_OUT_i));

endmodule

		   
