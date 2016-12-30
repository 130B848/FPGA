`include "y86_define.v"

module y86_execute (reset,
                    Eout_icode, Eout_ifun, Eout_valC, Eout_valA, Eout_valB, Eout_dstE,  // input
                    Min_Cnd, Min_dstE, Min_valE);   // output
    input           reset;
    input   [3:0]   Eout_icode, Eout_ifun, Eout_dstE;
    input   [31:0]  Eout_valC, Eout_valA, Eout_valB;

    output          Min_Cnd;
    output  [3:0]   Min_dstE;
    output  [31:0]  Min_valE;

    wire [31:0] aluA = (
        (Eout_icode == `I_RRMOVL || Eout_icode == `I_OPL) ? Eout_valA :
        (Eout_icode == `I_IRMOVL || Eout_icode == `I_RMMOVL || Eout_icode == `I_MRMOVL || Eout_icode == `I_JXX) ? Eout_valC :
        (Eout_icode == `I_CALL || Eout_icode == `I_PUSHL) ? -4 :
        (Eout_icode == `I_RET || Eout_icode == `I_POPL) ? +4 :
        0
    );
    wire [31:0] aluB = (
        (Eout_icode == `I_RRMOVL || Eout_icode == `I_IRMOVL || Eout_icode == `I_JXX) ? 0 :
        Eout_valB
    );

    wire zero_flag, signed_flag, overflow_flag;
    y86_alu alu (reset, aluA, aluB, Eout_icode, Eout_ifun,
        Min_valE, zero_flag, signed_flag, overflow_flag);

    // cc
    wire cc_ok = (
        (Eout_ifun == 4'h0) ? 1'b1 : // always
        (Eout_ifun == 4'h1) ? ((signed_flag ^ overflow_flag) | zero_flag) : // LE
        (Eout_ifun == 4'h2) ? ((signed_flag ^ overflow_flag)) : // L
        (Eout_ifun == 4'h3) ? (zero_flag) : // E
        (Eout_ifun == 4'h4) ? (~zero_flag) : // NE
        (Eout_ifun == 4'h5) ? (~(signed_flag ^ overflow_flag)) : // GE
        (Eout_ifun == 4'h6) ? (~zero_flag & ~(signed_flag ^ overflow_flag)) : // G
        1'b0    // end
    );
    // branch cnd
    assign Min_Cnd = (Eout_icode == `I_JXX || Eout_icode == `I_CMOVXX) && cc_ok;
    assign Min_dstE = (Eout_icode == `I_CMOVXX && !Min_Cnd) ? `R_NONE : Eout_dstE;
endmodule // y86_execute
