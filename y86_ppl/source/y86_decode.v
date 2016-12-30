`include "y86_define.v"

module y86_decode (half_mem_clk, mem_clk, clk, reset,
                Dout_icode, Dout_rA, Dout_rB, Dout_valP,
                Min_dstE, Win_dstM, Mout_dstE, Wout_dstM, Wout_dstE,
                Min_valE, Win_valM, Mout_valE, Wout_valM, Wout_valE,
                Wout_icode, Wout_Cnd,   // input
                Ein_valA, Ein_valB, Ein_dstE, Ein_dstM, Ein_srcA, Ein_srcB);    // output
    input           half_mem_clk, mem_clk, clk, reset;

    input           Wout_Cnd;
    input   [3:0]   Dout_icode, Dout_rA, Dout_rB;
    input   [3:0]   Min_dstE, Win_dstM, Mout_dstE, Wout_dstM, Wout_dstE, Wout_icode;
    input   [31:0]  Dout_valP, Min_valE, Win_valM, Mout_valE, Wout_valM, Wout_valE;

    output  [3:0]   Ein_dstE, Ein_dstM, Ein_srcA, Ein_srcB;
    output  [31:0]  Ein_valA, Ein_valB;

    wire [3:0] srcA = (
        (Dout_icode == `I_RRMOVL || Dout_icode == `I_RMMOVL || Dout_icode == `I_OPL || Dout_icode == `I_PUSHL) ? Dout_rA :
        (Dout_icode == `I_POPL || Dout_icode == `I_RET) ? `R_ESP : // give to memory for read
        `R_NONE
    );
    wire [3:0] srcB = (
        (Dout_icode == `I_POPL || Dout_icode == `I_RET ||
        Dout_icode == `I_PUSHL || Dout_icode == `I_CALL) ? `R_ESP :
        (Dout_icode == `I_OPL || Dout_icode == `I_RMMOVL ||
        Dout_icode == `I_MRMOVL) ? Dout_rB :
        `R_NONE
    );

    wire weM = (
        Wout_icode == `I_MRMOVL || Wout_icode == `I_POPL
    );
    wire weE = (
        Wout_icode == `I_CALL || Wout_icode == `I_RET ||
        Wout_icode == `I_PUSHL || Wout_icode == `I_POPL ||
        Wout_icode == `I_IRMOVL || Wout_icode == `I_OPL ||
        (Wout_icode == `I_CMOVXX && Wout_Cnd == 1)
    );

    wire [31:0] regvalA, regvalB;
    y86_regfile register_file(
        clk, reset,
        Wout_valM, Wout_dstM, weM,
        Wout_valE, Wout_dstE, weE,
        srcA, srcB,
        regvalA, regvalB);

    assign Ein_valA = (
        (Dout_icode == `I_CALL || Dout_icode == `I_JXX) ? Dout_valP :
        srcA == Min_dstE ? Min_valE :
        srcA == Win_dstM ? Win_valM :
        srcA == Mout_dstE ? Mout_valE :
        srcA == Wout_dstM ? Wout_valM :
        srcA == Wout_dstE ? Wout_valE :
        regvalA
    );

    assign Ein_valB = (
        srcB == Min_dstE ? Min_valE :
        srcB == Win_dstM ? Win_valM :
        srcB == Mout_dstE ? Mout_valE :
        srcB == Wout_dstM ? Wout_valM :
        srcB == Wout_dstE ? Wout_valE :
        regvalB
    );

    assign Ein_srcA = srcA;
    assign Ein_srcB = srcB;
    assign Ein_dstE = (
        (Dout_icode == `I_RRMOVL || Dout_icode == `I_IRMOVL ||
        Dout_icode == `I_OPL) ? Dout_rB :    // rrmovl/irmovl/opl
        (Dout_icode == `I_PUSHL || Dout_icode == `I_POPL ||
        Dout_icode == `I_CALL || Dout_icode == `I_RET) ? `R_ESP :
        `R_NONE
    );
    assign Ein_dstM = (
        (Dout_icode == `I_MRMOVL ||    // mrmovl
        Dout_icode == `I_POPL) ? Dout_rA :   // popl -> rb
        `R_NONE
    );
endmodule // y86_decode
