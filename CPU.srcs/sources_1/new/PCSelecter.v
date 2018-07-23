`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 15:06:23
// Design Name: 
// Module Name: PCSelecter
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


module PCSelecter(
    input[1:0] PCSrc,
    input[31:0] normalPC,
    input[31:0] immidatePC,
    input[31:0] ReadData1,
    input[31:0] jumpPC,
    output reg[31:0] nextPC
    );
    always@(PCSrc or normalPC or immidatePC or jumpPC or ReadData1)
    begin
        case(PCSrc)
            2'b00:nextPC <= normalPC;
            2'b01:nextPC <= immidatePC;
            2'b10:nextPC <= ReadData1;
            2'b11:nextPC <= jumpPC;
            default:nextPC <= 0;
        endcase
    end
endmodule
