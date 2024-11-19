module Count;

    reg clk;
    reg reset;
    wire [3:0] count;

    counter test (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    initial begin
        $dumpfile("count.vcd");
        $dumpvars();
    end

    always #5 clk = ~clk;
        
    initial begin
        clk = 0;
        reset = 0;
        #5 reset = 1;
        #5 reset = 0; 
        #100 $finish;
    end

endmodule