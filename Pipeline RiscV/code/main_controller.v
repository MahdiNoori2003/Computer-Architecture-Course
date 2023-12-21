module main_controller(
    input [6:0] opCode,input [2:0] func3,output we,output[1:0]result_src,
    output mem_we,alu_src,output [1:0] jump,
    output [2:0] imm_src,branch,output[1:0] alu_op,output lui
);

reg [15:0] control;

assign {we,result_src,mem_we,alu_src,jump,imm_src,branch,alu_op,lui} = control;

always @(opCode,func3) begin
    case (opCode)
        7'b0110011 : control <= 16'b1000000xxx000100; // R-type
        7'b0000011 : control <= 16'b1010100000000000; // lw-type
        7'b0100011 : control <= 16'b0xx1100001000000; // s-type
        7'b1100011 : begin // b-type
            if (func3 == 3'b000)  control <= 16'b0xx0000010001010;//branch = 3'b001
            else if (func3 == 3'b001)  control <= 16'b0xx0000010010010;//branch = 3'b010
            else if (func3 == 3'b100) control <= 16'b0xx0000010011010;// branch = 3'b011
            else if (func3 == 3'b101)  control <= 16'b0xx0000010100010;//branch = 3'b100
			else control <= 16'b0xx0000010000010;
        end
        7'b0010011 : control <= 16'b1000100000000110; // I-type
        7'b1101111 : control <= 16'b1100010100000xx0; // jal-type
        7'b1100111 : control <= 16'b1100101000000000; // jalr-type
        7'b0110111 : control <= 16'b1110x00011000xx1; // U-type
        default : control <= 16'bxxxxxxxxxxxxxxxx;
    endcase
end
    
endmodule
