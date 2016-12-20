module ppl_regF (clk, reset, pcIn, pcContinue, pcOut);
    input           clk, reset, pcContinue;
    input   [31:0]  pcIn;

    output  [31:0]  pcOut;
    reg     [31:0]  pcOut;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            pcOut = -4;
        end else if (pcContinue) begin
            pcOut = pcIn;
        end else begin
            pcOut = pcOut;
        end
    end
endmodule // ppl_regF
