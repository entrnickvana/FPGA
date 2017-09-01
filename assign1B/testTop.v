`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:04:35 08/31/2017
// Design Name:   top
// Module Name:   C:/Users/Nickj/Desktop/NickFall2017/ECE_3710/FPGA_PROJECTS/assign1B/testTop.v
// Project Name:  assign1B
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testTop;

	// Inputs
	reg button;
	reg clock;

	// Outputs
	wire testButton;
	wire [5:0] leds;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.button(button), 
		.clock(clock), 
		.testButton(testButton), 
		.leds(leds)
	);

	initial begin
		// Initialize Inputs
		button = 0;
		clock = 0;
		#10;


		button = 1;
		clock = 1;
		#10;


		button = 0;
		clock = 0;
		#10;


		// Wait 100 ns for global reset to finish
		#100;


		always 
		#10 clock = ~clock;




		int i;
		int cycles = 10000;
		int rand;

		for(i = 0; i < cycles; i = i + 1)
		begin
			
			if(i % 21 == 0)
			begin
			button = 1;
				for(rand = 0; rand < i%10; rand = rand + 1)
				begin
					
				#5
				end
			button = 0;
			end
			#13;
		end





        
		// Add stimulus here

	end
      
endmodule

