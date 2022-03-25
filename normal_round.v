`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/23 15:45:06
// Design Name: 
// Module Name: normal_round
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


module normal_round(mult_result,exp_increment, rounded);
`include "parameters.v"

input [2*SIG_WIDTH+1:0] mult_result;
output [SIG_WIDTH:0] rounded;
output exp_increment;
    
//normalize
wire shift_amount, exp_increment;
assign shift_amount = (mult_result[2*SIG_WIDTH+1])?1'b1:1'b0;
assign exp_increment = shift_amount;

wire [SIG_WIDTH*2+1:0] normalized;
assign normalized = mult_result >> shift_amount;


//rounding
wire L,G,T; 

assign L = normalized[SIG_WIDTH];
assign G = normalized[SIG_WIDTH-1];
assign T = |normalized[SIG_WIDTH-2:0];

assign rounded = (G&(T|L))?normalized[SIG_WIDTH*2:SIG_WIDTH]+1'b1:normalized[SIG_WIDTH*2:SIG_WIDTH]+1'b0;
    
    
    
endmodule
