module pwm (
    input wire          clk,
    input wire          rst,
    input wire  [7:0]   threshold,
    output wire         dout
);

reg [7:0] pulse = 8'd0;

parameter STATE_HIGH = 1'b1;
parameter STATE_LOW = 1'b0;

reg state = STATE_HIGH;

assign dout = state;

always @(posedge clk) begin
    if (rst) begin
        pulse <= 8'd0;
        state <= STATE_HIGH;
    end
    else
    begin
        pulse <= pulse + 1'b1;
        state <= state;
        case(state)
            STATE_HIGH:
            begin
                if(pulse == threshold)
                begin
                    state <= STATE_LOW;
                end
            end
            STATE_LOW:
            begin
                if(pulse == 8'hff)
                begin
                    state <= STATE_HIGH;
                end
            end
        endcase
    end
end

endmodule
