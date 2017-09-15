`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:04:28 09/15/2017 
// Design Name: 
// Module Name:    pixel_gen 
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
module pixel_gen(
	input clk,
	input req,
	//input snowButton,
	input[9:0] col, 				
	input[9:0] row,
	input[7:0] switches,
	output reg[7:0] next_color
    );
	
	wire checker = col[6] ^ row[6];
	//reg[29:0] random;		 		initial random = 30'd3;


	wire[7:0] new_next_color = checker ? 8'd0 : switches;

	always @(posedge clk) 
	begin
		if(req == 1'b1)
			begin
				//next_color <= snowButton ? random[7:0] : new_next_color;				
				next_color <= new_next_color;				
				//random <= {random[29:2], random[29] ^ random[27], random[28]^random[26]};
			end
		else
			begin
				next_color <= next_color;			
	//			random <= random;
			end

	end	
	


endmodule
