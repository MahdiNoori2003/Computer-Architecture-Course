module risc_v_instruct
#(
    parameter WIDTH =1023
)
(
  input clk,
  input rst,
  input init,
  input [31:0] addr,
  output reg [31:0] dout
);

reg [31:0] mem[0:WIDTH];

always @(posedge clk,posedge rst) begin
    if (init|rst) begin
        $readmemh("../inputs/code.txt", mem);
    end
end

assign dout = mem[addr>>2];
endmodule

