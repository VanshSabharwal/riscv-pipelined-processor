`timescale 1ns / 1ps

module datapath(
input clk,reset,
//IF
input stallF,
output [31:0]pcF,
input [31:0] instrF,
//ID
output [6:0] opD,
output [2:0] funct3D,
output funct7b5D,
input stallD,flushD,
input [2:0] immsrcD,
//EX
input flushE,
input [1:0]forwardaE,forwardbE,
input pcsrcE,//going to IF stage
input [2:0] alucontrolE,
input alusrcaE,alusrcbE,
output zeroE,
//MEM
input memwriteM,
output [31:0] writedataM,aluresultM,
input [31:0] readdataM,
//WB
input regwriteW,
input [1:0] resultsrcW,
//HAZARD
output [4:0] rs1D,rs2D,rs1E,rs2E,rdE,rdM,rdW
 );


//F signals
wire [31:0] pcnextF,pcplus4F;
//D signals
wire [31:0]instrD;
wire [31:0] pcD,pcplus4D;
wire [31:0]rd1D,rd2D;
wire [31:0] immextD;
wire [4:0]rdD;

//EX
wire [31:0] rd1E,rd2E;
wire [31:0] pcE,immextE;
wire [31:0] srcaE,srcbE;
wire [31:0] srcaEforward;
wire [31:0] aluresultE;
wire [31:0] writedataE;
wire [31:0] pcplus4E;
wire [31:0] pctargetE;
//MEM signals
wire [31:0] pcplus4M;
//WB signals
wire [31:0] aluresultW;
wire [31:0] readdataW;
wire [31:0] pcplus4W;
wire [31:0] resultW;

//F pipeline
mux2 #(32) pcmux(pcplus4F,pctargetE,pcsrcE,pcnextF);
flopenr #(32) pcflop(clk,reset,~stallF,pcnextF,pcF);
adder pcadd(pcF,32'd4,pcplus4F);
//D pipeline
flopenrc #(96)Dreg(clk,reset,flushD,~stallD,{instrF,pcF,pcplus4F},{instrD,pcD,pcplus4D});
assign opD=instrD[6:0];
assign funct3D=instrD[14:12];
assign funct7b5D=instrD[30];
assign rs1D=instrD[19:15];
assign rs2D=instrD[24:20];
assign rdD=instrD[11:7];

regfile rf(clk,regwriteW,rs1D,rs2D,rdW,resultW,rd1D,rd2D);
extend e(instrD[31:7],immsrcD,immextD);

//EX pipeline
floprc #(175)Ereg(clk,reset,flushE,{rd1D,rd2D,pcD,rs1D,rs2D,rdD,immextD,pcplus4D},{rd1E,rd2E,pcE,rs1E,rs2E,rdE,immextE,pcplus4E});
mux3 #(32)faemux(rd1E,resultW,aluresultM,forwardaE,srcaEforward);
mux2 #(32)srcaemux(srcaEforward,32'b0,alusrcaE,srcaE);
mux3 #(32)fbemux(rd2E,resultW,aluresultM,forwardbE,writedataE);
mux2 #(32)srcbemux(writedataE,immextE,alusrcbE,srcbE);
alu alu(srcaE,srcbE,alucontrolE,aluresultE,zeroE);
adder branchadd(immextE,pcE,pctargetE);

//MEM pipeline
flopr #(101) Mreg(clk,reset,{aluresultE,writedataE,rdE,pcplus4E},{aluresultM,writedataM,rdM,pcplus4M});
//WB pipeline
flopr #(101) Wreg(clk,reset,{aluresultM,readdataM,rdM,pcplus4M},{aluresultW,readdataW,rdW,pcplus4W});
mux3 #(32) resultmux(aluresultW,readdataW,pcplus4W,resultsrcW,resultW);

endmodule