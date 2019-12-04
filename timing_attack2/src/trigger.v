module trigger(
    input wire clk,
    input wire en,
    input wire din,
    output wire valid
);

parameter STATE_IDLE = 1'b0;
parameter STATE_DATA = 1'b1;

reg state = STATE_IDLE;

reg valid_reg = 1'b0;
assign valid = valid_reg;


always @(posedge clk) begin
    state <= state;
    valid_reg <= 1'b0;

    case(state)
        STATE_IDLE:
            if (en) begin
                state <= STATE_DATA;
            end
        STATE_DATA:
            if (en == 1'b0) begin
                state <= STATE_IDLE;
            end
            else if(din) begin
                valid_reg <= 1'b1;
            end
    endcase     
end

endmodule // trigger