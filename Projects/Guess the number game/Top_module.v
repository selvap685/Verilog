module top_module (
    input clk,             
    input rst,             
    input rx,              
    output tx,             
    output [6:0] seg,     
    output [3:0] an,       
    output led_correct );

    wire [7:0] rx_data;
    wire data_ready;
    reg [7:0] tx_data;
    reg send;
    wire busy;

    reg [3:0] num_display;
    reg led_reg;

    assign led_correct = led_reg;
  
    localparam SECRET = 8'd53;
  
    uart_rx uart_receiver (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .data(rx_data),
        .data_ready(data_ready));

    uart_tx uart_transmitter (
        .clk(clk),
        .rst(rst),
        .data(tx_data),
        .send(send),
        .tx(tx),
        .busy(busy) );
 
  seven_seg_display disp (
        .num(num_display),
        .seg(seg),
        .an(an)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            num_display <= 0;
            led_reg <= 0;
            tx_data <= 0;
            send <= 0;
        end else begin
            send <= 0;
            if (data_ready && !busy) begin
                if (rx_data >= "0" && rx_data <= "9") begin
                    num_display <= rx_data - "0";

                    if (rx_data == SECRET) begin
                        led_reg <= 1;
                        tx_data <= "C";
                    end else begin
                        led_reg <= 0;
                        tx_data <= "W";
                    end
                    send <= 1;
                end
            end
        end
    end
endmodule
