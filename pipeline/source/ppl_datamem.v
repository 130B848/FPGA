module ppl_datamem (addr, dataIn, dataOut, mWriteMem, clk, mem_clk);
    input           mWriteMem, clk, mem_clk;
    input   [31:0]  addr, dataIn;

    output  [31:0]  dataOut;
    wire    [31:0]  dataOut;

   wire           dmem_clk;
   wire           write_enable;
   assign         write_enable = mWriteMem & ~clk;

   assign         dmem_clk = mem_clk & (~clk) ;

   lpm_ram_dq_dram  dram(addr[6:2], dmem_clk, dataIn, write_enable, dataOut);
endmodule // ppl_datamem
