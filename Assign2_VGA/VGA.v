`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nicholas Elliott
// 
// Create Date:    08:08:23 09/07/2017 
// Design Name: 
// Module Name:    VGA 
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
	// 	48 	+ 			640	+		16 + 	96 = 800
	//	front porch     			back porch

//////////////////////////////////////////////////////////////////////////////////
module VGA(
	output reg[]
    );





integer front_porch16 = 16;
integer back_porch48 = 48;

reg [h_sync


// Resolution 

endmodule
