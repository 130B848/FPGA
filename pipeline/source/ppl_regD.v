module ppl_regD (clk, reset, pcContinue,
                pcIn, instIn,
                pcOut, instOut);
    input           clk, reset, pcContinue;
    input   [31:0]  pcIn, instIn;

    output  [31:0]  pcOut, instOut;
    reg     [31:0]  pcOut, instOut;

    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            pcOut <= 32'h8000_0000;
            instOut <= 0;
        end else if (pcContinue) begin
            pcOut <= pcIn;
            instOut <= instIn;
        end
    end
endmodule // ppl_regD
