

module pulse(
    input clk,
    input wire en,
    input wire [7:0] data_in,
    output reg dout = 1'b0
);


parameter PULSE_IDLE  = 1'b0;
parameter PULSE_DATA = 1'b1;

reg state   = PULSE_IDLE;
reg [7:0] data = 8'd0; 

always  @ (posedge clk)
begin
    
    data <= data - 1'b1;

    case(state)
        PULSE_IDLE:
        begin 
            if (en)
            begin
                data <= data_in;
                dout <= 1'b1;
                state <= PULSE_DATA;
            end
        end

        PULSE_DATA:
        begin
            if (data == 8'd0)
            begin
                dout <= 1'b0;
                state <= PULSE_IDLE;
            end
        end

    endcase

    
end 



endmodule