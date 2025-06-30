module A(input x,y,output z);
    assign z=(x^y)&x;
endmodule
module B(input x,y,output z);
    assign z=~(x^y);
endmodule
module top_module (input x, input y, output z);
  wire z1,z2,z3,z4;
    wire or_out,and_out;
    A IA1(.x(x),.y(y),.z(z1));
    B IB1(.x(x),.y(y),.z(z2));
    assign or_out=z1|z2;
    A IA2(.x(x),.y(y),.z(z3));
    B IB2(.x(x),.y(y),.z(z4));
    assign and_out=z1&z2;
    assign z=or_out^and_out;
endmodule
