module ppl_execute (exJal, exAluC, exAluImm, exShift,
                    expc4, exDataA, exDataB, exDataImm, exReg0,
                    exAlu, exReg);
    input           exJal, exAluImm, exShift;
    input   [3:0]   exAluC;

    input   [4:0]   exReg0;
    input   [31:0]  expc4, exDataA, exDataB, exDataImm;

    output  [4:0]   exReg;
    output  [31:0]  exAlu;

    wire    [31:0]  expc;
    assign expc = expc4 + 4;

    wire    [31:0]  aluA, aluB, aluResult;
    mux2x32 eAluA (exDataA, exDataImm, exShift, aluA);
    mux2x32 eAluB (exDataB, exDataImm, exAluImm, aluB);

    alu eAluC (aluA, aluB, exAluC, aluResult);
    mux2x32 jumpAndLink (aluResult, expc, exJal, exAlu);
    assign exReg = exJal ? 5'h31 : exReg0; // save original pc to $31 register
endmodule // ppl_execute
