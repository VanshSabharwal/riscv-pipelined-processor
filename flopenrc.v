`timescale 1ns / 1ps

module flopenrc #(parameter WIDTH=32)(
input clk,reset,clear,enable,
input [WIDTH-1:0]d,
output reg [WIDTH-1:0] q
    );
    always@(posedge clk,posedge reset) begin 
        if(reset) q<=0;
        else if(enable) begin
             if(clear) q<=0;
             else q<=d;
        end
        
    
    end
    
endmodule
