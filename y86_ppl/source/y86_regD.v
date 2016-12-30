`include "y86_define.v"

module y86_regD (clk, reset,    // clock
                D_stall, D_bubble,
                Din_stat, Din_icode, Din_ifun, Din_rA, Din_rB, Din_valC, Din_valP,  // input
                Dout_stat, Dout_icode, Dout_ifun, Dout_rA, Dout_rB, Dout_valC, Dout_valP);  // output
    input           clk, reset;

    input           D_stall, D_bubble;

    input   [3:0]   Din_stat, Din_icode, Din_ifun, Din_rA, Din_rB;
    input   [31:0]  Din_valC, Din_valP;

    output  [3:0]   Dout_stat, Dout_icode, Dout_ifun, Dout_rA, Dout_rB;
    reg     [3:0]   Dout_stat, Dout_icode, Dout_ifun, Dout_rA, Dout_rB;
    output  [31:0]  Dout_valC, Dout_valP;
    reg     [31:0]  Dout_valC, Dout_valP;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            Dout_stat <= `S_OK;
            Dout_icode <= `I_NOP;
            Dout_rA <= `R_NONE;
            Dout_rB <= `R_NONE;
            Dout_valC <= 0;
            Dout_valP <= 0;
        end else begin
            if (D_bubble == 1) begin
                Dout_stat <= `S_OK;
                Dout_icode <= `I_NOP;
                Dout_ifun <= 0;
                Dout_rA <= `R_NONE;
                Dout_rB <= `R_NONE;
                Dout_valC <= 0;
                Dout_valP <= 0;
            end else if (D_stall == 0) begin
                Dout_stat <= Din_stat;
                Dout_icode <= Din_icode;
                Dout_ifun <= Din_ifun;
                Dout_rA <= Din_rA;
                Dout_rB <= Din_rB;
                Dout_valC <= Din_valC;
                Dout_valP <= Din_valP;
            end
        end
    end
endmodule // y86_regD
