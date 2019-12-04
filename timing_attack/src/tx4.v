module tx4 (
    input wire          clk,
    input wire          en,
    input wire [31:0]   data_in,
    output wire         dout
);

parameter STATE_IDLE = 1'b0;
parameter STATE_DATA = 1'b1;

reg state = STATE_IDLE;

wire tx_rdy;
reg [7:0] tx_data;
reg tx_en;

uart_tx txi (
    .clk(clk),
    .rst(1'b0),
    .dout(dout),
    .data_in(tx_data),
    .en(tx_en),
    .rdy(tx_rdy)
);

reg [1:0] byte_cnt;

reg [31:0] data;

always @(posedge clk)
begin
    tx_en <= 1'b0;
    case(state)
        STATE_IDLE:
        begin
            if(en)
            begin
                byte_cnt <= 2'd0;
                state <= STATE_DATA;
                data <= data_in;
            end
        end
        STATE_DATA:
        begin
            if(tx_rdy && tx_en == 1'b0) //TODO: FIX!
            begin
                tx_data <= data[7:0];
                tx_en <= 1'b1;
                data <= {8'd0, data[31:8]};
                byte_cnt <= byte_cnt + 1'b1;
                if(byte_cnt == 2'd3)
                begin
                    state <= STATE_IDLE;
                end
            end
        end
    endcase
end

endmodule