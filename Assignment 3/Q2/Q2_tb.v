`timescale 1ns/1ps

module Q2_tb;
    
reg A;
reg B;
reg C;
reg D;
wire Y;

parameter stop_time = 2000;

initial begin
    $dumpfile("Q2.vcd");
    $dumpvars(0,Q2_tb);
end

q2 uut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .Y(Y)
);



always @(Y) begin
    
 $monitor ("time = %t , A = %b,B = %b,C = %b,D = %b,Y = %b", $time,A,B,C,D,Y);
end
initial begin
    A = 1'b1; B = 1'b1;C = 1'b1;D = 1'b1;
    #500 $finish;
end
always #5 A = ~A;
always #10 B = ~B;
always #15 C = ~C;
always #20 D = ~D;
endmodule