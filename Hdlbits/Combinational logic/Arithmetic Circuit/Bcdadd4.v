module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    wire [3:0] s0, s1, s2, s3;
    wire c1, c2, c3;
  bcd_fadd d0 (.a(a[3:0]),.b(b[3:0]),.cin(cin),.cout(c1),.sum (s0) );
  bcd_fadd d1 (.a(a[7:4]), .b (b[7:4]),.cin(c1),.cout(c2),.sum (s1) );
  bcd_fadd d2 (.a(a[11:8]),.b(b[11:8]), .cin (c2),.cout(c3),.sum (s2));
  bcd_fadd d3 (.a(a[15:12]),.b(b[15:12]),.cin (c3),.cout(cout),.sum (s3) );
  assign sum = {s3, s2, s1, s0};
endmodule
