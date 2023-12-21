module mux_3to1_32bit (out, in0, in1, in2, sel);
input [31:0] in0;
input [31:0] in1;
input [31:0] in2;
input [1:0] sel;
output reg [31:0] out;

always @(sel,in0,in1,in2) begin
	if (sel == 2'b00) out = in0;
	else if (sel == 2'b01) out =  in1;
	else if (sel == 2'b10) out = in2;
	else out = in0;
end

endmodule
