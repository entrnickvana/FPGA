`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:46:54 08/30/2017 
// Design Name: 
// Module Name:    seg_7 
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
module seg_7(
	input [3:0] selectHex,
	output [7:0] segVal
    );

	reg [7:0] segValReg;
	
	/*  For Future use with text

	*/
	wire[7:0] a; assign a = 8'b10001000;
	wire[7:0] b; assign b = 8'b10000011;
	wire[7:0] c; assign c = 8'b11000110;
	wire[7:0] d; assign d = 8'b10100001;
	wire[7:0] e; assign e = 8'b10000110;
	wire[7:0] f; assign f = 8'b10001110;

	/* For use in case statment for Seven Segment output

	*/
	wire[7:0] num0; assign num0 = 8'b11000000;
	wire[7:0] num1; assign num1 = 8'b11111001;
	wire[7:0] num2; assign num2 = 8'b10100100;
	wire[7:0] num3; assign num3 = 8'b10110000;
	wire[7:0] num4; assign num4 = 8'b10011001;
	wire[7:0] num5; assign num5 = 8'b10010010;
	wire[7:0] num6; assign num6 = 8'b10000010;
	wire[7:0] num7; assign num7 = 8'b11111000;
	wire[7:0] num8; assign num8 = 8'b10000000;
	wire[7:0] num9; assign num9 = 8'b10010000;
	wire[7:0] numA; assign numA = a;
	wire[7:0] numB; assign numB = b;
	wire[7:0] numC; assign numC = c;
	wire[7:0] numD; assign numD = d;
	wire[7:0] numE; assign numE = e;
	wire[7:0] numF; assign numF = f;

	/*	Multiplexed segValReg outputs selected by segValReg_REG_OUT
		
	*/
	always @(*) 
	begin
		case(selectHex)
		4'd0:segValReg = num0;
		4'd1:segValReg = num1;
		4'd2:segValReg = num2;
		4'd3:segValReg = num3;
		4'd4:segValReg = num4;
		4'd5:segValReg = num5;
		4'd6:segValReg = num6;
		4'd7:segValReg = num7;
		4'd8:segValReg = num8;
		4'd9:segValReg = num9;
		4'd10:segValReg = numA;
		4'd11:segValReg = numB;
		4'd12:segValReg = numC;
		4'd13:segValReg = numD;
		4'd14:segValReg = numE;
		4'd15:segValReg = numF;
		endcase
	end

	assign segVal = segValReg;


endmodule
