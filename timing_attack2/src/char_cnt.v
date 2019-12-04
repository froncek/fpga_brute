module char_cnt(
    input wire clk,
    input wire din,
    input wire rst,
    output wire valid
);

reg num_of_chars = 5'b0; 
wire received_data;
assign valid = num_of_chars == 5'd16;

uart_rx uart_rx_i (
    .clk(clk),
    .rst(rst),
    .din(din),
    .valid(received_data)   
);

always @(posedge clk) begin
    num_of_chars <= num_of_chars;

    if (rst) begin
        num_of_chars <= 16'd0;
    end else if(received_data) begin
        num_of_chars <= num_of_chars + 16'd1;
    end
end

endmodule // char_cnt