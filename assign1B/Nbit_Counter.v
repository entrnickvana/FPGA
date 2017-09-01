`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:47:16 08/31/2017 
// Design Name: 
// Module Name:    Nbit_Counter 
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
module Nbit_Counter #(parameter N = 1)(
	input buttonReg,
	input clock,
	output[N-1:0] counter
    );


	reg[N-1:0] counterReg; 	initial counterReg = 0;
	assign counter = counterReg;
	
	/*//////////////////////////////////
		increment

	*///////////////////////////////////
	always @(posedge clock)
	begin
		if(buttonReg)
			begin
				counterReg <= counterReg + 1'b1;			
			end
		else 
			begin
				counterReg <= counterReg;
			end
	end



endmodule
