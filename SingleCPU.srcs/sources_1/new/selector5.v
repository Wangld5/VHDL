`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:43:19
// Design Name: 
// Module Name: selector5
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

//Select, A, B, Out
module selector5(
    input Select,
    input [4:0] A,
    input [4:0] B,
    output [4:0] Out
    );

    assign Out = Select ? B : A;
endmodule
