module tx_tb;
    reg clk;
    reg reset;
    reg [7:0] i_tx_data=0;
    reg i_tx_ready=0;
    wire o_tx_data;

    txController uut (
        .clk(clk),
        .reset(reset),
        .i_tx_data(i_tx_data),
        .i_tx_ready(i_tx_ready),
        .o_tx_data(o_tx_data)
    );

    initial begin
        $dumpfile("tx_tb.vcd"); 
        $dumpvars(0,tx_tb);    
    end

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #5 reset = 0;
        #10 i_tx_ready = 1;
        i_tx_ready=0;
        i_tx_data = 8'b11110000;
        #10 i_tx_ready = 1;
        #100 $finish;
    end
    
endmodule