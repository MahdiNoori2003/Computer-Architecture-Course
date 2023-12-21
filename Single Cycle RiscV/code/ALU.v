module ALU (input [2:0] alu_selector,input [31:0] in1,in2, output reg [31:0] out ,output zero,output neg);
    always @(in1,in2,alu_selector) begin
        case (alu_selector)
            3'b000: out= in1+in2;
            3'b001: out= in1-in2;
            3'b010: out= in1 & in2;
            3'b011: out= in1 | in2;
            3'b101: out= (in1<in2);
            3'b110: out= in1^in2;
            default: out=in2;
        endcase
    end

    assign neg = out[31];
    assign zero= ~|out;
endmodule
