module top
(
    input wire          clk,
    input wire          ftdi_rx,
    output wire         ftdi_tx,
    input wire          board1_rx,
    output wire         board1_tx,
    output wire         board1_rst
);

wire got_16_chars;
wire got_reset_target;
wire [31:0] num_of_ticks;
wire send_data_to_python;

assign board1_tx = ftdi_rx;

tx4 tx4i (
    .clk(clk),
    .en(send_data_to_python),
    .data_in(num_of_ticks),
    .dout(ftdi_tx)
);

trigger trigger_i(
    .clk(clk),
    .en(got_16_chars),
    .din(board1_rx),
    .valid(send_data_to_python)
);

tick_cnt tick_cnt_i(
    .clk(clk),
    .rst(got_16_chars),
    .data_out(num_of_ticks)
);

char_cnt char_cnt_i (
    .clk(clk),
    .din(ftdi_rx),
    .rst(got_reset_target),
    .valid(got_16_chars)
);

detect rstdetector (
    .clk(clk),
    .data_in(8'h40),
    .din(ftdi_rx),
    .valid(got_reset_target)
);

resetter resetteri(
    .clk(clk),
    .rst_in(got_reset_target),
    .rst_out(board1_rst)
);

endmodule