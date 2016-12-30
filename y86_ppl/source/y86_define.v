`ifndef CONST
    // icode //
    `define I_HALT      4'h0
    `define I_NOP       4'h1
    `define I_RRMOVL    4'h2
    `define I_CMOVXX    4'h2
    `define I_IRMOVL    4'h3
    `define I_RMMOVL    4'h4
    `define I_MRMOVL    4'h5
    `define I_OPL       4'h6
    `define I_JXX       4'h7
    `define I_CALL      4'h8
    `define I_RET       4'h9
    `define I_PUSHL     4'hA
    `define I_POPL      4'hB
    // reg //
    `define R_EAX       4'h0
    `define R_ECX       4'h1
    `define R_EDX       4'h2
    `define R_EBX       4'h3
    `define R_ESI       4'h6
    `define R_EDI       4'h7
    `define R_ESP       4'h4
    `define R_EBP       4'h5
    `define R_NONE      4'hf
    // status //
    `define S_OK        4'h0
    `define S_HLT       4'h1
    `define S_INS       4'h2
    `define S_ADR       4'h3

    `define CONST
`endif
