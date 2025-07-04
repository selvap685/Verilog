module uart_rx (
    input clk,               
    input rst,               
    input rx,              
    output reg [7:0] data,   
    output reg data_ready);
   parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;
    reg [1:0] state = IDLE;
    reg [12:0] clk_count = 0;
    reg [3:0] bit_index = 0;
    reg [7:0] rx_shift = 0;

    parameter CLKS_PER_BIT = 5208;  // 50MHz / 9600 = 5208

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            data_ready <= 0;
            clk_count <= 0;
            bit_index <= 0;
            rx_shift <= 0;
        end else begin
            case (state)
                IDLE: begin
                    data_ready <= 0;
                    if (rx == 0) begin
                        state <= START;
                        clk_count <= 0;
                    end
                end

                START: begin
                    if (clk_count == (CLKS_PER_BIT / 2)) begin
                        if (rx == 0) begin
                            state <= DATA;
                            clk_count <= 0;
                            bit_index <= 0;
                        end else
                            state <= IDLE;
                    end else
                        clk_count <= clk_count + 1;
                end

                DATA: begin
                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        rx_shift[bit_index] <= rx;
                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else
                            state <= STOP;
                    end
                end

                STOP: begin
                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        state <= IDLE;
                        data <= rx_shift;
                        data_ready <= 1;
                        clk_count <= 0;
                    end
                end
            endcase
        end
    end
endmodule
