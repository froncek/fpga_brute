module top
(
    input wire          clk,
    input wire          ftdi_rx,
    output wire         ftdi_tx,
    input wire          board1_rx,
    output wire         board1_tx,
    output wire         board1_rst
);

reg [31:0] cycles = 32'd0;
wire ftdi_data_received;
wire invalid_pass_received;
assign board1_tx = ftdi_rx;
// assign board1_rst = invalid_pass_received;

uart_rx ftdi_uart_rx_i (
    .clk(clk),
    .rst(1'b0),
    .din(ftdi_rx),
    .valid(ftdi_data_received)
);

detect invalid_pass_detector (
    .clk(clk),
    .data_in(8'h49),
    .din(board1_rx),
    .valid(invalid_pass_received)
);

tx4 tx4i (
    .clk(clk),
    .en(invalid_pass_received),
    .data_in(cycles),
    .dout(ftdi_tx)
);

always @(posedge clk ) begin
    cycles <= cycles + 1'b1;

    if(ftdi_data_received) begin
        cycles <= 32'd0;
    end  
end

endmodule