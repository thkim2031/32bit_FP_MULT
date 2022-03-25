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

`include "parameters.v"

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

always@(*)begin
sign_value = aSign^bSign;

exp_tem = aExp + bExp - BIAS;

mult_result = {1'b1,aSig} * {1'b1,bSig};

end

//rounding and normalization
wire exp_increment;
wire [SIG_WIDTH:0] rounded;
normal_round normal_rounding0(mult_result,exp_increment, rounded);

//exponent value adjust
wire [EXP_WIDTH-1:0] exp_value;
exp_adjust exp_adjust0(exp_tem, exp_increment, exp_value);


//final value///////////////////////////////////////////////////////////////////////////////////////////////////////
wire [WIDTH-1:0] result_pre;
//sign value
assign result_pre[WIDTH-1] = sign_value;

//exponent value
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
