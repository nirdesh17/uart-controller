module uartController (
    input wire clk,
    input wire reset,
    input wire [7:0] i_tx_data,
    input wire i_tx_ready,
    input wire i_rx_data,
    output wire o_tx_data,
    output wire [7:0] o_rx_data
);

    wire baud_clk;
    baudRateGenerator baudRateGenerator_inst (
        .clk(clk),
        .reset(reset),
        .baud_clk(baud_clk)
    );
    
    txController txController_inst (
        .clk(clk),
        .reset(reset),
        .i_tx_data(i_tx_data),
        .i_tx_ready(i_tx_ready),
        .o_tx_data(o_tx_data)
    );

    rxController rxController_inst (
        .clk(clk),
        .reset(reset),
        .i_rx_data(i_rx_data),
        .o_rx_data(o_rx_data)
    );
endmodule