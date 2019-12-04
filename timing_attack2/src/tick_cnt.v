module tick_cnt(
    input wire clk,
    input wire rst,
    output reg [31:0] data_out
);

always @(posedge clk ) begin
    data_out <= data_out + 32'd1;
    
    if(rst) begin
        data_out <= 32'd0;
    end
end

endmodule // tick_cnt