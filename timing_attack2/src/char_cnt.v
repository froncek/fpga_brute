module char_cnt(
    input wire clk,
    input wire din,
    input wire rst,
    output reg valid
);

reg [3:0] num_of_chars = 4'b0; 
wire received_data;

uart_rx uart_rx_i (
    .clk(clk),
    .rst(1'b0),
    .din(din),
    .valid(received_data)   
);

always @(posedge clk) begin
    if (rst) begin
        num_of_chars <= 4'd0;
    end
    else
    begin
        valid <= 1'b0;
        if(received_data)
        begin
            num_of_chars <= num_of_chars + 1'd1;
            if(num_of_chars == 4'd15)
            begin
                valid <= 1'b1;
                num_of_chars <= 4'd0;
            end
        end
    end
end

endmodule // char_cnt