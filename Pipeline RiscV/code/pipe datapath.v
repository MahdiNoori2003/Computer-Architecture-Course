module PipeLine(input luid,clk,rst,init,stallf,stalld,flushd,flushe,input[1:0]fwae,fwbe,input regwrited,input[1:0]resultsrcd,input memwrited,
        input [1:0]jumpd,input[2:0] branchd,input [2:0]alu_controld,input alusrcd,input[2:0]imm_srcd,output[31:0] instr_out,
        output[4:0]rs1d,rs2d,output regwritem,regwritew,output[1:0]resultsrce,pcsrce,output[4:0]rs1e,rs2e,rde,rdm,rdw);

    //fetch
    wire [31:0] pc_in,pcplus4f,pcf,instrf;
    //decode
    wire [31:0] instrd, pcd, pcplus4d,rd1d,rd2d,extimmd;
    //excution
    wire [1:0]jumpe;
    wire [2:0] branche;
    wire regwritee, memwritee, alusrce,zero,neg,luie;
	wire[2:0] alu_controle;
	wire[31:0] pce;
	wire[31:0] extimme, pcplus4e, rd1e, rd2e,srcae,srcbe,writedatae,pctargete,alu_resulte;
    //memory
    wire memwritem,luim;
	wire [1:0] resultsrcm;
	wire [31:0] extimmm, pcplus4m, alu_resultm, writedatam,readdatam,lui_result;
    //wb
	wire[1:0] resultsrcw;
	wire[31:0] extimmw, pcplus4w, alu_resultw, readdataw,resultw;
    //Fetch
    mux_3to1_32bit m1 (pc_in,pcplus4f,pctargete,alu_resulte,pcsrce);
    pc_reg pc(clk, rst,init,~stallf ,pc_in,pcf);
    risc_v_instruct ins_mem(clk,rst,init,pcf,instrf);
    adder_32bit adder(pcplus4f, pcf, 32'd4);
    fetch_pipe f_pipe(instrf, pcf, pcplus4f,clk, ~stalld, flushd, instrd, pcd, pcplus4d);
    //Decode
    assign instr_out=instrd;
    assign rs1d=instrd[19:15];
    assign rs2d=instrd[24:20];
    regfile rf(regwritew,clk,rst,instrd[19:15],instrd[24:20],resultw,rdw,rd1d,rd2d);
    immidiate_extend imex(instrd[31:7], imm_srcd, extimmd);
    decode_pipe d_pipe(luid,pcplus4d, pcd, extimmd, rd1d, rd2d, rs1d, rs2d, instrd[11:7],clk, flushe, 
    regwrited, memwrited, alusrcd,resultsrcd, jumpd,alu_controld,branchd,regwritee, memwritee, alusrce,
    resultsrce, jumpe,alu_controle,branche,pce,rs1e, rs2e, rde,extimme, pcplus4e, rd1e, rd2e,luie);
    JBfinder jb( zero, neg,jumpe,branche,pcsrce);
    //Excution
    mux_3to1_32bit m2(srcae, rd1e, resultw, lui_result, fwae);//
    mux_3to1_32bit m3(writedatae, rd2e, resultw, lui_result, fwbe);//
    mux_2to1_32bit m4(srcbe, writedatae, extimme, alusrce);
    adder_32bit adder1(pctargete, pce, extimme);
    ALU alu(alu_controle,srcae,srcbe, alu_resulte ,zero,neg);
    execution_pipe ex_pipe(luie,pcplus4e, alu_resulte, writedatae,rde,extimme,clk, regwritee,
    memwritee,resultsrce,regwritem, memwritem,resultsrcm,rdm,extimmm, pcplus4m, alu_resultm, writedatam,luim);
    //Memory
    mux_2to1_32bit m6(lui_result, alu_resultm, extimmm, luim);
    risc_v_memory mem(clk,rst,init,alu_resultm,writedatam,memwritem,readdatam);
    memory_pipe m_pipe(pcplus4m, alu_resultm,rdm, extimmm, readdatam,clk, regwritem,resultsrcm,
		    regwritew,resultsrcw,rdw,extimmw, pcplus4w, alu_resultw, readdataw);

    //Wb

    mux_4to1_32bit mux5(resultw, alu_resultw,readdataw,pcplus4w,extimmw,resultsrcw);
endmodule

