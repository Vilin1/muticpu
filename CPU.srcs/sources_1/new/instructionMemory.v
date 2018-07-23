`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/16 14:38:52
// Design Name: 
// Module Name: instructionMemory
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


module instructionMemory(
    input RW,
    input[31:0] IAddr,
    output reg[31:0] IDataOut
    );
    reg [7:0] rom [0:99]; // �洢�����������reg����
        initial begin // �������ݵ��洢��rom��
            $readmemb ("D:/vivadodata/ins.txt", rom); // �����ļ�rom_data��.coe��.txt����δָ�����ʹ�0��ַ��ʼ��š�
            IDataOut[31:24] = rom[0];
            IDataOut[23:16] = rom[1];
            IDataOut[15:8] = rom[2];
            IDataOut[7:0] = rom[3];
        end
        always @( RW or IAddr ) begin
            if (RW==1) begin// Ϊ0�����洢����������ݴ洢ģʽ
                IDataOut[31:24] = rom[IAddr];
                IDataOut[23:16] = rom[IAddr+1];
                IDataOut[15:8] = rom[IAddr+2];
                IDataOut[7:0] = rom[IAddr+3];
            end
        end
endmodule
