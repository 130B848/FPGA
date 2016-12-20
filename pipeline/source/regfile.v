module regfile (clk, reset,
                srcA, srcB,
                writeReg, dstReg, data, // if writeReg, then write data to dstReg
                d_rvalA, d_rvalB,
                reg1, reg2, reg3, reg4, reg5, reg6);
    input   [4:0]   srcA, srcB, dstReg;
    input   [31:0]  data;
    input           clk, reset, writeReg;

    output  [31:0]  d_rvalA, d_rvalB, reg1, reg2, reg3, reg4, reg5, reg6;

    reg     [31:0]  register [1:31];    // r1 ~ r31

    assign d_rvalA = (srcA == 0) ? 0 : register[srcA];
    assign d_rvalB = (srcB == 0) ? 0 : register[srcB];
    assign reg1 = register[1];
    assign reg2 = register[2];
    assign reg3 = register[3];
    assign reg4 = register[4];
    assign reg5 = register[5];
    assign reg6 = register[6];

    integer i;
    always @ (posedge clk or negedge reset) begin
        if (reset == 0) begin
            for (i = 1; i < 32; i = i + 1) begin
                register[i] <= 0;
            end
        end else begin
            if ((dstReg != 0) && (writeReg == 1)) begin
                register[dstReg] <= data;
            end
        end
    end
endmodule // regfile
