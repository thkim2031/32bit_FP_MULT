`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/25 10:31:32
// Design Name: 
// Module Name: top
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


module top(A, B, rnd, clk, rst, result);
`include "parameters.v"

input [WIDTH-1:0] A,B;
input [1:0] rnd;
input clk, rst;
output [WIDTH-1:0] result;


main main0(A,B,rnd,clk,rst,result);

    
endmodule
