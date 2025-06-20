`timescale 1ns / 1ps

module top(
input clk,reset,
output [31:0]writedataM,dataadrM,
output memwriteM    );
wire [31:0]pcF,instrF,readdataM;

riscv rv(clk,reset,pcF,instrF,memwriteM,dataadrM,writedataM,readdataM);
imem im(pcF,instrF);
dmem dm(clk,memwriteM,dataadrM,writedataM,readdataM);

endmodule
