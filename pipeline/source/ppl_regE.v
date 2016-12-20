module ppl_regE (clk, reset,
                dWriteReg, dMem2Reg, dWriteMem, dJal, dAluC, dAluImm, dShift,
                dpc4, dDataA, dDataB, dDataImm, dReg,
                exWriteReg, exMem2Reg, exWriteMem, exJal, exAluC, exAluImm, exShift,
                expc4, exDataA, exDataB, exDataImm, exReg0);
    input           clk, reset;

    input           dWriteReg, dMem2Reg, dWriteMem, dJal, dAluImm, dShift;
    input   [3:0]   dAluC;

    input   [4:0]   dReg;
    input   [31:0]  dpc4, dDataA, dDataB, dDataImm;

    output          exWriteReg, exMem2Reg, exWriteMem, exJal, exAluImm, exShift;
    reg             exWriteReg, exMem2Reg, exWriteMem, exJal, exAluImm, exShift;
    output  [3:0]   exAluC;
    reg     [3:0]   exAluC;
    output  [4:0]   exReg0;
    reg     [4:0]   exReg0;
    output  [31:0]  expc4, exDataA, exDataB, exDataImm;
    reg     [31:0]  expc4, exDataA, exDataB, exDataImm;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            exWriteReg <= 0;
            exMem2Reg <= 0;
            exWriteMem <= 0;
            exJal <= 0;
            exAluImm <= 0;
            exShift <= 0;
            exAluC <= 0;
            expc4 <= 0;
            exDataA <= 0;
            exDataB <= 0;
            exDataImm <= 0;
            exReg0 <= 0;
        end else begin
            exWriteReg <= dWriteReg;
            exMem2Reg <= dMem2Reg;
            exWriteMem <= dWriteMem;
            exJal <= dJal;
            exAluImm <= dAluImm;
            exShift <= dShift;
            exAluC <= dAluC;
            expc4 <= dpc4;
            exDataA <= dDataA;
            exDataB <= dDataB;
            exDataImm <= dDataImm;
            exReg0 <= dReg;
        end
    end
endmodule // ppl_regE
