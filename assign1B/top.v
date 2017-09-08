`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:35 08/31/2017 
// Design Name: 
// Module Name:    top 
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
module top(
	input button,
	input clock,
	output testButton,
	output [7:0]leds,
	output [7:0]segOutput,
	output [3:0]anodes
    );

	parameter N_count = 8;
	parameter N_seg_7 = 4;

	wire buttonW;			assign buttonW = button;
	wire clockW;			assign clockW = clock;
	wire db_to_counter;		

	wire [7:0]segMod_to_segOut;		assign segOutput = segMod_to_segOut;

	// Output Assignment
	wire [N_count-1:0] ledsW;		assign leds = ledsW;

	assign anodes = 4'b1110;

//	module btnDebouncer(	input button,	input clock,	output reg btnPressed,	output testButton);
	btnDebouncer bDown(		buttonW, 		clockW,			db_to_counter);


//	module NbitCounter #(parameter N = 1)(	input buttonReg,	input clock,	output[N-1:0] counter );
	Nbit_Counter #(.N(N_count)) c8bit(		db_to_counter, 		clock, 			ledsW); 

//  4 SSD
//	module seg_7( input [3:0] selectHex,	output [7:0] segVal    );
	seg_7 	seg1( ledsW[3:0], 				segMod_to_segOut       );	





endmodule
