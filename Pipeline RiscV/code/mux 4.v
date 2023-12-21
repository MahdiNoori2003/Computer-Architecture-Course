module mux_4to1_32bit (out, in0, in1, in2,in3, sel);
input [31:0] in0;
input [31:0] in1;
input [31:0] in2;
input [31:0] in3;
input [1:0] sel;
output [31:0] out;

assign out = (sel == 2'b00) ? in0 : (sel == 2'b01) ? in1 : (sel == 2'b10) ? in2 : in3;

endmodule
