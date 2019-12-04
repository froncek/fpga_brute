module top(
    input wire clk,
    input wire ftdi_rx,
    input wire board1_rx
);

wire overflow_d1;
wire overflow_d2;
wire overflow_d3;

wire [7:0] d1_bits;
wire [7:0] d2_bits;
wire [7:0] d3_bits;
wire [7:0] d4_bits;


digit d1 (
    .clk(clk),
    .enable(invalid_pin_signal),
    .overflow_out(overflow_d1),
    .data_out(d1_bits)
);

digit d2 (
    .clk(clk),
    .enable(overflow_d1),
    .overflow_out(overflow_d2),
    .data_out(d2_bits)

);

digit d3 (
    .clk(clk),
    .enable(overflow_d2),
    .overflow_out(overflow_d3),
    .data_out(d3_bits)

);

digit d4 (
    .clk(clk),
    .enable(overflow_d3),
    .data_out(d4_bits)
);

wire pin_prompt_ready;

detect pin_detector(
    .clk(clk),
    .data_in(8'h3a),
    .din(board1_rx),
    .valid(pin_prompt_ready)
);

wire invalid_pin_signal;

detect invalid_detector(
    .clk(clk),
    .data_in(8'h69),
    .din(board1_rx),
    .valid(invalid_pin_signal)
);

wire [31:0] tx4_out;
assign tx4_out[7:0] = d1_bits;
assign tx4_out[15:8] = d2_bits;
assign tx4_out[23:16] = d3_bits;
assign tx4_out[31:24] = d4_bits;

tx4 tx4i (
    .clk(clk),
    .en(pin_prompt_ready),
    .data_in(tx4_out)
);


endmodule // topinput wire clk
