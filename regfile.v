`timescale 1ns / 1ps

module regfile(
input clk,we3,
input [4:0] a1,a2,a3,
input [31:0]wd3,
output [31:0] rd1,rd2
    );
    reg [31:0] rf[31:0];
    initial $readmemh("regfile_init.hex",rf);
    always@(negedge clk) begin 
        if(we3&&(a3!=5'b0)) rf[a3]<=wd3;
    
    end
    assign rd1=(a1!=0)? rf[a1]:0;
    assign rd2=(a2!=0)? rf[a2]:0;
    
endmodule
