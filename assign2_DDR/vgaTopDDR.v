`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:56 09/16/2017 
// Design Name: 
// Module Name:    vgaTopDDR 
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
module vgaTopDDR(
	input clk,
	input snowButton,
	input [7:0] switches,
	output [1:0] vgaBlue_Pad,
	output [2:0] vgaGreen_Pad,
	output [2:0] vgaRed_Pad,
	output h_sync_Pad,
	output v_sync_Pad
    );

	wire req_signal_pxl;
	wire [9:0]col_signal_pxl;
	wire [9:0]row_signal_pxl;
	wire [7:0]colors_pxl_signal;

//output reg[9:0] col,	output reg[9:0] row,

	// Instantiate pxl gen input clk,
//module signal_gen(	input clk,	input [7:0] color,	output reg[9:0] col,	output reg[9:0] row,	output reg[1:0] vgaBlue,	output reg[2:0] vgaGreen,	output reg[2:0] vgaRed,	output reg h_sync,	output reg v_sync,	output request    );

	signal_gen sig1(clk, colors_pxl_signal, col_signal_pxl, row_signal_pxl, vgaBlue_Pad, vgaGreen_Pad, vgaRed_Pad, h_sync_Pad, v_sync_Pad, req_signal_pxl);
	
// module pixel_gen(	input clk,	input req,	input[9:0] col, input[9:0] row,	input[7:0] switches,	output reg[7:0] next_color);
	pixel_gen pxl1(clk, snowButton, req_signal_pxl, col_signal_pxl, row_signal_pxl, switches, colors_pxl_signal);
	// Instantiate signal gen






endmodule
