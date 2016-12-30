`timescale  1ps / 1ps

module y86_ppl;
    reg             reset_sim, half_mem_clk_sim;
    reg    [9:0]    switches_sim;

    wire   [6:0]    hex0_sim,hex1_sim,hex2_sim,hex3_sim,hex4_sim,hex5_sim;
    wire   [9:0]    leds_sim;

    initial begin
        switches_sim <= 31'h0;
    end
	 
//    initial begin
//        half_mem_clk_sim <= 1;
//        while (1) begin
//            #1  half_mem_clk_sim <= ~half_mem_clk_sim;
//        end
//    end


//    initial begin
//       reset_sim <= 0;            // 低电平持续10个时间单位，后一直为1。
//       while (1) begin
//           #5 reset_sim <= 1;
//        end
//    end
	 
    y86_cpu cpu (
        half_mem_clk_sim, reset_sim,
        switches_sim, hex0_sim, hex1_sim, hex2_sim, hex3_sim, hex4_sim, hex5_sim, leds_sim
    );


endmodule // y86_ppl
