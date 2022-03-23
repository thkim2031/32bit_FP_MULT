`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 10:19:06
// Design Name: 
// Module Name: main
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


module main(A,B,rnd,clk,rst,result);
  parameter WIDTH=32;
  parameter EXP_WIDTH=8;
  parameter SIG_WIDTH=23;
  parameter BIAS=127;
  
  parameter CLA_GRP_WIDTH=4;
  parameter N_CLA_GROUPS=2;
  
  parameter code_NaN=32'b0_11111111_1000_0000_0000_0000_0000_000;
  parameter code_PINF=32'b0_11111111_0000_0000_0000_0000_0000_000;
  parameter code_NINF=32'b1_11111111_0000_0000_0000_0000_0000_000;
//`include "parameters.v"

input [WIDTH-1:0] A,B;
input [1:0] rnd;
input clk, rst;
output reg [WIDTH-1:0] result;

//special case handeling 
wire aIsPZero, bIsPZero, setResultNaN, setResultPInf, aIsNZero, bIsNZero, setResultNInf;
     
fpSpecialCases fpSpecialCases0(A,B,aIsPZero, aIsNZero, bIsPZero, bIsNZero, setResultNaN, setResultPInf, setResultNInf);

wire setResultZero = (aIsNZero | aIsPZero | bIsNZero |  bIsPZero );   

//unpacking
wire aIsSubnormal, bIsSubnormal;
wire aSign, bSign;
wire [EXP_WIDTH-1:0] aExp, bExp;
wire [SIG_WIDTH-1:0] aSig, bSig;

unpack unpack0(A,B, aIsSubnormal, aSign, aExp, aSig, bIsSubnormal, bSign, bExp, bSig);


//multiplier, exponent temporary value , sign value
reg [2*SIG_WIDTH+1:0] mult_result;
reg [EXP_WIDTH-1:0] exp_tem;
reg sign_value;

always@(posedge clk)begin
sign_value = aSign^bSign;

exp_tem = aExp + bExp - BIAS;

mult_result = {1'b1,aSig} * {1'b1,bSig};

end



//normalize
wire shift_amount, exp_increment;
assign shift_amount = (mult_result[2*SIG_WIDTH+1])?1'b1:1'b0;
assign exp_increment = shift_amount;

wire [SIG_WIDTH*2+1:0] normalized;
assign normalized = mult_result >> shift_amount;


//rounding
wire L,G,T; 
wire [SIG_WIDTH:0] rounded ;

assign L = normalized[SIG_WIDTH];
assign G = normalized[SIG_WIDTH-1];
assign T = |normalized[SIG_WIDTH-2:0];

assign rounded = (G&(T|L))?normalized[SIG_WIDTH*2:SIG_WIDTH]+1'b1:normalized[SIG_WIDTH*2:SIG_WIDTH]+1'b0;




//final value///////////////////////////////////////////////////////////////////////////////////////////////////////
wire [WIDTH-1:0] result_pre;
//sign value
assign result_pre[WIDTH-1] = sign_value;

//exponent value
wire [EXP_WIDTH-1:0] exp_value;
assign exp_value = exp_tem + exp_increment;
assign result_pre[WIDTH-2:WIDTH-1-EXP_WIDTH] = exp_value;

//sig value
assign result_pre[WIDTH-2-EXP_WIDTH:0] = rounded;


//Select result (setResultNaN, setResultPInf, setResultNInf)
always @ (*) begin
    casex({setResultZero, setResultNaN, setResultPInf, setResultNInf})
      4'b1xxx: //Zero 
              result = 0;
      4'b1xx: //NaN
              result = code_NaN;
      4'b01x: //Positive Infinity
              result = code_PINF;
      4'b001: //Negative Infinity
              result = code_NINF;
      default: //computed result 
              result = result_pre;
    endcase
  end





endmodule
