// `timescale 1ns/1ps
module uartController_tb;

    reg clk;
    reg reset;
    reg [7:0] i_tx_data;
    reg i_tx_ready;
    wire o_tx_data;
    reg i_rx_data;
    wire [7:0] o_rx_data;

    uartController uut (
        .clk(clk),
        .reset(reset),
        .i_tx_data(i_tx_data),
        .i_tx_ready(i_tx_ready),
        .i_rx_data(i_rx_data),
        .o_tx_data(o_tx_data),
        .o_rx_data(o_rx_data)
    );


    initial begin
        $dumpfile("uart_tb.vcd"); 
        $dumpvars(0, uartController_tb);    
    end

    always #5 clk = ~clk;

    integer i; 
    initial begin
        clk = 0;
        i_tx_data = 0;
        reset = 1;
        #10 reset = 0;
        #10 i_tx_ready =  1;
        #10 i_tx_ready =  0;
        #80 i_tx_data = 8'b11110000;

        
        
        #10 i_rx_data = 0;
        for (i = 0; i < 8; i = i + 1) begin
            #10 i_rx_data = i_tx_data[i];
        end
        // #10 i_rx_data = o_tx_data;

        #100 $finish;
    end


endmodule
