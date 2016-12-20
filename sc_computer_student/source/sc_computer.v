/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer (resetn,clock,mem_clk,pc,inst,aluout,memout,imem_clk,dmem_clk,in_port,
			hex0, hex1, hex2, hex3, hex4, hex5);
   
   input resetn,clock,mem_clk;
   output [31:0] pc,inst,aluout,memout;
   output        imem_clk,dmem_clk;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
	
	input 	[7:0]		in_port;
	output	[6:0]		hex0, hex1, hex2, hex3, hex4, hex5;
	
	wire		[3:0]		minute_display_high;
	wire		[3:0]		minute_display_low;
	wire		[3:0]		second_display_high;
	wire		[3:0]		second_display_low;
	wire		[3:0]		msecond_display_high;
	wire		[3:0]		msecond_display_low;
	
	sevenseg LED8_minute_display_high(minute_display_high, hex5);
	sevenseg LED8_minute_display_low(minute_display_low, hex4);
	sevenseg LED8_second_display_high(second_display_high, hex3);
	sevenseg LED8_second_display_low(second_display_low, hex2);
	sevenseg LED8_msecond_display_high(msecond_display_high, hex1);
	sevenseg LED8_msecond_display_low(msecond_display_low, hex0);
	
	reg 			double_clock;
	
	initial begin
	  double_clock = 0;
	 end
	
	always @ (posedge clock) begin
		double_clock = ~double_clock;
	end
   
   sc_cpu cpu (clock,resetn,inst,memout,pc,wmem,aluout,data);          // CPU module.
   sc_instmem  imem (pc,inst,clock,double_clock,imem_clk);                  // instruction memory.
   sc_datamem  dmem (aluout,data,memout,wmem,clock,double_clock,dmem_clk,in_port,
			minute_display_high,minute_display_low,second_display_high,second_display_low,msecond_display_high,msecond_display_low); // data memory.

endmodule
