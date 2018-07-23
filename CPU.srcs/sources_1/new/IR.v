`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/10 22:28:19
// Design Name: 
// Module Name: IR
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


module IR(
    input [31:0] inData,
    input clk, 
    input IRWre,
    output reg[31:0] outData
);

    reg[31:0] storage;
    always @(negedge clk) begin 
        if(IRWre == 1) outData = storage;    
    end

    always @(inData) begin
        storage = inData;
    end
endmodule
