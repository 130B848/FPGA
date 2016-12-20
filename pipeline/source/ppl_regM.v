module ppl_regM (clk, reset,
                exWriteReg, exMem2Reg, exWriteMem, exAlu, exReg, exDataB,
                mWriteReg, mMem2Reg, mWriteMem, mAlu, mReg, mDataB);
    input           clk, reset;

    input           exWriteReg, exMem2Reg, exWriteMem;
    input   [4:0]   exReg;
    input   [31:0]  exAlu, exDataB;

    output          mWriteReg, mMem2Reg, mWriteMem;
    reg             mWriteReg, mMem2Reg, mWriteMem;
    output  [4:0]   mReg;
    reg     [4:0]   mReg;
    output  [31:0]  mAlu, mDataB;
    reg     [31:0]  mAlu, mDataB;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            mWriteReg <= 0;
            mMem2Reg <= 0;
            mWriteMem <= 0;
            mAlu <= 0;
            mReg <= 0;
            mDataB <= 0;
        end else begin
            mWriteReg <= exWriteReg;
            mMem2Reg <= exMem2Reg;
            mWriteMem <= exWriteMem;
            mAlu <= exAlu;
            mReg <= exReg;
            mDataB <= exDataB;
        end
    end
endmodule // ppl_regM
