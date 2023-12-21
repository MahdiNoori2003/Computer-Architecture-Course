`timescale 1ns/1ns
module TB();
    reg clk = 0,rst=1,init=0;
    CPU UUT (clk, rst,init);
    always begin
        #10 clk = ~clk;
    end
    initial begin
        #15 rst = ~rst;
        #15000 $stop;
    end

endmodule

