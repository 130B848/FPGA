module ppl_fetch (clk,
                pcSrc, pcIn, branchAddr, jrAddr, jalAddr,
                pc4, pcOut, instOut);
    input           clk;
    input   [1:0]   pcSrc;
    input   [31:0]  pcIn, branchAddr, jrAddr, jalAddr;

    output  [31:0]  pc4, pcOut, instOut;

    assign pc4 = pcIn + 31'h4;
    mux4x32 selectPc(pc4, branchAddr, jrAddr, jalAddr, pcSrc, pcOut);

    wire            mem_clk;
    assign mem_clk = ~clk;
    ppl_instmem imem(pcIn, instOut, mem_clk);
endmodule // ppl_fetch
