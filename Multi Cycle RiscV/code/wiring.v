module CPU(input clk,rst,init,output done);

    wire regwe,adrsrc,pc_load,mem_we,IRload,zero,neg,lui;
    wire [1:0] resultsrc , alusrcB , alusrcA,Aluop;
    wire [2:0] imm_src,alu_control;
    wire [31:0] mem_out,mem_addr,mem_wd,instruct;
    risc_v_multi_data_path dp(
        clk,rst,init,regwe,adrsrc, pc_load,IRload ,lui, resultsrc , alusrcB , alusrcA
        ,imm_src,alu_control,mem_out,zero,neg ,mem_addr,mem_wd,instruct
    );

    risc_v_memory mem(clk , rst , init,mem_addr,mem_wd,mem_we,mem_out);
    ALUControl alu_cnt(Aluop,
        instruct[31:25], instruct[14:12],
        alu_control);
    main_controller controller(
    clk,rst,instruct[6:0], instruct[14:12], zero,neg, regwe,
    mem_we,lui,adrsrc,IRload,pc_load,resultsrc,
    imm_src,Aluop,alusrcA,alusrcB
);

    assign done=(mem_out!={32{1'bx}})?0:1;

endmodule