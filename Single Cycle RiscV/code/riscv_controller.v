module riscv_controller(
    input zero,neg,
    input [6:0] opCode,input [2:0] func3,input[6:0] func7,
    output we,result_src,mem_we,sel,alu_src,lui,
    output [1:0] pc_src,
    output [2:0] imm_src,alu_control
);

wire [1:0] alu_op;

main_controller m(
    opCode, func3, zero,neg,we,result_src,
    mem_we,sel,alu_src,lui, pc_src,
    imm_src,alu_op
);

ALUControl alu_cu(
alu_op, func7, func3,
alu_control);
    
endmodule
