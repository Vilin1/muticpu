`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 15:16:58
// Design Name: 
// Module Name: selecterFor32bits
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


module selecterFor32bits(
    input src,
    input[31:0] input1,
    input[31:0] input2,
    output reg[31:0] outputResult
    );
    always@(src or input1 or input2)
    begin
        if(src == 0)
        begin
            outputResult <= input1;
        end
        else
        begin
            outputResult <= input2;
        end
    end
endmodule
