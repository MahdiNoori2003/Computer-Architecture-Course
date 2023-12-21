module riscv_dp(
    input clk,rst,init,reg_write,alu_src,result_src,sel,lui,
    input[1:0] pc_src,
    input [2:0] alu_control,ImmSrc,
    input[31:0]instruct,mem_out,output zero,neg,
    output[31:0]ins_addr,mem_addr,mem_wd
);
wire [31:0]pc_in,pc_out,reg_file_in,out1,out2,
    alu_in2,imm_out,alu_out,result_out,sel_out,pc4,
    pcoffset;

assign ins_addr=pc_out;
assign mem_addr=alu_out;
assign mem_wd=out2;

pc_reg pc(clk,rst,init,pc_in, pc_out);
regfile rf(reg_write,clk,rst,
    instruct[19:15],instruct[24:20],reg_file_in,instruct[11:7],out1,out2); 
ALU alu(alu_control,out1,alu_in2, alu_out ,zero,neg);
immidiate_extend imm(instruct[31:7], ImmSrc, imm_out);
mux_2to1_32bit mux1(alu_in2, out2, imm_out, alu_src);
mux_2to1_32bit mux2(result_out, alu_out, mem_out, result_src);
mux_2to1_32bit mux3(sel_out, result_out, pc4, sel);
mux_2to1_32bit mux4(reg_file_in, sel_out, imm_out, lui);
adder_32bit pc4adder1(pc4, pc_out, 32'd4);
adder_32bit pc4adder2(pcoffset, pc_out, imm_out);
mux_3to1_32bit mux5(pc_in, pc4, pcoffset, alu_out, pc_src);
    
endmodule
