module rxController #(parameter OVERSAMPLE = 8)(
    input wire clk,
    input wire reset,
    input wire i_rx_data,
    output wire o_rx_done,
    output wire [7:0] o_rx_data
);

    localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;

    reg [2:0] r_bit_index;
    reg [7:0] r_rx_data;
    reg [4:0] r_clk_count;
    reg [2:0] r_state;
    reg r_rx_done;

    // logic for rx
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            r_state <= IDLE;
            r_bit_index <= 3'b0;
            r_rx_data <= 8'b0;
            r_rx_done <= 1'b0;
            r_clk_count <= 5'b0;
        end
        else begin
            case(r_state) 
                IDLE: begin
                    r_bit_index <= 3'b0;
                    r_rx_done <= 1'b0;
                    r_clk_count <= 5'b0;
                    if(r_rx_data==1'b0) begin
                        r_state <= START;
                    end
                    else begin
                        r_state <= IDLE;
                    end
                end

                START: begin
                    if(r_clk_count == OVERSAMPLE/2) begin
                        if(r_rx_data == 1'b0) begin
                            r_state <= DATA;
                            r_clk_count <= 0;
                        end
                        else begin
                            r_state <= IDLE;
                        end
                    end
                    else begin
                        r_state <= START;
                        r_clk_count <= r_clk_count + 1;
                    end
                end

                DATA: begin
                     if(r_clk_count < OVERSAMPLE) begin
                        r_clk_count <= r_clk_count + 1;
                        r_state <= DATA;
                     end
                     else begin
                        r_rx_data[r_bit_index] <= i_rx_data;
                        r_clk_count <= 0;
                        if(r_bit_index < 7) begin
                            r_bit_index <= r_bit_index + 1;
                            r_state <= DATA;
                        end
                        else begin
                            r_bit_index <= 0;
                            r_state <= STOP;
                        end
                     end
                end

                STOP: begin
                    if(r_clk_count < OVERSAMPLE) begin
                        r_state<=STOP;
                        r_clk_count <= r_clk_count + 1;
                    end
                    else begin
                        r_state <= IDLE;
                        r_rx_done <= 1'b1;
                        r_clk_count<=0;
                    end
                end

                default:begin
                    r_state <= IDLE;
                end
            endcase
        end
    end

    assign o_rx_data = r_rx_data? r_rx_data: 8'b0;
    assign o_rx_done = r_rx_done;    
endmodule