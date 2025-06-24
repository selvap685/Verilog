module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire w1,w2;
    assign w1=a&b;
    assign w2=c&d;
    assign out=(a&b)|(c&d);
    assign out_n=~((a&b)|(c&d));

endmodule
