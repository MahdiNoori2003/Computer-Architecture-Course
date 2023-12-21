module CPU_Tb();
    
    reg clk=0,rst=0,init=0;
    wire done;

    CPU UUT(clk,rst,init,done);

    always begin
        #2 clk=~clk;
    end

    initial begin
        #1 rst=1;
        #4 rst=0;
        wait(done==1)
        #2 $stop;
    end

endmodule