`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:38:26
// Design Name: 
// Module Name: instructionMemory
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

//InsMemRW, IAddress, IDataIn, IDataOut
module instructionMemory(
    input InsMemRW,                 
    input [31:0] IAddress,          
    input [31:0] IDataIn,           
    output reg [31:0] IDataOut      
    );


    reg [7:0] Memory[0:127];

    initial begin
        $readmemb("D:ื๗าต/SingleCPU_Basy3/data/test.txt", Memory);
    end
    

    always @(IAddress or InsMemRW) begin
        if (InsMemRW) begin
            IDataOut[31:24] = Memory[IAddress];
            IDataOut[23:16] = Memory[IAddress + 1];
            IDataOut[15:8] = Memory[IAddress + 2];
            IDataOut[7:0] = Memory[IAddress + 3];
        end
    end
endmodule
