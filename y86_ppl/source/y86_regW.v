`include "y86_define.v"

module y86_regW (clk, reset,    // clock
                W_stall, W_bubble,
                Win_stat, Win_icode, Win_valE, Win_valM, Win_dstE, Win_dstM, Win_Cnd,   // input
                Wout_stat, Wout_icode, Wout_valE, Wout_valM, Wout_dstE, Wout_dstM, Wout_Cnd);   // output
    input           clk, reset, W_stall, W_bubble;

    input           Win_Cnd;
    input   [3:0]   Win_stat, Win_icode, Win_dstE, Win_dstM;
    input   [31:0]  Win_valE, Win_valM;

    output          Wout_Cnd;
    reg             Wout_Cnd;
    output  [3:0]   Wout_stat, Wout_icode, Wout_dstE, Wout_dstM;
    reg     [3:0]   Wout_stat, Wout_icode, Wout_dstE, Wout_dstM;
    output  [31:0]  Wout_valE, Wout_valM;
    reg     [31:0]  Wout_valE, Wout_valM;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            Wout_icode <= `I_NOP;
            Wout_stat <= `S_OK;
            Wout_dstE <= `R_NONE;
            Wout_dstM <= `R_NONE;
        end else begin
            if (W_bubble == 1) begin
                Wout_icode <= `I_NOP;
                Wout_stat <= `S_OK;
                Wout_valE <= 0;
                Wout_valM <= 0;
                Wout_dstE <= `R_NONE;
                Wout_dstM <= `R_NONE;
                Wout_Cnd <= 0;
            end else if (W_stall == 0) begin
                Wout_stat <= Win_stat;
                Wout_icode <= Win_icode;
                Wout_valE <= Win_valE;
                Wout_valM <= Win_valM;
                Wout_dstE <= Win_dstE;
                Wout_dstM <= Win_dstM;
                Wout_Cnd <= Win_Cnd;
            end
        end
    end
endmodule // y86_regW
