`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 15:38:47
// Design Name: 
// Module Name: PC
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

//CLK, Reset, PCWre, NextPC, IAddress
module PC(
    input Reset,   
    input CLK,                               
    input PCWre,               
    input [31:0] NextPC,        
    output reg [31:0] IAddress      
    );
    
 
    initial begin
        IAddress = 0;
    end

    
    always @(posedge CLK or negedge Reset) begin
        if (!Reset) begin
            IAddress <= 32'hFFFFFFFC;   
        end
        else if (PCWre || !NextPC) begin
            IAddress <= NextPC;
        end
    end
endmodule   

module PC4(
    input [25:0] IAddress,
    input [31:0] PC,                 
    output reg [31:0] PC4       
    );
    wire [27:0] leftMove;
    assign leftMove = IAddress << 2;
    always @(PC or IAddress) begin
        PC4[31:28] = PC[31:28];
        PC4[27:2] = leftMove[27:2];
        PC4[1:0] = 0;
    end
endmodule   

module NextPC(
    input Reset,                
    input [1:0] PCSrc,          
    input [31:0] PC,            
    input [31:0] Immediate,     
    input [31:0] PC4,           
    output reg [31:0] NextPC        
    );

    always @(Reset or PCSrc or PC or Immediate or PC4) begin
        if (!Reset) begin
            NextPC = PC + 4;
        end
        else begin
            case (PCSrc)
              2'b00: NextPC = PC + 4;
              2'b01: NextPC = PC + 4 + (Immediate << 2);
              2'b10: NextPC = PC4;
              default: NextPC = PC + 4;
            endcase
        end
    end
endmodule