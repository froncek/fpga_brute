`define SYSTEM_CLOCK 100_000_000
`define CNT_DELAY (`SYSTEM_CLOCK/15)
// 1111111001010000001010101 - 25 bits

module delay (
    input wire clk,
    input wire rst,
    output reg cycle = 1'b0
);

// Declaration of internal registers
reg [26:0] cnt = 27'd0;

// Sequential logic
always @(posedge clk)
begin
    if (rst)
    begin
        cnt <= 27'd0;
    end
    else
    begin
        cycle <= 1'b0;
        cnt <= cnt + 1'b1;

        if(cnt == `CNT_DELAY)
        begin
            cycle <= 1'b1;
            cnt <= 27'd0;
        end
    end
end

endmodule