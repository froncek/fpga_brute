

module delay(
   input wire clk,
   input wire en,
   input wire [15:0] data_in,
   output reg valid
);


parameter DELAY_IDLE  = 1'b0;
parameter DELAY_DATA = 1'b1;

reg state   = DELAY_IDLE;
reg [15:0] data = 16'd0; 

always  @ (posedge clk)
begin
    
    valid <= 1'b0;
    data <= data - 1'b1;

    case(state)
        DELAY_IDLE:
        begin 
            if (en)
            begin
                data <= data_in;
                state <= DELAY_DATA;
            end
        end

        DELAY_DATA:
        begin
            if (data == 16'd0)
            begin
                valid <= 1'b1;
                state <= DELAY_IDLE;
            end
        end

    endcase

    
end 

endmodule 