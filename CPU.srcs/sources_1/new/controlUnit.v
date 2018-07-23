`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/16 14:35:37
// Design Name: 
// Module Name: controlUnit
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


module controlUnit(
    input CLK,
    input RST,
    input sign,
    input[5:0] opcode,
    input zero,
    input[31:0] IDataOut,
    
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
    output IRWre,
    output WrRegDSrc
    );
    
   /*
    //ALUSrcA
    if(opcode == 6'b000000 || opcode == 6'b000010 || opcode == 6'b000001 || opcode == 6'b010010 || opcode == 6'b010001 || opcode == 6'b010000 || opcode == 6'b110000 || opcode == 6'b110001 || opcode == 6'b011011 || opcode == 6'b100110 || opcode == 6'b100111)
    begin
        assign ALUSrcA = 0;
    end
    else if(opcode == 6'b011000)
    begin
        assign ALUSrcA = 1;
    end
    
    //ALUSrcB
    if(opcode == 6'b000000 || opcode == 6'b000010 || opcode == 6'b010010 || opcode == 6'b010001 || opcode == 6'b011000 || opcode == 6'b110000 || opcode == 6'b1100011)
    begin
        assign ALUSrcB = 0;
    end
    else if(opcode == 6'b000001 || opcode == 6'b010000 || opcode == 6'b011011 || opcode == 6'b100110 || opcode == 6'b100111)
    begin
        assign ALUSrcB = 1;
    end
    
    //DBDataSrc
    if(opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010 || opcode == 6'b010000 || opcode == 6'b010010 || opcode == 6'b010001 || opcode == 6'b011011 || opcode == 6'b011000)
    begin
        assign DBDataSrc = 0;
    end
    else if(opcode == 6'b100111)
    begin
        assign DBDataSrc = 1;
    end
    
    //RegWre
    if(opcode == 6'b100110 || opcode == 6'b110000 || opcode == 6'b110001 || opcode == 6'b111000 || opcode == 6'b111111)
    begin
        assign RegWre = 0;
    end
    else if(opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010 || opcode == 6'b010000 || opcode == 6'b010010 || opcode == 6'b011011 || opcode == 6'b011000 || opcode == 6'b100111)
    begin
        assign RegWre = 1;
    end
    
    //RegDst
    if(opcode == 6'b000001 || opcode == 6'b010000 || opcode == 6'b011011 || opcode == 6'b100111)
    begin
        assign RegDst = 0;
    end
    else if(opcode == 6'b000000 || opcode == 6'b000010 || opcode == 6'b010001 || opcode == 6'b010010 || opcode == 6'b011000)
    begin
        assign RegDst = 1;
    end
    
    //ExtSel
    if(opcode == 6'b010000)
    begin
        assign ExtSel = 0;
    end
    else if(opcode == 6'b000001 || opcode == 6'b011011 || opcode == 6'b100110 || opcode == 6'b100111 || opcode == 6'b110000 || opcode == 6'b110001)
    begin
        assign ExtSel = 1;
    end
*/    
    reg [2:0] D,Q;
    always@(posedge CLK) begin
        if(RST == 0) begin
            D = 3'b000;
            Q = 3'b000;
            
        end
        else begin
            D = Q;
        end
    end
    
    always@(D or opcode) begin
        case(D)
            3'b000:begin
                Q = 3'b001;
            end
            3'b001:begin
                Q = (opcode == 6'b111000||opcode == 6'b111010||opcode == 6'b111001||opcode == 6'b111111)?3'b000:3'b010;
            end
            3'b010:begin
                Q = (opcode == 6'b110100||opcode == 6'b110110)?3'b000:(opcode == 6'b110000||opcode == 6'b110001)?3'b100:3'b011;
            end
            3'b011:begin
                Q = 3'b000;
            end
            3'b100:begin
                Q = (opcode == 6'b110000)?3'b000:3'b011;
            end
        endcase
    end
    
    
    assign PCWre = (opcode == 6'b111111||Q != 3'b000)?0:1;//get
    
    assign ALUSrcA = (opcode == 6'b011000&&D == 3'b010)?1:0;
    assign ALUSrcB = ((opcode == 6'b000010 || opcode == 6'b010010 || opcode == 6'b100111 || opcode == 6'b110000 || opcode == 6'b110001)&&D==3'b010)?1:0;
    
    assign DBDataSrc = (opcode == 6'b110001)?1:0;
    
    assign RegWre = (((D == 3'b011)&&(opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010 || opcode == 6'b010000 || opcode == 6'b010001 ||opcode == 6'b010010 ||opcode == 6'b100110 || opcode == 6'b100111 || opcode == 6'b011000 || opcode == 6'b110001)) || ((D==3'b001)&&(IDataOut[31:26] == 6'b111010)))?1:0;
    
    assign WrRegDSrc = (IDataOut[31:26] == 6'b111010) ? 0 : 1;
    assign InsMemRW = (D == 3'b000) ? 1 : 0;
    
    assign mWR = (opcode == 6'b110000 && D == 3'b100)?0:1;
    assign mRD = (opcode == 6'b110001 && D == 3'b100)?0:1;
    assign IRWre = (D == 3'b001) ? 1 : 0;
    assign ALUOp[2] = (opcode == 6'b010000 || opcode == 6'b010001 || opcode == 6'b010010 || opcode == 6'b011000)? 1 : 0;
    assign ALUOp[1] = (opcode == 6'b010001||opcode == 6'b100110||opcode == 6'b100111) ? 1 : 0;
    assign ALUOp[0] = (opcode == 6'b000001||opcode == 6'b010000||opcode == 6'b010010||opcode == 6'b100110||opcode ==6'b110100||opcode == 6'b110110) ? 1 : 0;
    assign ExtSel = (opcode == 6'b000010 || opcode == 6'b110001 || opcode == 6'b110000 || opcode == 6'b110100 || opcode == 6'b110110)?1:0;
    
    assign RegDst = (IDataOut[31:26] == 6'b111010)?2'b00:((opcode == 6'b000010||opcode == 6'b010010||opcode == 6'b100111||opcode == 6'b110001)?2'b01:((opcode == 6'b000000||opcode == 6'b000001||opcode == 6'b010000||opcode == 6'b010001||opcode == 6'b100110||opcode == 6'b011000)?2'b10:2'b11));
    
    assign PCSrc = ((opcode == 6'b110100 && zero == 1)||(opcode == 6'b110110 && zero == 0 && sign == 1))?2'b01:((opcode == 6'b000000 || opcode == 6'b000010 || opcode == 6'b000001 || opcode == 6'b010000 || opcode == 6'b010010 || opcode == 6'b010001 || opcode == 6'b100110 || opcode == 6'b100111 || opcode == 6'b011000 || opcode == 6'b110000 || opcode == 6'b110001 || (opcode == 6'b110100&&zero == 0) || (opcode == 6'b110110&&(zero == 1 || sign == 0)))?2'b00:((opcode == 6'b111001)?2'b10:2'b11));
    /*
    if(opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010 || opcode == 6'b010010 || opcode == 6'b010000 || opcode == 6'b010001 || opcode == 6'b011011 || opcode == 6'b011000 || opcode == 6'b100110 || opcode == 6'b100111 || (opcode == 6'b110000&&zero == 0) || (opcode == 6'b110001&&zero == 1))
    begin
        assign PCSrc = 2'b00;
    end
    else if((opcode == 6'b11000 && zero == 1)||(opcode == 6'b110001 && zero == 0))
    begin
        assign PCSrc = 2'b01;
    end
    else if(opcode == 6'b111000)
    begin
        assign PCSrc = 2'b10;
    end
   */ 
   /*
    always@(opcode)
    begin
        case(opcode)
            //add
            6'b000000:ALUOp = 3'b000;
            
            //sub
            6'b000001:ALUOp = 3'b001;
            
            //addi
            6'b000010:ALUOp = 3'b000;
            
            //or
            6'b010000:ALUOp = 3'b101;
            
            //and
            6'b010001:ALUOp = 3'b110;
            
            //ori
            6'b010010:ALUOp = 3'b101;
            
            //sll
            6'b011000:ALUOp = 3'b100;
            
            //slt
            6'b100110:ALUOp = 3'b011;
            
            //sltiu
            6'b100111:ALUOp = 3'b010;
            
            //sw
            6'b110000:ALUOp = 3'b000;
            
            //lw
            6'b110001:ALUOp = 3'b000;
            
            //beq
            6'b110100:ALUOp = 3'b001;
            
            //bltz
            6'b110110:ALUOp = 3'b001;
            
            //j
            6'b111000:
            begin 
            end
            
            //jr
            6'b111001:
            begin 
            end
            //jal
            6'b111010:
            begin 
            end
            //halt
            6'b111111:begin end
            default : begin end
        endcase
    end
    */
endmodule
