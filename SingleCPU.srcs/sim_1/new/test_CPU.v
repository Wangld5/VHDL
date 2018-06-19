`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 20:26:13
// Design Name: 
// Module Name: test_CPU
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


module testCPU();
    reg CLK;
    reg Reset;
    wire [4:0] Rs;
    wire [4:0] Rt;
    wire [31:0] CurrentPC;
    wire [31:0] NextPC;
    wire [31:0] IDataOut;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] WriteData;
    wire [4:0] WriteReg;
    wire [31:0] Result;
    wire [31:0] Immediate;

    SingleCPU cpu(
        .CLK(CLK),
        .Reset(Reset),
        .Rs(Rs),
        .Rt(Rt),
        .CurrentPC(CurrentPC),
        .NextPC(NextPC),
        .IDataOut(IDataOut),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .WriteData(WriteData),
        .WriteReg(WriteReg),
        .Result(Result),
        .Immediate(Immediate)
    );

    initial begin
        CLK = 0;
        Reset = 0;
        #50;
            CLK=1;
        #50;
            Reset=1;
        forever #50 begin
            CLK=~CLK;
        end
    end
endmodule
