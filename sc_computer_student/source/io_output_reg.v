module io_output_reg (addr,datain,write_io_enable,io_clk,clrn,out_port0, out_port1, out_port2, out_port3, out_port4, out_port5,in_port);
	input   [31:0]  addr, datain; 
	input           write_io_enable,io_clk; 
	input           clrn;        //reset signal. if necessary,can use this signal to reset the output to 0. 
	output  [3:0]  out_port0, out_port1, out_port2, out_port3, out_port4, out_port5;
	
	input [7:0] in_port;
	
	reg     [3:0]  out_port0, out_port1, out_port2, out_port3, out_port4, out_port5; 
	
	always@(posedge io_clk or negedge clrn) begin           
		if (clrn == 0) begin                 // reset                 
			out_port0 <= 0;                 
			out_port1 <= 0;      // reset all the output port to 0.             
		end else begin
			if (write_io_enable == 1) begin
				case (addr[7:2])
					6'b110000: out_port4 <= datain;   // 80h                       
					6'b110001: out_port5 <= datain;   // 84h 
					// more ports，可根据需要设计更多的输出端口                 
				endcase
			end
		end
		out_port0 <= ((in_port[0] << 3) + (in_port[1] << 2) + (in_port[2] << 1) + in_port[3]) / 10;
		out_port1 <= ((in_port[0] << 3) + (in_port[1] << 2) + (in_port[2] << 1) + in_port[3]) % 10;;
		out_port2 <= ((in_port[4] << 3) + (in_port[5] << 2) + (in_port[6] << 1) + in_port[7]) / 10;
		out_port3 <= ((in_port[4] << 3) + (in_port[5] << 2) + (in_port[6] << 1) + in_port[7]) % 10;
	end
endmodule
