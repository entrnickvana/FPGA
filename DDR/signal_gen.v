`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:34:12 09/16/2017 
// Design Name: 
// Module Name:    signal_gen 
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
module signal_gen(
	input clk,
	input [7:0] color,
	output reg[9:0] col,
	output reg[9:0] row,
	output reg[1:0] vgaBlue,
	output reg[2:0] vgaGreen,
	output reg[2:0] vgaRed,
	output reg h_sync,
	output reg v_sync,
	output request,
	output[9:0] next_col_out,
	output[9:0] next_row_out
    );


 	initial col = 10'd0;
	initial row = 10'd0;
	
reg[1:0] pxl_counter;		initial pxl_counter = 2'd0;

// 	101 1111 0101 1110 0001 0000 0000
initial h_sync = 1'b1;
initial v_sync = 1'b1;

assign request = pxl_ending && (h_in_frame && v_in_frame); //////////////////////// ?? Is this too late?

//////////////////////////////  NEXT CYCLE COMBINATORIAL LOGIC //////////////////////

						 // 704
wire nxt_hsync = ~(col > (47  + 640 + 16));
						 // 523
wire nxt_vsync = ~(row > (32  + 480 +  10));

				
wire[9:0] nxt_col = pxl_ending ? ((col == 10'd799) ? 10'd0 : col + 1'b1) : col;
wire[9:0] nxt_row = line_ending ? ((row == 10'd524) ? 10'd0 : row + 1'b1) : row;

assign next_col_out = nxt_col;
assign next_row_out = nxt_row;

wire h_in_frame = col >= 48 && col < (48 + 640);
wire v_in_frame = row >= 33 && row < (32 + 480);

wire black = ~(h_in_frame && v_in_frame);
//wire checker = col[6] ^ row[6] ;

wire line_ending = col == 10'd799 && pxl_ending;
wire frame_ending = row_ending && line_ending;
wire pxl_ending = pxl_counter == 2'd3;
wire row_ending = row == 10'd524;

wire[1:0] nxt_pxl = pxl_counter + 1'b1;

wire[7:0] nxt_clr = black ? 8'd0 : color;


/////////////////////////////  SEQUENTIAL LOGIC  /////////////////////////////////////

always @(posedge clk)
begin
	
	col <= nxt_col;
	row <= nxt_row;

	h_sync <= nxt_hsync;
	v_sync <= nxt_vsync;

	pxl_counter <= nxt_pxl;

	if(pxl_ending) // ON THE FOURTH CYCLE, SEND REQUEST AND UPDATE COLOR
		begin
			{vgaBlue, vgaGreen, vgaRed} <= nxt_clr;
		end
	else
		begin
			{vgaBlue, vgaGreen, vgaRed} <= {vgaBlue, vgaGreen, vgaRed};
		end
end

endmodule
