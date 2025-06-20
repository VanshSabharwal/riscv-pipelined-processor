`timescale 1ns / 1ps

module flopenr #(parameter WIDTH=32)(
input clk,reset,enable,
input [WIDTH-1:0]d,
output reg [WIDTH-1:0] q
    );
    always@(posedge clk,posedge reset) begin 
        if(reset) q<=0;
        else if(enable) begin
            q<=d;
        end
        
    
    end
    
endmodule
