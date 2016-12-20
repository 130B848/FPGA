module alu (alua, alub, aluc, result);
    input   [31:0]  alua, alub;
    input   [3:0]   aluc;

    output  [31:0]  result;
    reg     [31:0]  result;

    always @ (*) begin
        case (aluc)
            4'b0000: result = alua + alub;               //x000 ADD
            4'b1000: result = alua + alub;               //x000 ADD
            4'b0100: result = alua - alub;               //x100 SUB
            4'b1100: result = alua - alub;               //x100 SUB
            4'b0001: result = alua & alub;               //x001 AND
            4'b1001: result = alua & alub;               //x001 AND
            4'b0101: result = alua | alub;               //x101 OR
            4'b1101: result = alua | alub;               //x101 OR
            4'b0010: result = alua ^ alub;               //x010 XOR
            4'b1010: result = alua ^ alub;               //x010 XOR
            4'b0110: result = alub << 16;                //x110 LUI: imm << 16bit
            4'b1110: result = alub << 16;                //x110 LUI: imm << 16bit
            4'b0011: result = alub << alua;              //0011 SLL: rd <- (rt << sa)
            4'b0111: result = alub >> alua;              //0111 SRL: rd <- (rt >> sa) (logicalual)
            4'b1111: result = $signed(alub) >>> alua;    //1111 SRA: rd <- (rt >> sa) (arithmetic)
            default: result = 0;
        endcase
    end
endmodule //alu
