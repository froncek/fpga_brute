module top
(
    input wire          clk,
    input wire          ftdi_rx,
    output wire         ftdi_tx,
    input wire          board1_rx,
    output wire         board1_tx,
    output wire         board1_rst,
    output reg          led = 1'b1,
    output wire [13:0]  debug_header
);

wire [7:0] uart_data;


// Combinatorial logic
assign board1_tx = ftdi_rx;
assign ftdi_tx = board1_rx;
assign debug_header = {11'd0, clk, ftdi_rx, ftdi_tx};

// Module instantiation
wire [7:0] rx_data;
wire rx_valid;
uart_rx rx (
    .clk(clk),
    .rst(1'b0),
    .din(ftdi_rx),
    .data_out(rx_data),
    .valid(rx_valid)
);

reg [15:0] shifter;
assign board1_rst = shifter[0];

always @(posedge clk)
begin
    shifter <= {1'b1, shifter[15:1]};
    // Sequential logic
    // TODO: toggle 'status_led' when an 'A' is recieved (8'h41)
    if (rx_data == 8'h41 && rx_valid == 1'b1)
    begin
        shifter <= 16'd0;
    end
end

endmodule
