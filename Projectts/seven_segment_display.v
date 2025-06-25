7 Segment display code:

module topss( en, in, anode, cathode);
input [1:0] en;
input [3:0] in;
output wire [3:0] anode;
output wire [7:0] cathode;
ADecoder l1(en,anode);
bcd_to_cathode l2(in,cathode);
endmodule
 
module ADecoder(count, anode);
input [1:0] count;
output reg [3:0] anode = 0;
always @(count)
begin
    case (count)
        2'b00 : anode = 4'b0001;
        2'b01 : anode = 4'b0010;
        2'b10 : anode = 4'b0100;
        2'b11 : anode = 4'b1000;
    endcase
end
endmodule

module bcd_to_cathode(bcd, cathode);
input [3:0] bcd;
output reg [7:0] cathode = 0;
always@(bcd)
begin
    case(bcd)
    4'd0: cathode = 8'b00000011;
    4'd1: cathode = 8'b10011111;
    4'd2: cathode = 8'b00100101;
    4'd3: cathode = 8'b00001101;
    4'd4: cathode = 8'b10011001;
    4'd5: cathode = 8'b01001001;
    4'd6: cathode = 8'b01000001;
    4'd7: cathode = 8'b00011111;
    4'd8: cathode = 8'b00000001;
    4'd9: cathode = 8'b00001001;
    default: cathode = 8'b11111111; // All OFF
    endcase
end
