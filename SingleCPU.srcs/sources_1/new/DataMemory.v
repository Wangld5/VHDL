`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:39:14
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input CLK,              
    input mRD,              
    input mWR,              
    input [31:0] DAddr,     
    input [31:0] DataIn,    
    output [31:0] DataOut          
    );
     reg [7:0] memory[0:127];
    

    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            memory[i] = 0;
        end
    end
    
    //read
    assign DataOut[7:0] = (mRD) ? memory[DAddr + 3] : 8'bz; 
    assign DataOut[15:8] = (mRD) ? memory[DAddr + 2] : 8'bz;
    assign DataOut[23:16] = (mRD) ? memory[DAddr + 1] : 8'bz;
    assign DataOut[31:24] = (mRD) ? memory[DAddr] : 8'bz;
    
    // write?
    always @(negedge CLK) begin
        if (mWR) begin
            memory[DAddr] <= DataIn[31:24];
            memory[DAddr + 1] <= DataIn[23:16];
            memory[DAddr + 2] <= DataIn[15:8];
            memory[DAddr + 3] <= DataIn[7:0];
        end
    end
endmodule
