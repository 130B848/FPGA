module y86_regF (clk, reset,    // clock
                F_stall, Fin_predPC,  // input
                Fout_predPC);   // output
    input           clk, reset;
    input           F_stall;
    input   [31:0]  Fin_predPC;

    output  [31:0]  Fout_predPC;
    reg     [31:0]  Fout_predPC;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            Fout_predPC <= 31'b0;
        end else begin
            if (F_stall == 0) begin
                Fout_predPC <= Fin_predPC;
            end
        end
    end
endmodule // y86_regF
