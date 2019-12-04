module top(
    input wire clk,
    input wire ftdi_rx,
    output wire ftdi_tx,
    input wire board1_rx,
    output wire board1_tx,
    output wire board1_rst
);

assign board1_tx = ftdi_rx;
assign ftdi_tx = board1_rx;
assign board1_rst = 1'b1;

endmodule // topinput wire board1_tx,
