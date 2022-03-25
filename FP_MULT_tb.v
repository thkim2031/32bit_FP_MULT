`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 10:44:05
// Design Name: 
// Module Name: FP_MULT_tb
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

module FP_MULT_tb();
//`include "parameters.v"
  parameter WIDTH=32;
  parameter EXP_WIDTH=8;
  parameter SIG_WIDTH=23;
  parameter BIAS=127;
  
  parameter CLA_GRP_WIDTH=4;
  parameter N_CLA_GROUPS=2;
reg rst, clk;
reg [WIDTH-1:0] A,B;
wire [WIDTH-1:0] C;

wire [1:0] rnd;
wire [WIDTH-1:0] result;


top top0(A,B,rnd,clk,rst,result);


   integer fd;
 initial begin
#2 clk=1'b0;
#1  rst=1'b0;
#1  rst=1'b1;
#1  rst=1'b0;

    fd=$fopen("exp_hex_io.txt", "r");//fd=$fopen("testInputs.txt", "r");
    //op=0;
  end
 integer i,i1,i2,i3;
  
  always @ (*) begin
  $display("================================STARTING FROM HERE=======================");
    for(i=0;i<1000;i=i+1) begin
      $fscanf(fd, "%x %x %x %x %x %x", A, B, C, i1, i2, i3);
    #5  
    $display("================================ALIGNMENT HERE=======================");
    $display("A=%x, B=%x,,MY_Result=%x, answer = %x", A, B,result, C); 
    $display("======================================================================================");
    end

 $stop;
 
 $finish;
  end

 

always #5 clk = ~clk;


endmodule

