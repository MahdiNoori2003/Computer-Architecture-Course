module risc_v_multi_data_path (
        input clk , rst,init, regwe,adrsrc, pc_load,IRload , lui,input[1:0]  resultsrc , alusrcB , alusrcA
        ,input [2:0] imm_src,alu_control,input[31:0]mem_out,output zero,neg , output [31:0] mem_addr,mem_wd,instruct
    );
    wire one = 1;
    
    wire [31:0] pc_in , pc_out , old_pc_out,me_in ,ir_out, rd1 , rd2 , Aout ,
         Bout, alu_out , alu_reg_out, MDR_out , result_out, im_out,aluin1,
         aluin2,reg_file_in;
    register pc (clk, rst, pc_load,result_out,pc_out);
    mux_2to1_32bit m1 (mem_addr,pc_out,result_out , adrsrc);
    mux_2to1_32bit m5 (reg_file_in,result_out,im_out, lui);
    register IR (clk , rst ,IRload,mem_out,ir_out);
    register old_pc (clk, rst ,one , pc_out,old_pc_out);
    register MDR(clk , rst, one , mem_out, MDR_out);
    regfile rf(regwe , clk , rst, ir_out[19:15],ir_out[24:20], reg_file_in,ir_out[11:7],rd1,rd2);
    register A (clk , rst , one , rd1 ,Aout);
    register B ( clk , rst , one , rd2 , Bout);
    immidiate_extend extender(ir_out[31:7], imm_src, im_out);
    ALU alu (alu_control,aluin1,aluin2,alu_out,zero,neg);
    mux_3to1_32bit m2 (aluin1,pc_out,old_pc_out,Aout,alusrcA);
    mux_3to1_32bit m3 (aluin2,Bout,im_out,32'd4,alusrcB);
    register alue_res (clk,rst , one , alu_out, alu_reg_out);
    mux_3to1_32bit m4(result_out,alu_reg_out,MDR_out,alu_out,resultsrc);
    assign mem_wd = rd2 ;
    assign instruct=ir_out;
endmodule
