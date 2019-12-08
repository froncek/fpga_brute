
module top (

    input wire clk,
    input wire ftdi_rx,
    input wire board1_rx,
    output wire ftdi_tx,
    output wire board1_tx,
    output wire board1_rst,
    output wire vcc_select
);

assign ftdi_tx = board1_rx;
assign board1_tx = ftdi_rx;

wire glitch_en; 
wire [15:0] delay_out;
wire [7:0] width_out;
wire delay_valid;


cmd cmdi(
    .clk(clk),
    .din(ftdi_rx),
    .glitch_en(glitch_en),
    .delay_out(delay_out),
    .width_out(width_out)
);

resetter resetteri (
    .clk(clk),
    .rst_in(glitch_en),
    .rst_out(board1_rst)
);


delay delayi (
   .clk(clk),
   .en(glitch_en),
   .data_in(delay_out),
   .valid(delay_valid)
);


pulse pulsei (
    .clk(clk),
    .en(delay_valid),
    .data_in(width_out),
    .dout(vcc_select)
);



endmodule 