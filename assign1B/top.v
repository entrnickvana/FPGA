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
	output [5:0]leds
    );

	parameter N = 6;

	wire buttonW;			assign buttonW = button;
	wire clockW;			assign clockW = clock;
	wire testButtonW;
	wire db_to_counter;		
	wire [N-1:0] ledsW;		assign leds = ledsW;

//	module btnDebouncer(	input button,	input clock,	output reg btnPressed,	output testButton);
	btnDebouncer bDown(		buttonW, 		clockW,			db_to_counter, 			testButtonW);


//	module NbitCounter #(parameter N = 1)(	input buttonReg,	input clock,	output[N-1:0] counter );
	Nbit_Counter #(.N(N)) c4bit(			db_to_counter, 		clock, 			ledsW); 

//  Output Assignments
	assign leds[N-1:0] = ledsW;




endmodule
