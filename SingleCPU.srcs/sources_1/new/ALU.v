`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:42:42
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,     
    input [31:0] B,     
    input [2:0] ALUop,  
    output Zero,             
    output reg [31:0] ALUResult     
    );
    
    always @(ALUop or A or B) begin
        case (ALUop)
            3'b000 : ALUResult = A + B;
            3'b001 : ALUResult = A - B;
            3'b010 : ALUResult = B << A;
            3'b011 : ALUResult = A | B;
            3'b100 : ALUResult = A & B;
            3'b101 : ALUResult = A < B ? 1 : 0;
            3'b110 : ALUResult = ((A < B) && (A[31] == B[31])) || ((A[31]==1 && B[31]==0)) ? 1 : 0;
            3'b111 : ALUResult = A ^ B;
            default : ALUResult = 0;
        endcase
    end
    
    assign Zero = (ALUResult == 0) ? 1 : 0;
endmodule
