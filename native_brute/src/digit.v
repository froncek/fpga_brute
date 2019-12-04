module digit(
    input wire clk,
    input wire enable,
    output wire [7:0] data_out,
    output wire overflow_out
);

reg [3:0] counter = 4'b0;
reg overflow =1'b0;

assign data_out = {4'h3, counter};
assign overflow_out = overflow;

always @(posedge clk) begin
    overflow <= 4'd0;

    if (enable) begin
        counter <= counter + 1'd1;

        if (counter == 4'd9) begin
            overflow <= 1'd1;
            counter <= 1'd0;
        end
    end
end

endmodule // digit