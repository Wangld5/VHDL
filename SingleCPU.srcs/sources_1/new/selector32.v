`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:43:39
// Design Name: 
// Module Name: selector32
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


module selector32(
    input Select,
    input [31:0] A,
    input [31:0] B,
    output [31:0] Out
    );

    assign Out = Select ? B : A;
endmodule
