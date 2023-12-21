module JBfinder (input zero, neg,input [1:0] jumpe,input [2:0] branche,
        output reg [1:0] pcsrce
);
    always @(zero,neg,jumpe,branche) begin
        if(branche == 3'b000 && jumpe == 2'b00) pcsrce = 2'b00;
        else if(branche == 3'b001 && zero) pcsrce = 2'b01;
        else if(branche == 3'b010 && ~zero) pcsrce = 2'b01;
        else if(branche == 3'b011 && neg) pcsrce = 2'b01;
        else if(branche == 3'b100 && ~neg) pcsrce = 2'b01;
        else if(jumpe == 2'b01) pcsrce = 2'b10;
        else if(jumpe == 2'b10) pcsrce = 2'b01;
        else pcsrce = 2'b00;
    end
    
endmodule

