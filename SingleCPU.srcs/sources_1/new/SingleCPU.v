`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 19:19:49
// Design Name: 
// Module Name: SingleCPU
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


module SingleCPU(
    input CLK,
    input Reset,
    output [4:0] Rs,
    output [4:0] Rt,
    output [31:0] CurrentPC,
    output [31:0] NextPC,
    output [31:0] IDataOut,
    output [31:0] ReadData1,
    output [31:0] ReadData2,
    output [31:0] WriteData,
    output [4:0] WriteReg,
    output [31:0] Result,
    output [31:0] Immediate
    );
    
    wire [1:0] PCSrc;
    wire [2:0] ALUOp;
    wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, mRD, mWR, RegDst, ExtSel;
    wire Zero, Sign;
    wire [31:0] PC, IAddress, ImmediateExtend, DataOut, IDataIn, IDataOut, PC4, WriteData, ALUResult, ReadData1, ReadData2;
    wire [31:0] ExtSa, A, B;
    wire [25:0] address;
    
    assign IDataIn = 0;
    assign ExtSa = {{17{0}}, IDataOut[10:6]};
    assign CurrentPC = IAddress;
    assign NextPC = PC;
    assign Rs = IDataOut[25:21];
    assign Rt = IDataOut[20:16];
    assign Immediate = IDataOut[15:0];
    assign Result = ALUResult;
   
    
    instructionMemory IM(.InsMemRW(InsMemRW), .IAddress(IAddress), .IDataIn(IDataIn), .IDataOut(IDataOut));
    controlUnit cu(.OpCode(IDataOut[31:26]), .Zero(Zero), .Sign(Sign), .PCWre(PCWre), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), 
        .DBDataSrc(DBDataSrc), .RegWre(RegWre), .InsMemRW(InsMemRW), .mRD(mRD), .mWR(mWR), .RegDst(RegDst), .ExtSel(ExtSel),
        .PCSrc(PCSrc), .ALUOp(ALUOp));
    RegFile regfile(.CLK(CLK), .WE(RegWre), .Reset(Reset), .ReadReg1(IDataOut[25:21]), .ReadReg2(IDataOut[20:16]),
        .WriteReg(WriteReg), .WriteData(WriteData), .ReadData1(ReadData1), .ReadData2(ReadData2));
    
    DataMemory DM(.CLK(CLK), .mRD(mRD), .mWR(mWR), .DAddr(ALUResult), .DataIn(ReadData2), .DataOut(DataOut));
    ALU alu(.A(A), .B(B), .ALUop(ALUOp), .Zero(Zero), .ALUResult(ALUResult));
    
    PC pc(.CLK(CLK), .Reset(Reset), .PCWre(PCWre), .NextPC(NextPC), .IAddress(IAddress));
    PC4 pc4(.PC(IAddress), .IAddress(IDataOut[25:0]), .PC4(PC4));
    NextPC next(.Reset(Reset), .PCSrc(PCSrc), .PC(IAddress), .Immediate(ImmediateExtend), .PC4(PC4), .NextPC(PC));
    
    selector32 selB(.Select(ALUSrcB), .A(ReadData2), .B(ImmediateExtend), .Out(B));
    selector32 selA(.Select(ALUSrcA), .A(ReadData1), .B(ExtSa), .Out(A));
    selector32 seldata(.Select(DBDataSrc), .A(ALUResult), .B(DataOut), .Out(WriteData));
    selector5 selreg(.Select(RegDst), .A(IDataOut[20:16]), .B(IDataOut[15:11]), .Out(WriteReg));
    
    signZeroExtend extend(.ExtSel(ExtSel), .Sign(Sign), .Immediate(IDataOut[15:0]), .ImmediateExtend(ImmediateExtend));
    
endmodule
