module detect(
    input wire clk,
    input wire [7:0] data_in,
    input wire din,
    output reg valid
);

wire [7:0] uart_data_out; 
wire uart_valid;

uart_rx urx_i (
    .clk(clk),
    .rst(1'b0),
    .din(din),
    .data_out(uart_data_out),
    .valid(uart_valid)
);

always @(posedge clk ) begin
    valid <= 1'b0;
    if(uart_valid && uart_data_out == data_in) begin
        valid <= 1'b1;
    end
end

endmodule // detect