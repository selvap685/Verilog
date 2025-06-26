module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
always @(*) begin			
			case (1'b1)  // We compare against '1', so only the matching condition executes
            in[0]: pos = 2'd0;
            in[1]: pos = 2'd1;
            in[2]: pos = 2'd2;
            in[3]: pos = 2'd3;
            default: pos = 2'd0
        endcase
end
endmodule
