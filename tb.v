`timescale 1ns / 1ps

module tb();


reg clk,reset;
wire [31:0]writedata,dataadr;
wire memwrite;
top dut(clk,reset,writedata,dataadr,memwrite);

initial begin reset<=1; #2 reset<=0; end
always begin clk<=1;#5 clk<=0; #5; end

endmodule
