`timescale 1ns / 1ps

module dmem(
input clk,we,
input [31:0] aluresultM,writedataM,
output [31:0]readdataM
    );
    reg [31:0] RAM [31:0];
    assign readdataM=RAM[aluresultM[31:2]];
    always@(posedge clk) if(we) RAM[aluresultM[31:2]]<=writedataM;
    
endmodule
