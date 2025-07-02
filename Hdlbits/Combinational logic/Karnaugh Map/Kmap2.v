module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    assign out=(~a&~d)|(~a&~b&~c)|(b&c&d)|(a&~b&~c)|(a&~b&d);
endmodule
