module risc_v_memory
#(
    parameter WIDTH =1023
)
(
  input clk,
  input rst,
  input init,
  input [31:0] addr,
  input [31:0] din,
  input we,
  output reg [31:0] dout
);

reg [31:0] mem[0:WIDTH];

always @(posedge clk,posedge rst) begin
    if (init|rst) begin
        $readmemh("../inputs/memory.txt", mem);
    end
    else if (we) begin
    mem[addr>>2] <= din;
    end
end

assign dout = mem[addr>>2];

endmodule
