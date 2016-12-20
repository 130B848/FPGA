module mux2x32 (in0, in1, select, out);
    input   [31:0]  in0, in1;
    input           select;

    output  [31:0]  out;

    assign out = select ? in1 : in0;
endmodule
