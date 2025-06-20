`timescale 1ns / 1ps
module controller(
input clk,reset,
//D
input [6:0] opD,
input [2:0] funct3D,
input funct7b5D,
output [2:0] immsrcD,
//ex
input flushE,zeroE,
output pcsrcE,
output [2:0] alucontrolE,
output alusrcaE,alusrcbE,
output resultsrcEb0,
//MEM
output memwriteM,regwriteM,
//WB
output regwriteW,
output [1:0]resultsrcW
    );
    
    wire regwriteD,regwriteE;
    wire [1:0] resultsrcD,resultsrcE,resultsrcM;
    wire memwriteD,memwriteE;
    wire jumpD,jumpE;
    wire branchD,branchE;
    wire [1:0] aluopD;
    wire [2:0] alucontrolD;
    wire alusrcaD;
    wire alusrcbD;
    
    //D
    maindec md(opD,resultsrcD,memwriteD,branchD,alusrcaD,alusrcbD,regwriteD,jumpD,immsrcD,aluopD);
    aludec ad(opD[5],funct3D,funct7b5D,aluopD,alucontrolD);
    //EX
    floprc #(11) controlregE(clk,reset,flushE,{regwriteD,resultsrcD,memwriteD,jumpD,branchD,alucontrolD,alusrcaD,alusrcbD},{regwriteE,resultsrcE,memwriteE,jumpE,branchE,alucontrolE,alusrcaE,alusrcbE});
    assign pcsrcE=(branchE & zeroE)|jumpE;
    assign resultsrcEb0=resultsrcE[0];
    //MEM
    flopr #(4) controlregM(clk,reset,{regwriteE,resultsrcE,memwriteE},{regwriteM,resultsrcM,memwriteM});
    //WB
    
    flopr #(3) controlregW(clk,reset,{regwriteM,resultsrcM},{regwriteW,resultsrcW});
    
    
endmodule
