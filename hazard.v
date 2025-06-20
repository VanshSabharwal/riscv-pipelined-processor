`timescale 1ns / 1ps

module hazard(
input [4:0]rs1D,rs2D,rs1E,rs2E,rdE,rdM,rdW,
input pcsrcE,resultsrcEb0,
input regwriteM,regwriteW,
output reg [1:0] forwardaE,forwardbE,
output stallF,stallD,flushD,flushE
    );
    
    wire lwstallD;
    
    always @(*) begin 
        forwardaE=2'b00;
        forwardbE=2'b00;
        if(rs1E!=5'b0)begin 
            if((rs1E==rdM)& regwriteM) forwardaE=2'b10;
            else if((rs1E==rdW)& regwriteW) forwardaE=2'b01;
        end
        if(rs2E!=5'b0)begin 
            if((rs2E==rdM)& regwriteM) forwardbE=2'b10;
            else if((rs2E==rdW)& regwriteW) forwardbE=2'b01;
        end
        
        
    end
    
    assign lwstallD=resultsrcEb0&((rs1D==rdE)|(rs2D==rdE));
    assign stallD=lwstallD;
    assign stallF=lwstallD;
    assign flushD=pcsrcE;
    assign flushE=pcsrcE|lwstallD;
    
endmodule
