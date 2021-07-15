`timescale 1ns/1ps

module q2(A,B,C,D,Y);

input A,B,C,D;
output Y;
assign Y = A&B | A&C | A&D | B&C | B&D | C&D;
endmodule

