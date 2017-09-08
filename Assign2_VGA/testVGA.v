`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:52:08 09/07/2017
// Design Name:   vgaController
// Module Name:   C:/Users/Nickj/Desktop/NickFall2017/ECE_3710/FPGA_PROJECTS/Assign2_VGA/testVGA.v
// Project Name:  Assign2_VGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vgaController
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testVGA;

	// Inputs
	reg clk;

	// Outputs
	wire [1:0] vgaBlue;
	wire [2:0] vgaGreen;
	wire [2:0] vgaRed;
	wire h_sync;
	wire v_sync;

	// Instantiate the Unit Under Test (UUT)
	vgaController uut (
		.clk(clk), 
		.vgaBlue(vgaBlue), 
		.vgaGreen(vgaGreen), 
		.vgaRed(vgaRed), 
		.h_sync(h_sync), 
		.v_sync(v_sync)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		// Wait 100 ns for global reset to finish
		#100;
        





		// Add stimulus here

	end
    
	always
	#5 clk = ~clk;

endmodule

