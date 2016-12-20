module ppl_instmem (pcIn, instOut, mem_clk);
    input   [31:0]  pcIn;
    input           mem_clk;

    output  [31:0]  instOut;
    wire    [31:0]  instOut;

   lpm_rom_irom irom (pcIn[7:2], mem_clk, instOut);

endmodule // ppl_instmem
