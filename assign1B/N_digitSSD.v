`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:02:28 08/30/2017 
// Design Name: 
// Module Name:    N_digitSSD 
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
module N_digitSSD(
	input [3:0] selectHex,
    );


	/*	Multiplexed SSD outputs selected by SSD_REG_OUT
		
	*/
	always @(*) 
	begin
		case(selectHex)
		4'd0:SSD = num0;
		4'd1:SSD = num1;
		4'd2:SSD = num2;
		4'd3:SSD = num3;
		4'd4:SSD = num4;
		4'd5:SSD = num5;
		4'd6:SSD = num6;
		4'd7:SSD = num7;
		4'd8:SSD = num8;
		4'd9:SSD = num9;
		4'd10:SSD = numA;
		4'd11:SSD = numB;
		4'd12:SSD = numC;
		4'd13:SSD = numD;
		4'd14:SSD = numE;
		4'd15:SSD = numF;
		endcase
	end



endmodule
