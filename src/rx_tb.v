module rx_tb ;
    reg clk;
    reg reset;
    reg i_rx_data = 1;
    wire o_rx_done; 
    wire [7:0] o_rx_data;

    rxController uut (
        .clk(clk),
        .reset(reset),
        .i_rx_data(i_rx_data),
        .o_rx_done(o_rx_done),
        .o_rx_data(o_rx_data)
    );

    initial begin
        $dumpfile("rx_tb.vcd");
        $dumpvars();
    end

    always #5 clk = ~clk;
    

    initial begin
        
        clk = 0;
        reset =1;
        #5
        reset = 0;
        

        #10 i_rx_data = 0; // start bit

        #10 i_rx_data = 1; // data bit 0
        #10 i_rx_data = 0; // data bit 1
        #10 i_rx_data = 0; // data bit 2
        #10 i_rx_data = 0; // data bit 3
        #10 i_rx_data = 1; // data bit 4
        #10 i_rx_data = 1; // data bit 5
        #10 i_rx_data = 1; // data bit 6
        #10 i_rx_data = 0; // data bit 7
        
        #10 i_rx_data = 1; // stop bit

        // wait(o_rx_done);
        #100 $stop;
    end

    
endmodule