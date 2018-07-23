`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/16 14:37:27
// Design Name: 
// Module Name: aignZeroExtend
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


module aignZeroExtend(
    input[15:0] extendee,
    input ExtSel,
    output reg[31:0] result
    );
    integer i;
    always @(ExtSel or extendee)begin
        for(i = 0; i < 16; i = i+1)
        begin
            result[i] <= extendee[i];
        end
        if(ExtSel == 0)
        begin
            for(i = 16; i < 32; i = i+1)
            begin
                result[i] <= 0;
            end
        end
        else
        begin
            for(i = 16; i < 32; i = i+1)
            begin
                result[i] <= extendee[15];
            end
        end
    end
endmodule
