`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 10:17:17
// Design Name: 
// Module Name: parameters
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
  //Parameters
  parameter WIDTH=32;
  parameter EXP_WIDTH=8;
  parameter SIG_WIDTH=23;
  parameter BIAS=127;
  
  parameter CLA_GRP_WIDTH=4;
  parameter N_CLA_GROUPS=2;
  
  parameter code_NaN=32'b0_11111111_1000_0000_0000_0000_0000_000;
  parameter code_PINF=32'b0_11111111_0000_0000_0000_0000_0000_000;
  parameter code_NINF=32'b1_11111111_0000_0000_0000_0000_0000_000;