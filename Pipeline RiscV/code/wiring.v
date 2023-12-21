module CPU(input clk,rst,init);
wire regwrited,memwrited,alusrcd;
wire [2:0] imm_srcd,alu_controld,branchd;
wire [1:0] alu_op,resultsrcd;
wire [31:0] instr_out;
wire [4:0]rs1d, rs2d, rs1e, rs2e, rde,rdm,rdw;
wire [1:0] pcsrce,resultsrce,fwae, fwbe,jumpd;
wire regwritem,regwritew,stallf, stalld, flushd, flushe,luid;

PipeLine dp(luid,clk,rst,init,stallf,stalld,flushd,flushe,fwae,fwbe,regwrited,resultsrcd,memwrited,
        jumpd, branchd,alu_controld,alusrcd,imm_srcd,instr_out,
        rs1d,rs2d,regwritem,regwritew,resultsrce,pcsrce,rs1e,rs2e,rde,rdm,rdw);

ALUControl alu_cu(alu_op,instr_out[31:25],instr_out[14:12],alu_controld);

main_controller Cu(
    instr_out[6:0] ,instr_out[14:12],regwrited,resultsrcd,memwrited,alusrcd,jumpd,
    imm_srcd,branchd,alu_op,luid
);

hz_unit hu(rst,rs1d, rs2d, rs1e, rs2e, rde, pcsrce,resultsrce,rdm,regwritem,regwritew,rdw,
        stallf, stalld, flushd, flushe,fwae, fwbe);
        
endmodule
