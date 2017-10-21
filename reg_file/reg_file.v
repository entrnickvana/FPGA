`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:12:14 10/19/2017 
// Design Name: 
// Module Name:    reg_file 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module reg_file(input clk,
				input[4:0] reg_index1,
				input[4:0] reg_index2,				
				input[15:0] w_data,
				input w_enable,
				output reg[15:0] reg_data1,
				output reg[15:0] reg_data2				
    			);


reg[15:0] r0 = 16'd0;
reg[15:0] r1 = 16'd0;
reg[15:0] r2 = 16'd0;
reg[15:0] r3 = 16'd0;
reg[15:0] r4 = 16'd0;
reg[15:0] r5 = 16'd0;
reg[15:0] r6 = 16'd0;
reg[15:0] r7 = 16'd0;
reg[15:0] r8 = 16'd0;
reg[15:0] r9 = 16'd0;
reg[15:0] r10 = 16'd0;
reg[15:0] r11 = 16'd0;
reg[15:0] r12 = 16'd0;
reg[15:0] r13 = 16'd0;
reg[15:0] r14 = 16'd0;
reg[15:0] r15 = 16'd0;
reg[15:0] r16 = 16'd0;
reg[15:0] r17 = 16'd0;
reg[15:0] r18 = 16'd0;
reg[15:0] r19 = 16'd0;
reg[15:0] r20 = 16'd0;
reg[15:0] r21 = 16'd0;
reg[15:0] r22 = 16'd0;
reg[15:0] r23 = 16'd0;
reg[15:0] r24 = 16'd0;
reg[15:0] r25 = 16'd0;
reg[15:0] r26 = 16'd0;
reg[15:0] r27 = 16'd0;
reg[15:0] r28 = 16'd0;
reg[15:0] r29 = 16'd0;
reg[15:0] r30 = 16'd0;
reg[15:0] r31 = 16'd0;

/**
module reg_file(input clk,
				input[4:0] reg_index,
				input w_enable,
				output reg[15:0] reg_data
    			);
*/
	/// Multiplex reg_index
	always @(*)
	begin
		case(reg_index)
		begin
		5'd0: reg_data = r0;
		5'd1: reg_data = r1;
		5'd2: reg_data = r2;
		5'd3: reg_data = r3;
		5'd4: reg_data = r4;
		5'd5: reg_data = r5;
		5'd6: reg_data = r6;
		5'd7: reg_data = r7;
		5'd8: reg_data = r8;
		5'd9: reg_data = r9;
		5'd10: reg_data = r10;
		5'd11: reg_data = r11;
		5'd12: reg_data = r12;
		5'd13: reg_data = r13;
		5'd14: reg_data = r14;
		5'd15: reg_data = r15;
		5'd16: reg_data = r16;
		5'd17: reg_data = r17;
		5'd18: reg_data = r18;
		5'd19: reg_data = r19;
		5'd20: reg_data = r20;
		5'd21: reg_data = r21;
		5'd22: reg_data = r22;
		5'd23: reg_data = r23;
		5'd24: reg_data = r24;
		5'd25: reg_data = r25;
		5'd26: reg_data = r26;
		5'd27: reg_data = r27;
		5'd28: reg_data = r28;
		5'd29: reg_data = r29;
		5'd30: reg_data = r30;
		5'd31: reg_data = r31;
		endcase
	end