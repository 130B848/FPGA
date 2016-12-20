module sc_datamem (addr, datain, dataout, we, clock, mem_clk, dmem_clk,in_port,
out0,out1,out2,out3,out4,out5);
 
   input  [31:0]  addr;
   input  [31:0]  datain;
	input 			we, clock, mem_clk;
	input	 [7:0]	in_port;
   
   output [31:0]  dataout;
   output         dmem_clk;
	output [3:0]	out0,out1,out2,out3,out4,out5;
   
	wire 	 [31:0]	dataout;
   wire           dmem_clk; 
   
   wire           write_enable; 
	wire				write_datamem_enable;
	wire	 [31:0]  mem_dataout;
	
	assign			dmem_clk = mem_clk & (~clock);
   assign         write_enable = we & ~clock; 
   assign			write_datamem_enable = write_enable & (~addr[7]);
	assign			write_io_output_reg_enable = write_enable & (addr[7]);
	
	mux2x32	mem_io_dataout_mux(mem_dataout, io_read_data, addr[7], dataout);
   
   lpm_ram_dq_dram  dram(addr[6:2],dmem_clk,datain,write_enable,mem_dataout );
										
	io_input_reg	io_input_regx2(addr, dmem_clk, io_read_data, in_port);
	
	io_output_reg  io_output_regx2 (addr,datain,write_io_output_reg_enable,dmem_clk,clrn,out0,out1,out2,out3,out4,out5,in_port);
endmodule 