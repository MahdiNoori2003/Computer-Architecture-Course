module main_controller(
    input clk,rst,input [6:0] opCode,input [2:0] func3,input zero,neg,output reg we,
    mem_we,lui,adr_src,ir_write,pc_load,output reg [1:0] result_src,
    output reg [2:0] imm_src,output reg[1:0] alu_op,alu_srcA,alu_srcB
);

parameter [4:0] F =5'd0,ID=5'd1,Exr=5'd2,Wbr=5'd3,Exs=5'd4,
    Mems=5'd5,Exlw=5'd6,Memlw=5'd7,Wblw=5'd8,Exb=5'd9,
    Exlui=5'd10,Exi=5'd11,Exjal=5'd13,
    Wbi=5'd14,Wbjal_op=5'd15,Wbjal=5'd16,Wbjalr_op=5'd17,Wbjalr=5'd18,Exjalr=5'd19;

reg[4:0] ps,ns;
reg pc_update,branch;


assign pc_load = (pc_update|(branch&((func3==3'd0 & zero)|(func3==3'd1 & ~zero)|
                (func3==3'd4 & neg)|(func3==3'd5 & ~neg))));

always @(opCode,ps,zero,neg) begin
    {we,
    mem_we,lui,adr_src,ir_write,pc_update,branch,result_src,
    imm_src,alu_op,alu_srcA,alu_srcB}=18'd0;
    case (ps)
    F:begin
        adr_src=0;
        ir_write=1;
        alu_srcA=2'b00;
        alu_srcB=2'b10;
        alu_op=2'b00;
        result_src=2'b10;
        pc_update=1;
        ns=ID;
    end
    ID:begin
        alu_srcA=2'b01;
        alu_srcB=2'b01;
        alu_op=2'b00;
        imm_src=3'b010;
        case(opCode)
        7'b0000011: ns=Exlw;
        7'b0100011: ns=Exs;
        7'b1100011: ns=Exb;
        7'b0010011 : ns=Exi;
        7'b1101111 : ns=Exjal;
        7'b1100111 : ns=Exjalr;
        7'b0110111 : ns=Exlui;
        7'b0110011 : ns=Exr;
        endcase
    end
    Exr:begin
        alu_srcA=2'b10;
        alu_srcB=2'b00;
        alu_op=2'b10;
        ns=Wbr;
    end
    Wbr:begin
        result_src=2'b00;
        we=1;
        ns=F;
    end
    Exs:begin
        imm_src=3'b001;
        alu_srcA=2'b10;
        alu_srcB=2'b01;
        alu_op=2'b00;
        ns=Mems;
    end
    Mems:begin
        result_src=2'b00;
        adr_src=1;
        mem_we=1;
        ns=F;
    end
    Exlw:begin
        imm_src=3'b000;
        alu_srcA=2'b10;
        alu_srcB=2'b01;
        alu_op=2'b00;
        ns=Memlw;
    end
    Memlw:begin
        result_src=2'b00;
        adr_src=1;
        ns=Wblw;
    end
    Wblw:begin
        result_src=2'b01;
        we=1;
        ns=F;
    end
    Exb:begin
        alu_srcA=2'b10;
        alu_srcB=2'b00;
        alu_op=2'b01;
        result_src=2'b00;
        imm_src=3'b001;
        branch=1;
        ns=F;
    end
    Exlui:begin
        we=1;
        lui=1;
        imm_src=3'b011;
        ns=F;
    end
    Exi:begin
        alu_srcA=2'b10;
        alu_srcB=2'b01;
        alu_op=2'b11;
        imm_src=3'b000;
        ns=Wbi;
    end
    Wbi:begin
        result_src=2'b00;
        we=1;
        ns=F;
    end
    Exjal:begin
        alu_srcA=2'b01;
        alu_srcB=2'b01;
        alu_op=2'b00;
        imm_src=3'b100;
        ns=Wbjal_op;
    end
    Wbjal_op:begin
        result_src=2'b00;
        alu_srcA=2'b01;
        pc_update=1;
        alu_srcB=2'b10;
        alu_op=2'b00;
        ns=Wbjal;
    end
    Wbjal:begin
        we=1;
        result_src=2'b00;
        ns=F;
    end
    Exjalr:begin
        alu_srcA=2'b10;
        alu_srcB=2'b01;
        alu_op=2'b00;
        imm_src=3'b000;
        ns=Wbjalr_op;
    end
    Wbjalr_op:begin
        result_src=2'b00;
        alu_srcA=2'b01;
        pc_update=1;
        alu_srcB=2'b10;
        alu_op=2'b00;
        ns=Wbjalr;
    end
    Wbjalr:begin
        we=1;
        result_src=2'b00;
        ns=F;
    end
    endcase
end

always @(posedge clk,posedge rst) begin
    if (rst) ps<=F;
    else ps<=ns;
end
    
endmodule
