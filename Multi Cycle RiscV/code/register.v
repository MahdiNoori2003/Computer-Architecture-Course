module register (clk, rst,load ,in, out);
input clk;
input rst;
input load;
input [31:0] in;
output [31:0] out;

reg [31:0] pc;

always @(posedge clk ,posedge rst) begin
    if (rst) begin
        pc <= 32'h00000000;
    end else
    if(load)
     begin
        pc <= in;
    end
end

assign out = pc;
endmodule

