module io_input_reg(addr, io_clk, io_read_data, in_port);
	input		[31:0]	addr;
	input					io_clk;
	input		[7:0]		in_port;
	output	[31:0]	io_read_data;
	
	reg		[3:0]		in_reg0,in_reg1;
	
	io_input_mux	io_input_mux2x32(in_reg0, in_reg1, addr[7:2], io_read_data);
	
	always @ (posedge io_clk) begin
		in_reg0 <= in_port[3:0];
		in_reg1 <= in_port[7:4];
	end
endmodule

module io_input_mux(a0, a1, sel_addr, y);
	input		[3:0]	a0, a1;
	input 	[5:0]		sel_addr;
	output	[31:0]	y;
	reg		[31:0]	y;
	
	always @ (*) begin
		y = 0;
		case(sel_addr)
			6'b110000:	y = a0;
			6'b110001:	y = a1;
		endcase
	end
endmodule
