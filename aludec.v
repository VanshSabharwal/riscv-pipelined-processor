`timescale 1ns / 1ps


module aludec(
input opb5,
input [2:0]funct3,
input funct7b5,
input [1:0] aluop,
output reg [2:0] alucontrol
    );
    wire rtypesub;
    assign rtypesub=funct7b5&opb5;
    
    always@(*) begin 
        case(aluop)
        2'b00: alucontrol=3'b000;
        2'b01: alucontrol=3'b001;
         default:case(funct3) 
            3'b000: if(rtypesub) alucontrol=3'b001; else alucontrol=3'b000;
            3'b010: alucontrol=3'b101;
            3'b100: alucontrol=3'b100;
            3'b110: alucontrol=3'b011;
            3'b111:alucontrol=3'b010;
            default: alucontrol=3'bx;
    endcase
    endcase end
    
    
endmodule
