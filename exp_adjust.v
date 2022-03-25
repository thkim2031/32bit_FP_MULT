`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/23 15:58:15
// Design Name: 
// Module Name: exp_adjust
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


module exp_adjust(exp_tem, exp_increment, exp_value);
`include "parameters.v"

input [EXP_WIDTH-1:0] exp_tem;
input exp_increment;
output [EXP_WIDTH-1:0] exp_value;

assign exp_value = exp_tem + exp_increment;

endmodule
