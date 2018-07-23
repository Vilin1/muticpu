`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/16 20:27:29
// Design Name: 
// Module Name: decodeInstruction
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


module decodeInstruction(
    input[31:0] IDataOut,
    input[31:0] PC4,
    output reg[5:0] opcode,
    output reg[4:0] rs,
    output reg[4:0] rt,
    output reg[4:0] rd,
    output reg[4:0] sa,
    output reg[31:0] ext_sa,
    output reg[15:0] immidate,
    output reg[31:0] jAddr
    );
    always@(IDataOut)
    begin
        opcode <= IDataOut[31:26];
        rs <= IDataOut[25:21];
        rt <= IDataOut[20:16];
        rd <= IDataOut[15:11];
        sa <= IDataOut[10:6];
        ext_sa <= {27'b000000000000000000000000000,IDataOut[10:6]};
        immidate <= IDataOut[15:0];
        jAddr[31:0] = PC4[31:0];
        jAddr[27:2] = IDataOut[25:0];
        jAddr[1:0] = 2'b00;
        //jAddr <= {PC4[31:28],IDataOut[25:0],2{0}};
    end
endmodule
