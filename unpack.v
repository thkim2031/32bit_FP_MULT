`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 10:26:08
// Design Name: 
// Module Name: unpack
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

module unpack(A,B, aIsSubnormal, aSign, aExp, aSig, bIsSubnormal, bSign, bExp, bSig);

`include "parameters.v"
  
input [WIDTH-1:0] A,B;

output aIsSubnormal, bIsSubnormal;   
output aSign, bSign;
output [EXP_WIDTH-1:0] aExp, bExp;
output [SIG_WIDTH:0] aSig, bSig;



assign aIsSubnormal = (aExp==0) & (A[SIG_WIDTH-1:0]!=0);
assign bIsSubnormal = (bExp==0) & (B[SIG_WIDTH-1:0]!=0);
     
assign aSign = A[WIDTH-1];
assign bSign = B[WIDTH-1];

assign aExp = A[WIDTH-2:WIDTH-EXP_WIDTH-1];
assign bExp = B[WIDTH-2:WIDTH-EXP_WIDTH-1];

assign aSig = A[WIDTH-EXP_WIDTH-2:0];
assign bSig = B[WIDTH-EXP_WIDTH-2:0];

assign aSig= (aIsSubnormal)?{1'b0,A[SIG_WIDTH-1:0]}:{1'b1,A[SIG_WIDTH-1:0]};           
assign bSig= (bIsSubnormal)?{1'b0,B[SIG_WIDTH-1:0]}:{1'b1,B[SIG_WIDTH-1:0]}; 
     

endmodule
