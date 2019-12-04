`timescale 1ns / 1ps

module top_tb();

// Initialize the testbench clock
reg tb_clk = 1'b0;



// Generate a 100MHz clock
// This code waits 5ns, then toggles the clock
// NOTE: THE DELAY OPERATOR (#) ONLY WORKS IN SIMULATION (!!!)
always
begin
    #5 tb_clk <= ~tb_clk;
end



// Create a signal for the serial output of the uart
wire tb_uart;



// Initialize the top module as instance "tb_top"
//
// We don't have to initialize unused signals (outputs will still be present in the simulation)
//    output wire         ftdi_tx,
//    output reg          led = 1'b1,
//    output wire [15:0]  debug_wing

reg board1_rx = 1'b1;
top tb_top (
    .clk(tb_clk),
    .ftdi_rx(tb_uart),
    .board1_rx(board1_rx)
);


reg tb_en = 1'b0;
wire tx_rdy;

// Initialize a uart_tx to test the top module. The uart_tx instance name is "tb_tx"
//
//    output reg       rdy // We don't care about the ready signal in the testbench
uart_tx tb_tx (
    .clk(tb_clk),
    .rst(1'b0), // We don't need a reset, we have initial values
    .dout(tb_uart),
    .data_in(8'h41), // Always send 0x40
    .en(tb_en), // Always transmit
    .rdy(tx_rdy)
);

initial
begin
    @(posedge tb_clk);
    @(posedge tb_clk);
    @(posedge tb_clk);
    @(posedge tb_clk);
    @(posedge tb_clk);
    
    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    @(posedge tb_clk);
    tb_en <= 1'b1;
    @(posedge tb_clk);
    tb_en <= 1'b0;
    wait(tx_rdy == 1'b0);

    wait(tx_rdy);
    #1000
    @(posedge tb_clk);
    board1_rx <= 1'b0;
    @(posedge tb_clk);
    @(posedge tb_clk);
    @(posedge tb_clk);
    @(posedge tb_clk);
    board1_rx <= 1'b1;
end

endmodule
