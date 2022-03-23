`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 15:48:05
// Design Name: 
// Module Name: fpSpecialCases
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


module fpSpecialCases(A,B,aIsPZero, aIsNZero, bIsPZero, bIsNZero, setResultNaN, setResultPInf, setResultNInf);

`include "parameters.v"
  
  input [WIDTH-1:0] A,B;
  output aIsPZero, bIsPZero;
  output aIsNZero, bIsNZero;
  output setResultNaN, setResultPInf, setResultNInf;
  
  //Zero Values
  assign aIsPZero = (A == 0);
  assign bIsPZero = (B == 0);
  assign aIsNZero = (A == {1'b1,{(WIDTH-1){1'b0}}});
  assign bIsNZero = (B == {1'b1,{(WIDTH-1){1'b0}}});
    
  //NaN Values  
  wire aNaN, bNaN, cNaN;
  assign aNaN = (A[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (|A[SIG_WIDTH-1:0]);
  assign bNaN = (B[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (|B[SIG_WIDTH-1:0]);
  
  assign setResultNaN = aNaN | bNaN;

  //Inf values
  //Inf Values
  wire aIsPInf, bIsPInf, cIsPInf;
  wire aIsNInf, bIsNInf, cIsNInf;
  assign aIsPInf = (A[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|A[SIG_WIDTH-1:0]) & ~A[WIDTH-1];
  assign bIsPInf = (B[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|B[SIG_WIDTH-1:0]) & ~B[WIDTH-1];
  
  assign aIsNInf = (A[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|A[SIG_WIDTH-1:0]) & A[WIDTH-1];
  assign bIsNInf = (B[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|B[SIG_WIDTH-1:0]) & B[WIDTH-1];
  
  assign setResultPInf = aIsPInf | bIsPInf;
  assign setResultNInf = aIsNInf | bIsNInf;
  
  
  endmodule
