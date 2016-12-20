module mux2x5 (in0, in1, select, out);
    input   [4:0]   in0, in1;
    input           select;

    output  [4:0]   out;

    assign out = select ? in1 : in0;
endmodule
