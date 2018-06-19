`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:44:23
// Design Name: 
// Module Name: controlUnit
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

//OpCode, Zero, Sign, PCWre, ALUSrcA, ALUSrcB,
    //           DBDataSrc, RegWre, InsMemRW, mRD, mWR, RegDst, ExtSel, PCSrc, ALUOp
module controlUnit(
    input [5:0] OpCode,     
    input Zero,             
    input Sign,             
    output PCWre,           
    output ALUSrcA,         
    output ALUSrcB,         
    output DBDataSrc,       
    output RegWre,          
    output InsMemRW,        
    output mRD,            
    output mWR,             
    output RegDst,          
    output ExtSel,          
    output [1:0] PCSrc,     
    output [2:0] ALUOp      
    );

    assign PCWre = (OpCode == 6'b111111) ? 0 : 1;
    assign ALUSrcA = (OpCode == 6'b011000) ? 1 : 0;
    assign ALUSrcB = (OpCode == 6'b000001 || OpCode == 6'b010000 || OpCode == 6'b011011 || OpCode == 6'b100110 || OpCode == 6'b100111) ? 1 : 0;
    assign DBDataSrc = (OpCode == 6'b100111) ? 1 : 0;
    assign RegWre = (OpCode == 6'b100110 || OpCode == 6'b110000 || OpCode == 6'b110001 || OpCode == 6'b111000 || OpCode == 6'b111111) ? 0 : 1;
    assign InsMemRW = 1;
    assign mRD = (OpCode == 6'b100111) ? 1 : 0;
    assign mWR = (OpCode == 6'b100110) ? 1 : 0;
    assign RegDst = (OpCode == 6'b000000 || OpCode == 6'b000010 || OpCode == 6'b010001 || OpCode == 6'b010010 || OpCode == 6'b011000) ? 1 : 0;
    assign ExtSel = (OpCode == 6'b010000) ? 0 : 1;
    assign PCSrc[1] = (OpCode == 6'b111000 || OpCode == 6'b111111) ? 1 : 0;
    assign PCSrc[0] = ((OpCode == 6'b110000 && Zero) || (OpCode == 6'b110001 && !Zero) || OpCode == 6'b111111) ? 1 : 0;
    assign ALUOp[2] = (OpCode == 6'b010001 || OpCode == 6'b011011) ? 1 : 0;
    assign ALUOp[1] = (OpCode == 6'b010000 || OpCode == 6'b010010 || OpCode == 6'b011000 || OpCode == 6'b011011 || OpCode == 6'b111000) ? 1 : 0;
    assign ALUOp[0] = (OpCode == 6'b000010 || OpCode == 6'b010010 || OpCode == 6'b010000 || OpCode == 6'b110000 || OpCode == 6'b110001) ? 1 : 0;
endmodule
