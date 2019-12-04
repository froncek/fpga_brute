module trigger(
    input wire clk,
    input wire en,
    input wire din,
    output reg valid
);

parameter STATE_IDLE = 1'b0;
parameter STATE_DATA = 1'b1;

reg state = STATE_IDLE;

always @(posedge clk) begin
    state <= state;
    valid <= 1'b0;

    case(state)
        STATE_IDLE:
            if (en) begin
                state <= STATE_DATA;
            end
        STATE_DATA:
            if (din == 1'b0) begin
                state <= STATE_IDLE;
                valid <= 1'b1;
            end
    endcase     
end

endmodule // trigger