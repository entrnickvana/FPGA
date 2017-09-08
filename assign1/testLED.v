`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:38:32 09/01/2017
// Design Name:   led_Mod
// Module Name:   C:/Users/Nickj/Desktop/NickFall2017/ECE_3710/FPGA_PROJECTS/assign1/testLED.v
// Project Name:  assign1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: led_Mod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testLED;

	// Inputs
	reg x1;
	reg [7:0] switches;
	reg bBottom;
	reg bLeft;
	reg bRight;

	// Outputs
	wire [7:0] leds;
	wire [3:0] anodes;
	wire [7:0] SSD;

	// Instantiate the Unit Under Test (UUT)
	led_Mod uut (
		.x1(x1), 
		.switches(switches), 
		.bBottom(bBottom), 
		.bLeft(bLeft), 
		.bRight(bRight), 
		.leds(leds), 
		.anodes(anodes), 
		.SSD(SSD)
	);


	integer i;
	integer k;
	integer j;

	initial begin
		// Initialize Inputs
		x1 = 0;
		switches = 0;
		bBottom = 0;
		bLeft = 0;
		bRight = 0;

		// Wait 100 ns for global reset to finish
		#100;

		// Reset

		x1 = 1;
		switches = 8'd0;
		bBottom = 1;
		bLeft = 1;
		bRight = 1;

		#10;

		x1 = 0;
		switches = 0;
		bBottom = 0;
		bLeft = 0;
		bRight = 0;

		// Add stimulus here

		
		forever 
		#5 x1 = !x1;

		forever
		#400 bRight = !bRight;

	end
      
endmodule

