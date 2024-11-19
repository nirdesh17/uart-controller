module txController (
    input wire clk,
    input wire reset,
    input wire [7:0] i_tx_data,
    input wire i_tx_ready,
    output wire o_tx_data
);

    localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;

    reg [2:0] r_bit_index = 0;
    reg r_tx_data = 1;
    reg [1:0] r_state = 0;

    // logic for tx
    always @(posedge clk) begin
        if (reset) begin
            r_state <= IDLE;
            r_bit_index <= 3'b0;
        end else begin
            case (r_state)
                IDLE: begin
                    r_bit_index <= 3'b0;
                    if (i_tx_ready == 1'b0) begin
                        r_state <= DATA;
                    end else begin
                        r_state <= IDLE;
                    end
                end

                DATA: begin
                    r_tx_data <= i_tx_data[r_bit_index];
                    $display("TX Data bit %d: %d", r_bit_index, r_tx_data);
                    if (r_bit_index < 7) begin
                        r_bit_index <= r_bit_index + 1;
                        r_state <= DATA;
                    end else begin
                        r_state <= STOP;
                        r_bit_index <= 3'b0;
                    end
                end

                STOP: begin
                    r_state <= IDLE;
                    r_tx_data <= 1'b1;
                end

                default: begin
                    r_state <= IDLE;
                end
            endcase
        end
    end
    
    assign o_tx_data = r_tx_data;
    
endmodule