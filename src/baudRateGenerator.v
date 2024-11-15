module baudRateGenerator (
    input wire clk,
    input wire reset,
    output wire baud_clk
);

    parameter Divider = 434; // assuming system clock is 50MHz and baud rate is 115200
    reg [15:0] counter;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            counter <= 16'd0;
            baud_clk <= 1'b0;
        end
        else if(counter == Divider - 1) begin
            counter <= 16'b0;
            baud_clk <= ~baud_clk;
        end
        else begin
            counter <= counter + 1;
        end 
    end
    
endmodule