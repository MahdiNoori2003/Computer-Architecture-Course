
module mux_2to1_32bit (out, in0, in1, sel);
input [31:0] in0;
input [31:0] in1;
input sel;
output [31:0] out;

assign out = (sel == 1'b0) ? in0 : in1;

endmodule
    