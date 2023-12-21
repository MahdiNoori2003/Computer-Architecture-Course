module regfile (input we,clk,rst,input [4:0] A1,A2,input [31:0] data,input [4:0] A3,output [31:0]out1,out2); 
reg [31:0] register [0:31]; 
assign out1 = (A1 == 0)? 0 : register[A1]; 
assign out2 = (A2 == 0)? 0 : register[A2]; 
integer i; 
always @(posedge clk , posedge rst)  begin
if (rst) begin
    for (i = 0; i < 32; i = i + 1)
	   register[i] <= 0; 
end
else if ((A3 != 0) && we) 
	 register[A3] <= data; 
end
endmodule
 
 
