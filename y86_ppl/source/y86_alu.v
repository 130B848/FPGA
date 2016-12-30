module y86_alu (reset,
                aluA, aluB, icode, ifunc,
                e_valE, zero_flag, signed_flag, overflow_flag);
    input           reset;
    input  [3:0]    icode, ifunc;
    input  [31:0]   aluA, aluB;

    output          zero_flag, signed_flag, overflow_flag;   // flags
    reg signed [31:0] zero_flag, signed_flag, overflow_flag;
    output [31:0]   e_valE;
    reg    [31:0]   e_valE;

    always @ ( * ) begin
        if (reset == 0) begin
            zero_flag = 1;
            signed_flag = 0;
            overflow_flag = 0;
        end else begin
            case (ifunc)
                4'h0: e_valE = aluA + aluB;              //6 0 addl / rmmovl / mrmovl
                4'h1: e_valE = aluB - aluA;              //6 1 subl
                4'h2: e_valE = aluA & aluB;              //6 2 andl
                4'h3: e_valE = aluA ^ aluB;              //6 3 xorl
                default: e_valE = aluA + aluB;
            endcase
            if (icode == 4'h6) begin // flags
                if (e_valE == 0) begin
                    zero_flag = 1;
                end else begin
                    zero_flag = 0;
                end

                if (e_valE[31] == 1'b1) begin
                    signed_flag = 1;
                end else begin
                    signed_flag = 0;
                end

                if (ifunc == 4'h0) begin
                    overflow_flag = (!(aluA[31] ^ aluB[31])) & (aluA[31] & e_valE[31]);
                end else if (ifunc == 4'h1) begin
                    overflow_flag = ((aluA[31] ^ aluB[31]) & (aluB[31] & e_valE[31]));
                end else begin
                    overflow_flag = 0;
                end
            end
        end
    end
endmodule // y86_alu
