`include "y86_define.v"

module y86_memory (mem_clk, clk, reset,
            Mout_stat, Mout_icode, Mout_valE, Mout_valA,
            Win_stat, Win_valM,
            switches, hex0, hex1, hex2, hex3, hex4, hex5, leds);
    input           mem_clk, clk, reset;

    input   [3:0]   Mout_stat, Mout_icode;
    input   [31:0]  Mout_valE, Mout_valA;

    output  [3:0]   Win_stat;
    output  [31:0]  Win_valM;
    // io
    input   [9:0]   switches;
    output  [6:0]   hex0, hex1, hex2, hex3, hex4, hex5;
    output  [9:0]   leds;

    wire [31:0] datain = Mout_valA;
    wire [31:0] addr = (
        (Mout_icode == `I_RET || Mout_icode == `I_POPL) ? Mout_valA :
        Mout_valE
    );
    wire we = (Mout_icode == `I_RMMOVL || Mout_icode == `I_CALL || Mout_icode == `I_PUSHL);

    wire    [31:0]  dataout;
    y86_datamem data_memory (
        reset, mem_clk, clk,
        addr, datain, we,
        dataout,
        switches, hex0, hex1, hex2, hex3, hex4, hex5, leds);
    assign Win_valM = dataout;
    assign Win_stat = Mout_stat;
endmodule // y86_memory
