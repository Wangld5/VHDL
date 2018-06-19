`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:44:49
// Design Name: 
// Module Name: signZeroExtend
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


module signZeroExtend(
    input ExtSel,               
    input Sign,                 
    input [15:0] Immediate,     
    output [31:0] ImmediateExtend        
    );
    assign ImmediateExtend[15:0] = Immediate[15:0];
    assign ImmediateExtend[31:16] = (ExtSel && Immediate[15]) ? 16'hFFFF : 16'h0000;
endmodule
