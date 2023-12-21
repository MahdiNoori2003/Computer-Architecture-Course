module ALUControl(
input [1:0] Aluop,
input [6:0] funct7,input [2:0] funct3,
output reg [2:0] Control);
always @(Aluop)
begin
    if (Aluop==2'b00) Control <= 3'b000;
    else if (Aluop==2'b01) Control <= 3'b001;
    else if (Aluop==2'b10) begin
        case({funct7,funct3})
            10'b0000000000 : Control <= 3'b000; // add
            10'b0100000000 : Control <= 3'b001; // sub
            10'b0000000111 : Control <= 3'b010; // and
            10'b0000000110 : Control <= 3'b011; // or
            10'b0000000010 : Control <= 3'b101; // slt
            default : Control <= 3'bxxx;
        endcase
    end
    else if (Aluop==2'b11) begin
        case(funct3)
            3'b000 : Control <= 3'b000; // addi
            3'b010 : Control <= 3'b101; // slti
            3'b100 : Control <= 3'b110; // xori
            3'b110 : Control <= 3'b011; // ori
            3'b111 : Control <= 3'b010; // andi
            default : Control <= 3'bxxx;
        endcase
    end
    else Control<= 3'bxxx;
end
endmodule
