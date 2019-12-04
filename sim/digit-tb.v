`timescale 1ns / 1ps

module digit_tb();

reg tb_clk = 1'b0;
reg tb_ena = 1'b0;
wire overflow_d1;

digit digit1i (
    .clk(tb_clk),
    .enable(tb_ena),
    .overflow_out(overflow_d1)
);

digit digit2i (
    .clk(tb_clk),
    .enable(overflow_d1)
);

always
begin
    #5 tb_clk <= ~tb_clk;
end

always
begin
    #20 tb_ena <= ~tb_ena;
end

endmodule