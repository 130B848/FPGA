`include "y86_define.v"

module y86_regM (clk, reset,
            M_stall, M_bubble,
            Min_stat, Min_icode, Min_Cnd, Min_valE, Min_valA, Min_dstE, Min_dstM,   // input
            Mout_stat, Mout_icode, Mout_Cnd, Mout_valE, Mout_valA, Mout_dstE, Mout_dstM);   // output
    input           clk, reset, M_stall, M_bubble;

    input           Min_Cnd;
    input   [3:0]   Min_stat, Min_icode, Min_dstE, Min_dstM;
    input   [31:0]  Min_valE, Min_valA;

    output          Mout_Cnd;
    reg             Mout_Cnd;
    output  [3:0]   Mout_stat, Mout_icode, Mout_dstE, Mout_dstM;
    reg     [3:0]   Mout_stat, Mout_icode, Mout_dstE, Mout_dstM;
    output  [31:0]  Mout_valE, Mout_valA;
    reg     [31:0]  Mout_valE, Mout_valA;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            Mout_icode = `I_NOP;
            Mout_stat = `S_OK;
            Mout_dstE = `R_NONE;
            Mout_dstM = `R_NONE;
        end else begin
            if (M_bubble == 1) begin
                Mout_icode = `I_NOP;
                Mout_stat = `S_OK;
                Mout_Cnd = 0;
                Mout_valE = 0;
                Mout_valA = 0;
                Mout_dstE = `R_NONE;
                Mout_dstM = `R_NONE;
            end else if (M_stall == 0) begin
                Mout_stat = Min_stat;
                Mout_icode = Min_icode;
                Mout_Cnd = Min_Cnd;
                Mout_valE = Min_valE;
                Mout_valA = Min_valA;
                Mout_dstE = Min_dstE;
                Mout_dstM = Min_dstM;
            end
        end
    end
endmodule // y86_regM
