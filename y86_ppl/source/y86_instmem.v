module y86_instmem (half_mem_clk, mem_clk, clk, reset,
                    f_pc,
                    inst);
    input           half_mem_clk, mem_clk, clk, reset;
    input   [31:0]  f_pc;

    output  [47:0]  inst;
    reg     [47:0]  inst;

    wire imem_clk = clk & (~mem_clk);
    wire post_imem_clk = clk & (~mem_clk) & (~half_mem_clk);

    wire    [63:0]  in, st;
    y86_rom irom (f_pc[10:3], f_pc[10:3] + 8'b1, imem_clk, in, st);

    always @ (posedge post_imem_clk) begin
        if (imem_clk == 1) begin
            case (f_pc[2:0])
                3'b000 : inst = {in[63:16]          };
                3'b001 : inst = {in[55:8]           };
                3'b010 : inst = {in[47:0]           };
                3'b011 : inst = {in[39:0], st[63:56]};
                3'b100 : inst = {in[31:0], st[63:48]};
                3'b101 : inst = {in[23:0], st[63:40]};
                3'b110 : inst = {in[15:0], st[63:32]};
                3'b111 : inst = {in[7:0],  st[63:24]};
                default: inst = 48'h0;
            endcase
        end
    end

endmodule // y86_instmem
