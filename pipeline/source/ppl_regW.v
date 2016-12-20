module ppl_regW (clk, reset,
                mWriteReg, mMem2Reg, mAlu, mMemOut, mReg,
                wWriteReg, wDataImm, wReg);
    input           clk, reset;

    input           mWriteReg, mMem2Reg;
    input   [4:0]   mReg;
    input   [31:0]  mAlu, mMemOut;

    output          wWriteReg;
    reg             wWriteReg;
    output  [4:0]   wReg;
    reg     [4:0]   wReg;
    output  [31:0]  wDataImm;
    reg     [31:0]  wDataImm;

    wire    [31:0]  wdi;
    mux2x32 writeBackSelect (mAlu, mMemOut, mMem2Reg, wdi);

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            wWriteReg <= 0;
            wDataImm <= 0;
            wReg <= 0;
        end else begin
            wWriteReg <= mWriteReg;
            wDataImm <= wdi;
            wReg <= mReg;
        end
    end
endmodule // ppl_regW
