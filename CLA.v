`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 11:21:46
// Design Name: 
// Module Name: CLA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module CLA(A,B,cin,sum,cout);
//`include "parameters.v"
  parameter WIDTH=32;
  parameter EXP_WIDTH=8;
  parameter SIG_WIDTH=23;
  parameter BIAS=127;
  
  parameter CLA_GRP_WIDTH=4;
  parameter N_CLA_GROUPS=2;
input [EXP_WIDTH-1:0] A,B;
input cin;
output [EXP_WIDTH-1:0] sum;
output cout;

reg [EXP_WIDTH:0] carry_in;
reg [EXP_WIDTH-1:0] G,P;
integer i;


always@(*)begin
for (i = 0; i < EXP_WIDTH; i=i+1)begin
    G[i] = A[i] & B[i];
    P[i] = A[i] ^ B[i];
end

carry_in[0] = 0;
for (i=1; i <= EXP_WIDTH; i=i+1)begin
    carry_in[i] = G[i-1] | (carry_in[i-1] & P[i-1]);
end

end

full_adder full_adder0(.in0(A[0]), .in1(B[0]), .cin(cin), .out(sum[0]), .cout());
full_adder full_adder1(.in0(A[1]), .in1(B[1]), .cin(carry_in[1]), .out(sum[1]), .cout());
full_adder full_adder2(.in0(A[2]), .in1(B[2]), .cin(carry_in[2]), .out(sum[2]), .cout());
full_adder full_adder3(.in0(A[3]), .in1(B[3]), .cin(carry_in[3]), .out(sum[3]), .cout());
full_adder full_adder4(.in0(A[4]), .in1(B[4]), .cin(carry_in[4]), .out(sum[4]), .cout());
full_adder full_adder5(.in0(A[5]), .in1(B[5]), .cin(carry_in[5]), .out(sum[5]), .cout());
full_adder full_adder6(.in0(A[6]), .in1(B[6]), .cin(carry_in[6]), .out(sum[6]), .cout());
full_adder full_adder7(.in0(A[7]), .in1(B[7]), .cin(carry_in[7]), .out(sum[7]), .cout());


assign {cout, sum} = {carry_in[EXP_WIDTH], sum}-BIAS;


endmodule
