`timescale 1ns / 1ps

module alu(
input [31:0]a,b,
input [2:0] alucontrol,
output reg [31:0] result,
output zero
    );
    wire [31:0]condinvb,sum;
    wire v;//overflow
    wire isAddSub; //true when add/ subtract operation
    assign condinvb=alucontrol[0]?~b:b;
    assign isAddSub=~alucontrol[2]&~alucontrol[1]|~alucontrol[1]&alucontrol[0];
    assign sum=a+condinvb+alucontrol[0];
    always@(*)begin 
        case(alucontrol)
        3'b000:result =sum;//add
        3'b001:result=sum;//sub
        3'b010:result=a&b;//and
        3'b011:result=a|b;//or
        3'b100:result=a^b;//xor
        3'b101:result=sum[31]^v;//slt
        default: result=32'bx;
        endcase
    
    end
    assign zero=(result==32'b0);
    assign v=~(alucontrol[0]^a[31]^b[31])&(a[31]^sum[31])& isAddSub;
    
    
endmodule
