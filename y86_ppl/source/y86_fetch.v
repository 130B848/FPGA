`include "y86_define.v"

module y86_fetch (half_mem_clk, mem_clk, clk, reset,    // clock
                Fout_predPC, Mout_icode, Mout_Cnd, Mout_valA, Wout_icode, Wout_valM,    // input
                Fin_predPC, Din_stat, Din_icode, Din_ifun, Din_rA, Din_rB, Din_valC, Din_valP); // output
    input           half_mem_clk, mem_clk, clk, reset;

    input           Mout_Cnd;
    input   [3:0]   Mout_icode, Wout_icode;
    input   [31:0]  Fout_predPC, Mout_valA, Wout_valM;

    output  [3:0]   Din_stat, Din_icode, Din_ifun, Din_rA, Din_rB;
    output  [31:0]  Fin_predPC, Din_valC, Din_valP;

    wire    [3:0]   icode = Din_icode;
    wire    [31:0]  f_pc = (
        // Mispredicted branch. Fetch at incremented PC.
        (Mout_icode == `I_JXX && ~Mout_Cnd) ? Mout_valA :
        // Completion of RET instruction.
        (Wout_icode == `I_RET) ? Wout_valM:
        // Default: Use predicted value of PC.
        Fout_predPC
    );

    wire    [47:0]  inst;
    y86_instmem instruction_memory (half_mem_clk, mem_clk, clk, reset,
                                    f_pc,
                                    inst);

    assign Din_icode = inst[47:44];
    assign Din_ifun = inst[43:40];
    assign Din_rA = inst[39:36];
    assign Din_rB = inst[35:32];

    wire    [31:0]  imm = (icode == `I_JXX || icode == `I_CALL) ? inst[39:8] : inst[31:0];
    // Warning: imm is little-endian.
    assign Din_valC = { imm[7:0], imm[15:8], imm[23:16], imm[31:24] };
    assign Din_valP = f_pc + 1 +
        (((icode >= 4'h2 && icode <= 4'h6) || icode == 4'ha || icode == 4'hb) ? 1 : 0) + // need_register
        (((icode >= 4'h3 && icode <= 4'h5) || icode == 4'h7 || icode == 4'h8) ? 4 : 0);  // need_immediate
    assign Fin_predPC = (
        (icode == `I_JXX || icode == `I_CALL) ? Din_valC :  // prediction: always choose(jump)
        Din_valP
    );
    assign Din_stat = (
        (icode == `I_HALT) ? `S_HLT :
        (icode > `I_HALT && icode <= `I_POPL) ? `S_OK : `S_INS
    );
endmodule // y86_fetch
