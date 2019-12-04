module tick_cnt(
    input wire clk,
    input wire rst,
    output wire [31:0] data_out
);

reg counter = 32'd0;
assign data_out = counter;

always @(posedge clk ) begin
    counter <= counter + 32'd1;
    
    if(rst) begin
        counter <= 32'd0;
    end
end

endmodule // tick_cnt