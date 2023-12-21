module CPU (
    input clk,rst,init,output done
);

wire reg_write,alu_src,result_src,sel,lui,zero,neg,mem_we;
wire[1:0] pc_src;
wire [2:0] alu_control,ImmSrc;
wire [31:0] instruct,mem_out,ins_addr,mem_addr,mem_wd;

riscv_controller controller(
    zero,neg,
    instruct[6:0],instruct[14:12],instruct[31:25],
    reg_write,result_src,mem_we,sel,alu_src,lui,
    pc_src,
    ImmSrc,alu_control
);

riscv_dp data_path(
    clk,rst,init,reg_write,alu_src,result_src,sel,lui,
    pc_src,
    alu_control,ImmSrc,
    instruct,mem_out,zero,neg,
    ins_addr,mem_addr,mem_wd
);

risc_v_instruct ins_mem(
  clk,
  rst,
  init,
  ins_addr,
  instruct
);

risc_v_memory data_mem
(
  clk,
  rst,
  init,
  mem_addr,
  mem_wd,
  mem_we,
  mem_out
);

assign done= (instruct)?1'b0:1'b1;
    
endmodule