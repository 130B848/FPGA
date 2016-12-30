module y86_regfile (clk, reset,
                    Wout_valM, Wout_dstM, writeM,
                    Wout_valE, Wout_dstE, writeE,
                    srcA, srcB,
                    d_rvalA, d_rvalB);
    input           clk, reset, writeM, writeE;
    input   [3:0]   srcA, srcB, Wout_dstM, Wout_dstE;
    input   [31:0]  Wout_valM, Wout_valE;

    output  [31:0]  d_rvalA, d_rvalB;

    /* %eax 0 %ecx 1 %edx 2 %ebx 3 %esp 4 %ebp 5 %esi 6 %edi 7 */
    reg     [31:0]  register[0:7];

   assign d_rvalA = srcA > 4'h7 ? 0 : register[srcA]; // read
   assign d_rvalB = srcB > 4'h7 ? 0 : register[srcB]; // read

   integer i;
   always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin // reset
            for (i = 0; i < 8; i = i + 1) begin
                register[i] <= 0;
            end
        end else begin
            if ((Wout_dstM <= 4'h7) && (writeM == 1)) begin    // write
                register[Wout_dstM] <= Wout_valM;
            end
            if ((Wout_dstE <= 4'h7) && (writeE == 1)) begin
                register[Wout_dstE] <= Wout_valE;
            end
        end
   end
endmodule // y86_regfile
