`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:56:40 09/15/2017
// Design Name:   topVGA
// Module Name:   C:/Users/Nickj/Desktop/NickFall2017/ECE_3710/FPGA_PROJECTS/vgaController2/testVGA.v
// Project Name:  vgaController2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: topVGA
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
	reg snowButton;
	reg [7:0] switches;

	// Outputs
	wire [1:0] vgaBlue_Pad;
	wire [2:0] vgaGreen_Pad;
	wire [2:0] vgaRed_Pad;
	wire h_sync_Pad;
	wire v_sync_Pad;

	// Instantiate the Unit Under Test (UUT)
	topVGA uut (
		.clk(clk), 
		.snowButton(snowButton), 
		.switches(switches), 
		.vgaBlue_Pad(vgaBlue_Pad), 
		.vgaGreen_Pad(vgaGreen_Pad), 
		.vgaRed_Pad(vgaRed_Pad), 
		.h_sync_Pad(h_sync_Pad), 
		.v_sync_Pad(v_sync_Pad)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		snowButton = 0;
		switches = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		switches = 8'b11001100;
		snowButton = 1;
	end

	

	always
	#5 clk = ~clk;

	
      
endmodule

