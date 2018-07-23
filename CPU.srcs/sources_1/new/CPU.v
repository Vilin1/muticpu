`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/16 14:41:04
// Design Name: 
// Module Name: topModuleCpu
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


module CPUTOP(
    input clk,
    input reset,
    output RW,
    output[31:0] IAddr,
    output[31:0] DataOut,
    output[5:0] opcode,
    output[4:0] rs,
    output[4:0] rt,
    output[4:0] rd,
    output[4:0] sa,
    output[31:0] ext_sa,
    output[15:0] immidate,
    output[31:0] JAddr,
    output zero,
    output DBDataSrc,
    output mWR,
    output mRD,
    output ALUSrcB,
    output ALUSrcA,
    output[1:0] PCSrc,
    output[2:0] ALUOp,
    output RegWre,
    output[1:0] RegDst,
    output InsMemRW,
    output PCWre,
    output ExtSel,
    output[4:0] WriteReg,
    output[31:0] ReadData1,
    output[31:0] ReadData2,
    output[31:0] ALUA,
    output[31:0] ALUB,
    output[31:0] ExtResult,
    output[31:0] result,
    output[31:0] IDataOut,
    output[31:0] DB,
    output[31:0] nextPC,
    output IRWre,
    output[31:0] trueReadData1,
    output[31:0] trueReadData2,
    output[31:0] trueresult,
    output[31:0] trueDB,
    output[31:0] WriteData,
    output sign,
    output WrRegDSrc,
    output[31:0] trueIDataOut
    );
    //module instructionMemory(input RW,input[31:0] IAddr,output reg[31:0] DateOut);
    instructionMemory ins(InsMemRW,IAddr,IDataOut);
    //module ALU32(input[2:0] ALUopcode,input[31:0] rega,input[31:0] regb,output reg[31:0] result,output zero);
    ALU32 alu(ALUOp,ALUA,ALUB,result, zero, sign);
    //module controlUnit(input CLK,input RST,input sign,input[5:0] opcode,input zero,output DBDataSrc,output mWR,output mRD,output ALUSrcB,output ALUSrcA,output[1:0] PCSrc,output[2:0] ALUOp,output RegWre,output[1:0] RegDst,output InsMemRW,output PCWre,output ExtSel,output IRWre,output WrRegDSrc);
    controlUnit control(clk,reset,sign,opcode,zero,IDataOut,DBDataSrc,mWR,mRD,ALUSrcB,ALUSrcA,PCSrc,ALUOp,RegWre,RegDst,InsMemRW,PCWre,ExtSel, IRWre, WrRegDSrc);
    
    //module RAM(input clk,input [31:0] address,input [31:0] writeData, input nRD,input nWR, output [31:0] Dataout);
    RAM ram(clk,trueresult,ReadData2, mRD,mWR,DataOut);
    //module PC(input clk,input reset,input PCWre,input[31:0] nextPC,output[31:0] currentPC);
    PC pc(clk,reset,PCWre,nextPC,IAddr);
    //module RegFile(input CLK,input RST,input RegWre,input [4:0] ReadReg1,input [4:0] ReadReg2,input [4:0] WriteReg,input [31:0] WriteData,output [31:0] ReadData1,output [31:0] ReadData2);
    RegFile regf(clk,reset,RegWre,rs,rt,WriteReg,WriteData,ReadData1,ReadData2);
    //module aignZeroExtend(input[15:0] extendee,input ExtSel,output reg[31:0] result);
    aignZeroExtend ext(immidate,ExtSel,ExtResult);
    
    //module selecterFor5bits(input src,input[4:0] input1,input[4:0] input2,output reg[4:0] outputResult);
    selecterFor32bits selecter1(WrRegDSrc,(IAddr+4),trueDB,WriteData);
    selecterFor32bits selecter2(ALUSrcA,trueReadData1, ext_sa, ALUA);
    selecterFor32bits selecter3(ALUSrcB,trueReadData2,ExtResult,ALUB);
    selecterFor32bits selecter4(DBDataSrc,result,DataOut,DB);
    
    //module decodeInstruction(input[31:0] DataOut,input[31:0] PC4,output[5:0] opcode,output[4:0] rs,output[4:0] rt,output[4:0] rd,
    //    output[4:0] sa,output[31:0] ext_sa,output[15:0] immidate,output[31:0] jAddr);
    decodeInstruction decode(trueIDataOut, (IAddr+4), opcode, rs, rt, rd, sa, ext_sa, immidate, JAddr);
    
    //module PCSelecter(input[1:0] PCSrc,input[31:0] normalPC,input[31:0] immidatePC,input[31:0] ReadData1,input[31:0] jumpPC,output reg[31:0] nextPC);
    PCSelecter pcselecter(PCSrc,(IAddr+4),(IAddr+4+(ExtResult << 2)),ReadData1,JAddr,nextPC);
   //module IR(input [31:0] inData,input clk, input IRWre,output reg[31:0] outData );
    IR ir(IDataOut, clk,IRWre, trueIDataOut);
    //module ADR(input CLK,input [31:0] readdata1,output reg[31:0] Data1);
    ADR adr(clk,ReadData1,trueReadData1);
    //module BDR(input CLK,input [31:0] readdata2,output reg [31:0] Data2);
    BDR bdr(clk,ReadData2,trueReadData2);
    //module ALUoutDR(input CLK,input [31:0] result,output reg [31:0] res);
    ALUoutDR aluoutdr(clk,result,trueresult);
    //mmodule DBDR(input CLK,input [31:0] DB,output reg [31:0] trueDB);
    DBDR dbdr(clk,DB,trueDB);
    //module RegSelecter(input[1:0] RegDst,input[4:0] Reg31,input[4:0] rt,input[4:0] rd,output reg[4:0] WriteReg);
    RegSelecter regselecter(RegDst,5'b11111,rt,rd,WriteReg);
endmodule
