# iverilog -o rx_tb.vvp rx_controller.v rx_tb.v
# vvp rx_tb.vvp

# iverilog -o tx_tb.vvp tx_controller.v tx_tb.v
# vvp tx_tb.vvp

iverilog -o uart_tb.vvp uart_controller.v tx_controller.v rx_controller.v baudRateGenerator.v uart_tb.v
vvp uart_tb.vvp