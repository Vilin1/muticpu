`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/16 14:36:38
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


module PC(
    input clk,
    input reset,
    input PCWre,
    input[31:0] nextPC,
    output reg[31:0] currentPC
    );
    always@(posedge clk or negedge reset)
    begin
        if(reset == 0)
        begin
            currentPC <= 0;;
        end
        else if(PCWre)
        begin
            currentPC <= nextPC;
        end
    end
endmodule
