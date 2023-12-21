module main_controller(
    input [6:0] opCode,input [2:0] func3,input zero,neg,output we,result_src,
    mem_we,sel,alu_src,lui,output [1:0] pc_src,
    output [2:0] imm_src,output[1:0] alu_op
);

reg [12:0] control;

assign {we,pc_src,result_src,mem_we,sel,
        imm_src,alu_src,lui,alu_op} = control;

always @(opCode,zero,neg) begin
    case (opCode)
        7'b0110011 : control <= 13'b100000xxx0010; // R-type
        7'b0000011 : control <= 13'b1001000001000; // lw-type
        7'b0100011 : control <= 13'b000x1x0011000; // s-type
        7'b1100011 : begin // b-type
            if ((func3==3'd0 & zero)|(func3==3'd1 & ~zero)|
                (func3==3'd4 & neg)|(func3==3'd5 & ~neg)) 
                    control <= 13'b001x0x0100001;
            else 
                control <= 13'b000x0x0100001;   
        end
        7'b0010011 : control <= 13'b1000000001011; // I-type
        7'b1101111 : control <= 13'b101x01100x0xx; // jal-type
        7'b1100111 : control <= 13'b110x010001000; // jalr-type
        7'b0110111 : control <= 13'b000x0x011x1xx; // U-type
        default : control    <= 13'bxxxxxxxxxxxxx;
    endcase
end
    
endmodule
