module y86_datamem (reset, mem_clk, clk,    // clock
                    addr, datain, we,   // input
                    dataout,    // output
                    switches, hex0, hex1, hex2, hex3, hex4, hex5, leds);    // io ports
    input           reset, mem_clk, clk;

    input           we;
    input   [9:0]   switches;
    input   [31:0]  addr, datain;

    output  [6:0]   hex0, hex1, hex2, hex3, hex4, hex5;
    reg     [6:0]   hex0, hex1, hex2, hex3, hex4, hex5;
    output  [9:0]   leds;
    reg     [9:0]   leds;
    output  [31:0]  dataout;

    wire write_enable = we & ~clk;
    wire dmem_clk = mem_clk & ( ~clk) ;
    wire dram_we;

    wire [31:0] dram_dataout;
    y86_ram dram(addr[11:2], dmem_clk, datain, dram_we, dram_dataout);

    reg [9:0] sws;
    always @ (posedge dmem_clk) begin
        sws <= switches;
    end
    assign dataout = (addr == 32'h180 ? sws : dram_dataout);
    assign dram_we = (addr < 32'h180 ? write_enable : 1'b0);

    function [6:0] to7leds (input [31:0] toshow);
        //input [31:0] toshow;
        //output [6:0] to7leds;
        case (toshow)
            //               fge_dcba   7' LED
            //               654_3210   in DE1-SoC
            0:  to7leds = 7'b100_0000;
            1:  to7leds = 7'b111_1001;
            2:  to7leds = 7'b010_0100;
            3:  to7leds = 7'b011_0000;
            4:  to7leds = 7'b001_1001;
            5:  to7leds = 7'b001_0010;
            6:  to7leds = 7'b000_0010;
            7:  to7leds = 7'b111_1000;
            8:  to7leds = 7'b000_0000;
            9:  to7leds = 7'b001_0000;
            default:
                to7leds = 7'b111_1111;
        endcase
    endfunction


    always @ (posedge dmem_clk or negedge reset) begin
        if (reset == 0) begin
            hex0 <= 0;
            hex1 <= 0;
            hex2 <= 0;
            hex3 <= 0;
            hex4 <= 0;
            hex5 <= 0;
            leds <= 0;
        end else begin
            if (write_enable == 1) begin
                case (addr[9:0])
                    10'h184: begin
                        hex1 <= to7leds(datain / 10); // hex1
                        hex0 <= to7leds(datain % 10); // hex0
                    end
                    10'h188: begin
                        leds[8] <= 1'b1;
                        hex5 <= to7leds(datain / 10); // hex1
                        hex4 <= to7leds(datain % 10); // hex0
                    end
                    10'h18c: begin
                        hex3 <= to7leds(datain / 10); // hex1
                        hex2 <= to7leds(datain % 10); // hex0
                    end
                    default: begin
                        if (addr > 32'h180) begin
                            hex0 <= to7leds(addr % 10);
                            hex1 <= to7leds((addr / 10) % 10);
                            hex2 <= to7leds((addr / 100) % 10);
                            hex3 <= to7leds((addr / 1000) % 10);
                        end
                    end
                endcase
            end

            leds[9] <= we;
            leds[7] <= (addr == 32'h188) ? 1'b1 : 1'b0;
            leds[6] <= write_enable;
            leds[5] <= (addr < 32'h180) ? 1'b1 : 1'b0;
            leds[4] <= (addr > 32'h180) ? 1'b1 : 1'b0;
            leds[3] <= (addr == 32'h180) ? 1'b1 : 1'b0;
            leds[2] <= mem_clk;
            leds[1] <= clk;
            leds[0] <= 1'b1;

        end
    end
endmodule // y86_datamem
