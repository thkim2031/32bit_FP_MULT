`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 11:24:01
// Design Name: 
// Module Name: full_adder
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


module full_adder(in0, in1, cin, out, cout);

    input in0, in1, cin;
    output out, cout;
    
    assign out = in0^in1^cin;
    assign cout = ((in0^in1) & cin) | (in0 & in1);
    
    
endmodule