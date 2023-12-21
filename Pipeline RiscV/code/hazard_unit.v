module hz_unit (input init,input[4:0] rs1d, rs2d, rs1e, rs2e, rde,input[1:0] pcsrce,
        input[1:0] resultsrce,input[4:0] rdm,input regwritem,input regwritew,input[4:0] rdw,
        output reg stallf, stalld, flushd, flushe, output reg [1:0] fwae, fwbe);

reg stall_lw;
assign flushd = (|pcsrce);
assign flushe = (stall_lw || (|pcsrce));
assign {stall_lw, stallf, stalld, fwae, fwbe} = init?7'd0:{stall_lw, stallf, stalld, fwae, fwbe};

always @(rs1d,rs2d,rs1e,rs2e,rde,pcsrce,resultsrce,rdm,regwritem,regwritew,rdw) begin
    {stall_lw, stallf, stalld, fwae, fwbe}=7'd0;
    if(((rs1e == rdm) && regwritem) && (rs1e != 5'd0))
        fwae = 2'b10;
    else if (((rs1e == rdw) && regwritew) && (rs1e != 5'd0))
        fwae = 2'b01;
    else 
        fwae = 2'b00;

    if(((rs2e == rdm) && regwritem) && (rs2e != 5'd0))
        fwbe = 2'b10;
    else if (((rs2e == rdw) && regwritew) && (rs2e != 5'd0))
        fwbe = 2'b01;
    else 
        fwbe = 2'b00;

    if (((rs1d == rde) || (rs2d == rde)) && (resultsrce==2'b01))
        {stall_lw,stalld, stallf} = 3'b111;
        
end
    
endmodule
