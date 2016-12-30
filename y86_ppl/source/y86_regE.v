`include "y86_define.v"

module y86_regE (clk, reset,    // clock
                E_stall, E_bubble,
                Ein_stat, Ein_icode, Ein_ifun, Ein_valC, Ein_valA, Ein_valB,
                Ein_dstE, Ein_dstM, Ein_srcA, Ein_srcB,     // input
                Eout_stat, Eout_icode, Eout_ifun, Eout_valC, Eout_valA, Eout_valB,
                Eout_dstE, Eout_dstM, Eout_srcA, Eout_srcB);    // output
    input           clk, reset, E_stall, E_bubble;
    input   [3:0]   Ein_stat, Ein_icode, Ein_ifun, Ein_dstE, Ein_dstM, Ein_srcA, Ein_srcB;
    input   [31:0]  Ein_valC, Ein_valA, Ein_valB;

    output  [3:0]   Eout_stat, Eout_icode, Eout_ifun, Eout_dstE, Eout_dstM, Eout_srcA, Eout_srcB;
    reg     [3:0]   Eout_stat, Eout_icode, Eout_ifun, Eout_dstE, Eout_dstM, Eout_srcA, Eout_srcB;
    output  [31:0]  Eout_valC, Eout_valA, Eout_valB;
    reg     [31:0]  Eout_valC, Eout_valA, Eout_valB;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            Eout_icode <= `I_NOP;
            Eout_stat <= `S_OK;
            Eout_dstE <= `R_NONE;
            Eout_dstM <= `R_NONE;
            Eout_srcA <= `R_NONE;
            Eout_srcB <= `R_NONE;
        end else begin
            if (E_bubble == 1) begin
                Eout_stat <= `S_OK;
                Eout_icode <= `I_NOP;
                Eout_ifun <= 0;
                Eout_valC <= 0;
                Eout_valA <= 0;
                Eout_valB <= 0;
                Eout_dstE <= `R_NONE;
                Eout_dstM <= `R_NONE;
                Eout_srcA <= `R_NONE;
                Eout_srcB <= `R_NONE;
            end else if (E_stall == 0) begin
                Eout_stat <= Ein_stat;
                Eout_icode <= Ein_icode;
                Eout_ifun <= Ein_ifun;
                Eout_valC <= Ein_valC;
                Eout_valA <= Ein_valA;
                Eout_valB <= Ein_valB;
                Eout_dstE <= Ein_dstE;
                Eout_dstM <= Ein_dstM;
                Eout_srcA <= Ein_srcA;
                Eout_srcB <= Ein_srcB;
            end
        end
    end
endmodule // y86_regE
