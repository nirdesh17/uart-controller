module txController (
    input wire clk,
    input wire reset,
    input [7:0] wire i_tx_data,
    input wire i_tx_ready,
    output wire o_tx_done,
    output wire o_tx_active,
    output wire o_tx_data
);

    localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;

    reg [2:0] r_bit_index;
    reg r_tx_done;
    reg r_tx_active;
    reg r_tx_data;
    reg [1:0] r_state;


    // logic fot tx
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            r_state <= IDLE;
            r_bit_index <= 3'b0;
            r_tx_done <= 1'b0;
            r_tx_active <= 1'b0;
            r_tx_data <= 1'b1;
        end
        else begin
            case(state)
                IDLE: begin
                    bit_index<=3'b0;
                    r_tx_done<=1'b0;
                    r_tx_data<=1'b1;
                    if(i_tx_ready==1'b1) begin
                        r_state<=START;
                        r_tx_active<=1'b1;
                    end
                    else begin
                        r_state<=IDLE;
                    end
                end

                START: begin
                    r_tx_data<=1'b0;
                    r_state<=DATA;
                end

                DATA: begin
                    r_tx_data<=i_tx_data[r_bit_index];
                    if(r_bit_index<7)begin
                        r_bit_index<=r_bit_index+1;
                        r_state<=DATA;
                    end
                    else begin
                        r_state<=STOP;
                        r_bit_index<=3'b0;
                    end
                end

                STOP: begin
                    r_state<=IDLE;
                    r_tx_active<=1'b0;
                    r_tx_done<=1'b1;
                    r_tx_data<=1'b1;
                end

                default: begin
                    r_state<=IDLE;
                end

        end
    end
    
    assign o_tx_done = r_tx_done;
    assign o_tx_active = r_tx_active;
    assign o_tx_data = r_tx_data;
    
endmodule