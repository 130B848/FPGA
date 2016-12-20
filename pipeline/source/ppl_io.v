module ppl_io (addr, datain, dataout, we, clock, clrn, keys,
				display_1, display_2, display_3, display_4, display_5, display_6);
	input	           we, clock, clrn;
	input   [31:0]     datain, addr;

	input   [9:0]      keys;

	output  [31:0]	   dataout;
	output  [6:0]      display_1, display_2, display_3, display_4, display_5, display_6;

	io_input_reg input_reg(addr, clock, dataout, keys,
							display_1, display_2, display_3, display_4);

	io_output_reg output_reg(addr, datain, we, clock, clrn,
							display_5, display_6);
endmodule

module io_input_reg(addr, io_clock, dataout, keys,
					display_1, display_2, display_3, display_4);
	input		       io_clock;
	input   [9:0]      keys;
	input   [31:0]     addr;

    output  [31:0]	   dataout;
	output 	[6:0]	   display_1, display_2, display_3, display_4;

	reg     [31:0]     key_group_1, key_group_2, key_group_3;
	reg     [31:0]     dataout, display_data_1, display_data_2, display_data_3, display_data_4;
	wire 	[6:0]	   display_1, display_2, display_3, display_4;

	sevenseg LED8_display_1(display_data_1[3:0], display_1);
	sevenseg LED8_display_2(display_data_2[3:0], display_2);
	sevenseg LED8_display_3(display_data_3[3:0], display_3);
	sevenseg LED8_display_4(display_data_4[3:0], display_4);

	always @ (posedge io_clock) begin
		key_group_1 <= 32'b0;
		key_group_2 <= 32'b0;
		key_group_3 <= 32'b0;
		key_group_1[3] <= keys[9];
		key_group_1[2] <= keys[8];
		key_group_1[1] <= keys[7];
		key_group_1[0] <= keys[6];
		key_group_2[3] <= keys[5];
		key_group_2[2] <= keys[4];
		key_group_2[1] <= keys[3];
		key_group_2[0] <= keys[2];
		// key_group_3[1] <= keys[1];
		// key_group_3[0] <= keys[0];
		display_data_1[3:0] <= key_group_1 % 10;
		display_data_2[3:0] <= key_group_1 / 10;
		display_data_3[3:0] <= key_group_2 % 10;
		display_data_4[3:0] <= key_group_2 / 10;
	end

	always @ ( * ) begin
		case (addr[7:2])
			6'b110000: dataout <= key_group_1;
			6'b110001: dataout <= key_group_2;
			6'b100101: dataout <= key_group_3;
			default: dataout <= 0;
		endcase
	end
endmodule

module io_output_reg(addr, datain, we, io_clock, clrn,
					display_5, display_6);

	input   [31:0]     addr, datain;
	input			   we, io_clock, clrn;

	output  [6:0]      display_5, display_6;


	reg 	[31:0]     display_data_5, display_data_6;

	sevenseg LED8_display_5(display_data_5[3:0], display_5);
	sevenseg LED8_display_6(display_data_6[3:0], display_6);

	always @ (posedge io_clock) begin
		if (clrn == 0) begin
			// display_data_1 <= 0;
			// display_data_2 <= 0;
			// display_data_3 <= 0;
			// display_data_4 <= 0;
			display_data_5 <= 0;
			display_data_6 <= 0;
		end else begin
			if (we == 1) begin
				case (addr[7:2])
					// 6'b110000: begin
					// 	display_data_1[3:0] <= 0;
					// 	display_data_2[3:0] <= 0;
					// 	display_data_1[3:0] <= datain[3:0];
					// 	display_data_2[3:0] <= datain[7:4];
					// end
					// 6'b110001: begin
					// 	display_data_3[3:0] <= 0;
					// 	display_data_4[3:0] <= 0;
					// 	display_data_3[3:0] <= datain[3:0];
					// 	display_data_4[3:0] <= datain[7:4];
					// end
					6'b110010: begin
						display_data_5[3:0] <= 0;
						display_data_6[3:0] <= 0;
						display_data_5[3:0] <= datain % 10;
						display_data_6[3:0] <= datain / 10;
					end
				endcase
			end
		end
	end
endmodule


module sevenseg(data, ledsegments);
	input  [3:0]   data;
	output [6:0]   ledsegments;
	reg    [6:0]   ledsegments;

	always @ ( * ) begin
		case(data)
			0: ledsegments <= 7'b100_0000;
			1: ledsegments <= 7'b111_1001;
			2: ledsegments <= 7'b010_0100;
			3: ledsegments <= 7'b011_0000;
			4: ledsegments <= 7'b001_1001;
			5: ledsegments <= 7'b001_0010;
			6: ledsegments <= 7'b000_0010;
			7: ledsegments <= 7'b111_1000;
			8: ledsegments <= 7'b000_0000;
			9: ledsegments <= 7'b001_0000;
			10: ledsegments <= 7'b000_1000;
			11: ledsegments <= 7'b000_0011;
			12: ledsegments <= 7'b100_0110;
			13: ledsegments <= 7'b010_0001;
			14: ledsegments <= 7'b000_0110;
			15: ledsegments <= 7'b000_1110;
			default: ledsegments <= 7'b111_1111;
		endcase
    end
endmodule
