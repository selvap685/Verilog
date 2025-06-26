module led_blink(
    input clk,            
    output reg led        
);
  reg [25:0] counter = 0;   
  parameter MAX_COUNT = 25000000;
  always @(posedge clk) begin
        if (counter == MAX_COUNT - 1) begin
            counter <= 0;
            led <= ~led;   
        end 
        else begin
            counter <= counter + 1;
        end
    end
    endmodule
