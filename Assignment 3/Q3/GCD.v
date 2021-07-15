`include "Data.v"
`include "Control.v"
`timescale 1ns/1ps

module gcd();
reg clk,reset;
reg [4:0] X,Y;
wire subtract,swap,select,loadx,loady,a,b,c;
wire [4:0] XR,YR,ZR,temp,Z;
initial begin
    $dumpfile("gcd.vcd");
    $dumpvars(0,gcd);
    clk = 0;
    X = 29; Y = 17;
end

always #5 clk = ~clk;

data u1(X,Y,Z,clk,reset,subtract,swap,select,loadx,loady,xgy,xg0,c2,a,b,XR,YR,ZR,temp);
control u2(clk,reset,subtract,swap,select,loadx,loady,xgy,xg0,a,b,c2);

endmodule