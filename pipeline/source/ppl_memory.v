module ppl_memory (clk,
                    mWriteMem, mAlu, mDataB, ioOut,
                    mMemOut);
    input           clk;

    input           mWriteMem;
    input   [31:0]  mAlu, mDataB, ioOut;

    output  [31:0]  mMemOut;

    wire    [31:0]  mmo;
    reg             mem_clk;
    always @ (posedge clk) begin
        mem_clk <= ~mem_clk;
    end
    ppl_datamem dmem (mAlu, mDataB, mmo, mWriteMem, clk, mem_clk);
    mux2x32 memOrIo (mmo, ioOut, mAlu[7], mMemOut);
endmodule // ppl_memory
