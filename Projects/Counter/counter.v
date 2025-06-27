module counter(
    input clk,           
    output [6:0] seg,     
    output [3:0] an       
);
    wire slow_clk;
    reg [3:0] count = 0;

    assign an = 4'b0001;  
    clock_divider u1(.clk(clk),.slow_clk(slow_clk));
    
    always @(posedge slow_clk) begin
        if (count == 9)
            count <= 0;
        else
            count <= count + 1;
    end
     seven_segment_decoder u2(.digit(count),.seg(seg));

endmodule

module clock_divider(
    input clk,           
    output reg slow_clk 
);
    reg [25:0] counter = 0;

    always @(posedge clk) begin
        if (counter >= 25_000_000) begin
            counter <= 0;
            slow_clk <= ~slow_clk;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
module seven_segment_decoder(
    input [3:0] digit,
    output reg [6:0] seg
);
always @(*) begin
        case (digit)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule
