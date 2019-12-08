

module cmd (
    input wire clk,
    input wire din,
    output reg glitch_en,
    output reg [15:0] delay_out,
    output reg [7:0] width_out
);

wire [7:0] uart_data;
wire uart_valid;

uart_rx rxi (
    .clk(clk),
    .rst(1'b0),
    .din(din),
    .data_out(uart_data),
    .valid(uart_valid)
);

parameter [1:0] READ_CMD  = 2'd0;
parameter [1:0] READ_DELAY0 = 2'd1;
parameter [1:0] READ_DELAY1 = 2'd2;
parameter [1:0] READ_WIDTH = 2'd3;

reg [1:0]   state   = READ_CMD;

always  @ (posedge clk)
begin

    glitch_en <= 1'b0;
    if (uart_valid)
    begin
    
        case(state)
            READ_CMD:
            begin 
              if (uart_data == 8'b0)
              begin
                  state <= READ_DELAY0;
              end
            end

            READ_DELAY0:
            begin
               delay_out [15:8] <= uart_data;
               state <= READ_DELAY1;
            end

            READ_DELAY1:
            begin
               delay_out [7:0] <= uart_data;
               state <= READ_WIDTH;
            end

            READ_WIDTH:
            begin
               width_out [7:0] <= uart_data;
               glitch_en <= 1'b1;
               state <= READ_CMD;
            end
        endcase

    end
end 

endmodule 