module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    wire in;
    assign in=~(in1^in2);
    assign out=in^in3;
endmodule
