module resetter(
    input wire clk,
    input wire rst_in,
    output wire rst_out
);

reg [15:0] reset_shifter;
assign rst_out = reset_shifter[0];

always @(posedge clk) begin
   reset_shifter <= {1'b1, reset_shifter[15:1]};

   if(rst_in) begin
     reset_shifter <= 16'd0;
   end 
end

endmodule // resetter