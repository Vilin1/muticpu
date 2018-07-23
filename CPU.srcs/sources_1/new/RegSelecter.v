`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 19:22:43
// Design Name: 
// Module Name: RegSelecter
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


module RegSelecter(
    input[1:0] RegDst,
    input[4:0] Reg31,
    input[4:0] rt,
    input[4:0] rd,
    output reg[4:0] WriteReg
    );
    always@(RegDst or Reg31 or rt or rd)
        begin
            case(RegDst)
                2'b00:WriteReg <= Reg31;
                2'b01:WriteReg <= rt;
                2'b10:WriteReg <= rd;
                default:WriteReg <= 0;
            endcase
        end
endmodule
