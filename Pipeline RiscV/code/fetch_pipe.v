module fetch_pipe(input [31:0] instrf, pcf, pcplus4f, 
		      input clk, enable, clear, 
		      output reg[31:0] instrd, pcd, pcplus4d);

	always@(posedge clk)begin

		if(clear)begin
			instrd = 32'b0;
			pcd = 32'b0;
			pcplus4d = 32'b0;
		end
		else if(enable)begin
			instrd = instrf;
			pcd = pcf;
			pcplus4d = pcplus4f;
		end
		else begin
			instrd = instrd;
			pcd = pcd;
			pcplus4d = pcplus4d;
		end
	end

endmodule
