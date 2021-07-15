`timescale 1ns/1ps

module control(clk,reset,subtract,swap,select,loadx,loady,xgy,xg0,a,b,c2);
output reg subtract,swap,select,loadx,loady,a,b,c2;
input clk,xgy,xg0,reset;
reg c7;

initial begin
    subtract = 0;
    swap = 0;
    select = 1;
    loadx = 1;
    loady = 1;
    a = 0;
    b = 0;
    c2 = 1;
end

always @(posedge clk) begin
 c7 = b;
 b = (a & b) | ((~xg0) & (b)) | ((~xgy) & (~b));
 a = (~xg0) | xgy | c7;
 subtract = a & (~b);
 swap = (~a) & b;
 select = (~a) & (~b);
 loadx = (~a) | (~b);
 loady = (~a);
c2 = ~c2;
end
endmodule
