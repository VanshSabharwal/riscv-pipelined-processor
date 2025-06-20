`timescale 1ns / 1ps

module imem(
input[31:0] pcF,
output [31:0] instrF
    );
    
    reg [31:0] RAM [31:0];
    initial $readmemh("rvp.hex",RAM);
    assign instrF=RAM[pcF[31:2]];
   
    
endmodule

