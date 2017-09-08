`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:30:36 09/07/2017 
// Design Name: 
// Module Name:    vgaController 
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
///

/*
VGA Signal 640 x 480 @ 60 Hz Industry standard timing

 Interested in easy to use VGA solution for embedded applications? Click here!
General timing
Screen refresh rate	60 Hz
Vertical refresh	31.46875 kHz
Pixel freq.	25.175 MHz
Horizontal timing (line)

Polarity of horizontal sync pulse is negative.
Scanline part	Pixels	Time [µs]
Visible area	640	25.422045680238
Front porch	16	0.63555114200596
Sync pulse	96	3.8133068520357
Back porch	48	1.9066534260179
Whole line	800	31.777557100298

Vertical timing (frame)

Polarity of vertical sync pulse is negative.
Frame part	Lines	Time [ms]
Visible area	480	15.253227408143
Front porch	10	0.31777557100298
Sync pulse	2	0.063555114200596
Back porch	33	1.0486593843098
Whole frame	525	16.683217477656
*/


//////////////////////////////////////////////////////////////////////////////////
module vgaController(
	input clk,
	output reg[1:0] vgaBlue,
	output reg[2:0] vgaGreen,
	output reg[2:0] vgaRed,
	output reg h_sync,
	output reg v_sync
    );


reg[9:0] col; 				initial col = 10'd0;
reg[9:0] row;				initial row = 10'd0;
reg[1:0] pxl_counter;		initial pxl_counter = 2'd0;

initial h_sync = 1'b1;
initial v_sync = 1'b1;


//////////////////////////////  NEXT CYCLE COMBINATORIAL LOGIC //////////////////////

						 // 704
wire nxt_hsync = ~(col >= (47  + 640 + 16));
						 // 523
wire nxt_vsync = ~(row >= (32  + 480 +  10));
				
//wire nxt_col = pxl_ending ? ((col == 10'd799) ? 10'd0 : col + 1'b1) : col;
//wire nxt_row = line_ending ? ((row == 10'd524) ? 10'd0 : row + 1'b1) : row;

wire h_in_frame = col >= 47 && col < (46 + 640);
wire v_in_frame = row >= 32 && row < (32 + 480);

wire black = ~(h_in_frame && v_in_frame);
wire checker = 1; //((col & ~(10'd10))) > 10'd31 && ((row & ~(10'd10)) > 10'd23);

wire line_ending = col == 10'd799;
wire frame_ending = row_ending && line_ending;
wire pxl_ending = pxl_counter == 2'd3;
wire row_ending = row == 10'd524;

wire[1:0] nxt_pxl = pxl_counter + 1'b1;

wire[7:0] color = {2'b11, 3'b111, 3'b111};

wire[7:0] nxt_clr = black ? 8'd0 : checker ? color : 8'd0;


/////////////////////////////  SEQUENTIAL LOGIC  /////////////////////////////////////

always @(posedge clk)
begin
	
	col <= pxl_ending ? ((col == 10'd799) ? 10'd0 : col + 1'b1) : col;
	row <= line_ending ? ((row == 10'd524) ? 10'd0 : row + 1'b1) : row;

	h_sync <= nxt_hsync;
	v_sync <= nxt_vsync;

	pxl_counter <= nxt_pxl;

	{vgaBlue, vgaGreen, vgaRed} <= nxt_clr;

end


endmodule
