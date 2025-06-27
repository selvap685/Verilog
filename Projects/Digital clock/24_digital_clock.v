module digital_clock(
    input clk,                 
    output reg [6:0] seg,      
    output reg [3:0] an  ,  
    output reg led    
);
    reg [25:0] counter_1hz = 0;
    reg clk_1hz = 0;
    parameter MAX_COUNT_1HZ = 25_000_000 - 1; 

    always @(posedge clk) begin
        if (counter_1hz == MAX_COUNT_1HZ) begin
            counter_1hz <= 0;
            clk_1hz <= ~clk_1hz;
        end else begin
            counter_1hz <= counter_1hz + 1;
        end
    end

    reg [5:0] minutes = 0;
    reg [4:0] hours = 0;
    reg [5:0] seconds = 0;
    always @(posedge clk_1hz) begin
        if(seconds==59) begin
          seconds<=0;
          if (minutes == 59) begin
            minutes <= 0;
            if (hours == 23)
                hours <= 0;
            else
                hours <= hours + 1;
          end 
          else begin
            minutes <= minutes + 1;
          end
        end
        else begin
           seconds<=seconds+1;
           led=~led;
        end
   end

    wire [3:0] digit0 = minutes % 10; 
    wire [3:0] digit1 = minutes / 10; 
    wire [3:0] digit2 = hours % 10;    
    wire [3:0] digit3 = hours / 10;    

    reg [15:0] mux_counter = 0;
    reg [1:0] mux_sel = 0;

    always @(posedge clk) begin
        if (mux_counter == 49_999) begin  
            mux_counter <= 0;
            mux_sel <= mux_sel + 1;
        end else begin
            mux_counter <= mux_counter + 1;
        end
    end
    
    function [6:0] seg_decoder;
        input [3:0] digit;
        begin
            case (digit)
                4'd0: seg_decoder = 7'b1000000;
                4'd1: seg_decoder = 7'b1111001;
                4'd2: seg_decoder = 7'b0100100;
                4'd3: seg_decoder = 7'b0110000;
                4'd4: seg_decoder = 7'b0011001;
                4'd5: seg_decoder = 7'b0010010;
                4'd6: seg_decoder = 7'b0000010;
                4'd7: seg_decoder = 7'b1111000;
                4'd8: seg_decoder = 7'b0000000;
                4'd9: seg_decoder = 7'b0010000;
                default: seg_decoder = 7'b1111111;
            endcase
        end
    endfunction

    always @(*) begin
        case (mux_sel)
            2'd0: begin
                an = 4'b1000;
                seg = seg_decoder(digit0);
            end
            2'd1: begin
                an = 4'b0100; 
                seg = seg_decoder(digit1);
            end
            2'd2: begin
                an = 4'b0010;
                seg = seg_decoder(digit2);
            end
            2'd3: begin
                an = 4'b0001; 
                seg = seg_decoder(digit3);
            end
        endcase
    end
