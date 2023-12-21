module pc_reg (clk, rst,init ,pc_in, pc_out);
input clk;
input rst;
input init;
input [31:0] pc_in;
output [31:0] pc_out;

reg [31:0] pc;

always @(posedge clk , posedge rst) begin
    if (rst|init) begin
        pc <= 32'h00000000;
    end else begin
        pc <= pc_in;
    end
end

assign pc_out = pc;

endmodule
