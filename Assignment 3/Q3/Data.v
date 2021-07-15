`timescale 1ns/1ps

module data(X,Y,Z,clk,reset,subtract,swap,select,loadx,loady,xgy,xg0,c2,a,b,XR,YR,ZR,temp);
input clk,reset,c2,a,b,subtract,swap,select,loadx,loady;
input [4:0] X,Y;
output reg xgy,xg0;
output reg [4:0] XR,YR,ZR,Z,temp;

always @(c2) begin
if(a == 1 && b == 1) begin
    Z =ZR;
    #20;
    $finish;
end
if (select == 1) begin
    if(loadx == 1) XR = X;
    if(loady == 1) YR = Y;
end
if (swap == 1) begin
    temp = YR;
    YR = XR;
    XR = temp;
end
if (subtract == 1) XR = XR - YR;
if (XR > 0) begin
    xg0 = 1;
end else begin
    xg0 = 0;
end
if (XR >= YR) begin
    xgy = 1;
end else begin
    xgy = 0;
end
ZR = YR;
end
endmodule