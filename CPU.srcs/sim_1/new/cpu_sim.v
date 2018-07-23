`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 22:21:09
// Design Name: 
// Module Name: cpu_sim
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


module cpu_sim();
    reg clk;
    reg reset;
    wire RW;
    wire[31:0] IAddr;
    wire[31:0] DataOut;
    wire[5:0] opcode;
    wire[4:0] rs;
    wire[4:0] rt;    
    wire[4:0] rd;
    wire[4:0] sa;
    wire[31:0] ext_sa;
    wire[15:0] immidate;
    wire[31:0] JAddr;
    wire zero;
    wire DBDataSrc;
    wire mWR;
    wire mRD;
    wire ALUSrcB;
    wire ALUSrcA;
    wire[1:0] PCSrc;
    wire[2:0] ALUOp;
    wire RegWre;
    wire[1:0] RegDst;
    wire InsMemRW;
    wire PCWre;
    wire ExtSel;
    wire[4:0] WriteReg;
    wire[31:0] ReadData1;
    wire[31:0] ReadData2;
    wire[31:0] ALUA;
    wire[31:0] ALUB;
    wire[31:0] ExtResult;
    wire[31:0] result;
    wire[31:0] IDataOut;
    wire[31:0] DB;
    wire[31:0] nextPC;
    wire IRWre;
    wire[31:0] trueReadData1;
    wire[31:0] trueReadData2;
    wire[31:0] trueresult;
    wire[31:0] trueDB;
    wire[31:0] WriteData;
    wire sign;
    wire WrRegDSrc;
    wire[31:0] trueIDataOut;
    
    CPUTOP uut(
        .clk(clk),
        .reset(reset),
        .RW(RW),
        .IAddr(IAddr),
        .DataOut(DataOut),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .sa(sa),
        .ext_sa(ext_sa),
        .immidate(immidate),
        .JAddr(JAddr),
        .zero(zero),
        .DBDataSrc(DBDataSrc),
        .mWR(mWR),
        .mRD(mRD),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .PCSrc(PCSrc),
        .ALUOp(ALUOp),
        .RegWre(RegWre),
        .RegDst(RegDst),
        .InsMemRW(InsMemRW),
        .PCWre(PCWre),
        .ExtSel(ExtSel),
        .WriteReg(WriteReg),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .ALUA(ALUA),
        .ALUB(ALUB),
        .ExtResult(ExtResult),
        .result(result),
        .IDataOut(IDataOut),
        .DB(DB),
        .nextPC(nextPC),
        .IRWre(IRWre),
        .trueReadData1(trueReadData1),
        .trueReadData2(trueReadData2),
        .trueresult(trueresult),
        .trueDB(trueDB),
        .WriteData(WriteData),
        .sign(sign),
        .WrRegDSrc(WrRegDSrc),
        .trueIDataOut(trueIDataOut)
    );
    always #50 clk = ~clk;
        initial 
        begin
            clk = 0;
            reset = 0;
            #51 reset = 1;
        end
        
endmodule
