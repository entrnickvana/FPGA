`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:43 09/16/2017 
// Design Name: 
// Module Name:    TopVGA 
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
module TopVGA(
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

	wire enableWrite = 1'b0;
	wire[13:0] fetch_addr_wire;
	wire[15:0] fetched_data_wire;
	wire[15:0] unused_write_wire = 16'd0;
	wire[9:0]	next_col_out_wire;
	wire[9:0]	next_row_out_wire;	
//output reg[9:0] col,	output reg[9:0] row,

	// Instantiate pxl gen input clk,
//module signal_gen(	input clk,	input [7:0] color,	output reg[9:0] col,	output reg[9:0] row,	output reg[1:0] vgaBlue,	output reg[2:0] vgaGreen,	output reg[2:0] vgaRed,	output reg h_sync,	output reg v_sync,	output request    );

	signal_gen sig1(	clk,							// 	clk				
					 	colors_pxl_signal,				// 	color
					 	col_signal_pxl,					// 	col
					 	row_signal_pxl,					// 	row
					 	vgaBlue_Pad,					// 	vgaBlue
					 	vgaGreen_Pad,					// 	vgaGreen
					 	vgaRed_Pad,						// 	vgaRed
					 	h_sync_Pad,						// 	h_sync
					 	v_sync_Pad,						// 	v_sync
					 	req_signal_pxl,					// 	request
					 	next_col_out_wire,				// 	next_col_out
					 	next_row_out_wire  				//  newxt_row_out
				    );
	

	pixel_gen pxl1(		clk,							//	clk
					 	snowButton, 					//	snowButton
					 	req_signal_pxl,					//	req
					 	col_signal_pxl,					//	col
					 	row_signal_pxl,					//	row
					 	switches,						//	switches
					 	fetched_data_wire,				//	fetched_data
					 	colors_pxl_signal,				//  next_color
					 	fetch_addr_wire, 				// 	fetch_addr
					 	next_col_out_wire,				// 	next_col_in
					 	next_row_out_wire  				//  newxt_row_in
				   );
	// Instantiate signal gen


	/*/////////////////////////// MEMORY MODULE /////////////////////////////

	//input clka;
	//input [0 : 0] wea;
	//input [13 : 0] addra;
	//input [15 : 0] dina;
	//output [15 : 0] douta;
	*////////////////////////////////////////////////////////////


		mem m1(			clk,							//	module mem( clka,
						enableWrite,					//  wea,
						fetch_addr_wire,				//  addra,
						unused_write_wire,				//  dina,
						fetched_data_wire				//  douta);
			  );
		

endmodule

