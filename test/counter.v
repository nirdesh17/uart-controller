module counter (
    input wire clk,
    input wire reset,
    output wire [3:0] count
);

    reg [3:0] count_reg=0;

    always @(posedge clk) begin
        if (reset) begin
            count_reg <= 4'b0000;
        end else begin
            count_reg <= count_reg + 1;
        end
    end   

    assign count = count_reg;
endmodule