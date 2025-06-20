`timescale 1ns / 1ps

module riscv(
input clk,reset,
output [31:0] pcF,
input [31:0] instrF,
output memwriteM,
output [31:0] aluresultM,writedataM,
input [31:0] readdataM
    );
    wire[6:0] opD;
    wire [2:0] funct3D;
    wire funct7b5D;
    wire [2:0] immsrcD;
    wire zeroE,pcsrcE;
    wire [2:0]alucontrolE;
    wire alusrcaE,alusrcbE;
    wire resultsrcEb0;
    wire regwriteM;
    wire [1:0] resultsrcW;
    wire regwriteW;
    wire [1:0] forwardaE,forwardbE;
    wire stallF,stallD,flushD,flushE;   
    wire [4:0] rs1D,rs2D,rs1E,rs2E,rdE,rdM,rdW;
    
    controller c(clk,reset,opD,funct3D,funct7b5D,immsrcD,flushE,zeroE,pcsrcE,alucontrolE,alusrcaE,alusrcbE,resultsrcEb0,memwriteM,regwriteM,regwriteW,resultsrcW);
    datapath dp(clk,reset,stallF,pcF,instrF,opD,funct3D,funct7b5D,stallD,flushD,immsrcD,flushE,forwardaE,forwardbE,pcsrcE,alucontrolE,alusrcaE,alusrcbE,zeroE,memwriteM,writedataM,aluresultM,readdataM,regwriteW,resultsrcW,rs1D,rs2D,rs1E,rs2E,rdE,rdM,rdW);
    hazard hu(rs1D,rs2D,rs1E,rs2E,rdE,rdM,rdW,pcsrcE,resultsrcEb0,regwriteM,regwriteW,forwardaE,forwardbE,stallF,stallD,flushD,flushE);
endmodule
