module rxController(
    input wire clk,
    input wire reset,
    input wire i_rx_data,
    output wire [7:0] o_rx_data
);

    localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;

    reg [2:0] r_bit_index = 0;
    reg [7:0] r_rx_data = 0;
    reg [2:0] r_state = 0;

    // logic for rx
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            r_state <= IDLE;
            r_bit_index <= 3'b0;
            r_rx_data <= 8'b0;
        end
        else begin
            case(r_state) 
                IDLE: begin
                    r_bit_index <= 3'b0;
                    if(i_rx_data == 1'b0) begin
                        r_state <= DATA;
                    end
                    else begin
                        r_state <= IDLE;
                    end
                end

                DATA: begin
                    $display("RX Data bit %d: %d", r_bit_index, i_rx_data);
 
                    r_rx_data[r_bit_index] <= i_rx_data;
                    if(r_bit_index < 7) begin
                        r_bit_index <= r_bit_index + 1;
                        r_state <= DATA;
                    end
                    else begin
                        r_bit_index <= 0;
                        r_state <= STOP;
                    end
                    // $display("RX Data bit %d: %d", r_bit_index, i_rx_data);
                end

                STOP: begin
                    r_state <= IDLE;
                end

                default: begin
                    r_state <= IDLE;
                end
            endcase
        end
    end

    assign o_rx_data = r_rx_data;  
endmodule