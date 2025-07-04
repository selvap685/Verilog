module uart_tx (
    input clk,             
    input rst,             
    input [7:0] data,      
    input send,            
    output reg tx,         
    output reg busy );

    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;
    reg [1:0] state = IDLE;
    reg [12:0] clk_count = 0;
    reg [3:0] bit_index = 0;
    reg [7:0] tx_shift = 0;

    parameter CLKS_PER_BIT = 5208;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1;
            busy <= 0;
            clk_count <= 0;
            bit_index <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1;
                    busy <= 0;
                    if (send) begin
                        state <= START;
                        tx_shift <= data;
                        clk_count <= 0;
                        busy <= 1;
                    end
                end

                START: begin
                    tx <= 0;
                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= DATA;
                        bit_index <= 0;
                    end
                end

                DATA: begin
                    tx <= tx_shift[bit_index];
                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else
                            state <= STOP;
                    end
                end

                STOP: begin
                    tx <= 1;
                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        state <= IDLE;
                        busy <= 0;
                    end
                end
            endcase
        end
    end
endmodule
