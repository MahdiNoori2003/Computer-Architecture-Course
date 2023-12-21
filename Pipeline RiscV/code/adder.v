module adder_32bit (out, in0, in1);
input [31:0] in0;
input [31:0] in1;
output [31:0] out;

assign out = in0 + in1;

endmodule
