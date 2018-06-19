`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:44:05
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input CLK,                  
    input WE,                   
    input Reset,               
    input [4:0] ReadReg1,       
    input [4:0] ReadReg2,       
    input [4:0] WriteReg,      
    input [31:0] WriteData,     
    output [31:0] ReadData1,    
    output [31:0] ReadData2     
    );


    integer i;
    reg [31:0] Register[0:31];
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            Register[i] = 0;
        end
    end

 
    assign ReadData1 = (ReadReg1 == 0) ? 0 : Register[ReadReg1]; // ¶Á¼Ä´æÆ÷Êý¾Ý
    assign ReadData2 = (ReadReg2 == 0) ? 0 : Register[ReadReg2];

    always @(negedge CLK) begin
        if (!Reset) begin
            for (i = 1; i < 32; i = i + 1) begin
                Register[i] = 0;
            end
        end
        else if (WE==1 && WriteReg!=0) begin
            Register[WriteReg] <= WriteData;
        end
    end
endmodule
