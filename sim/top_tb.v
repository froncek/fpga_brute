`timescale 1ns/1ps;

module top_tb ();

  reg tb_clk = 1'b1;

  top tb_top (
    .clk(tb_clk),
    .ftdi_rx(1'b1),
    .board1_rx(board_uart)
  );

  reg [7:0] tx_data;
  reg tx_en;
  wire tx_rdy;

  uart_tx tb_tx (
    .clk(tb_clk),
    .rst(1'b0),
    .dout(board_uart),
    .data_in(tx_data),
    .en(tx_en),
    .rdy(tx_rdy)
  );

  always
  begin
    #5 tb_clk <= ~tb_clk;
  end

  initial
  begin
    #1000
    @(posedge tb_clk);
    tx_data <= 8'h3A;
    tx_en <= 1'b1;
    @(posedge tb_clk);
    tx_en <= 1'b0;
    @(posedge tb_clk);
    wait(tx_rdy)
    $stop;
    #1000000
    @(posedge tb_clk);
    tx_data <= 8'h69;
    tx_en <= 1'b1;
    @(posedge tb_clk);
    tx_en <= 1'b0;
    @(posedge tb_clk);
    wait(tx_rdy)
    $stop;
  end

endmodule
