module debounce (
    input wire clk,
    input wire din,
    output reg dout = 1'b0
);

reg [7:0] shift = 8'd0;

always @(posedge clk)
begin
    dout <= 1'b0;
    shift <= {din, shift[7:1]};
    if(shift == 8'hff)
    begin
        dout <= 1'b1;
    end
end

endmodule