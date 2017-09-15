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
	input snowButton,
	input[9:0] col, 				
	input[9:0] row,
	input[7:0] switches,
	output reg[7:0] next_color
    );
	
	wire checker = logic_col[6] ^ logic_row[6];

	reg[30:0] random;		 		initial random = 31'd733;

	wire [9:0]logic_col = col - 10'd48;
	wire [9:0]logic_row = row - 10'd33;



	wire[7:0] new_next_color = switches[0] ? random[7:0] : checker ? 8'd0 : {switches[7:1], 1'b0};

	always @(posedge clk) 
	begin
		random <= {random[28:0], random[30] ^ random[28], random[29] ^ random[27]};

		if(req == 1'b1)
			begin
				next_color <= new_next_color;				
			end
		else
			begin
				next_color <= next_color;			
			end
	end	


	


endmodule
