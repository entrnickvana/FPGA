`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:27 08/31/2017 
// Design Name: 
// Module Name:    btnDebouncer 
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
module btnDebouncer(
	input button1,
	input clock1,
	output reg btnPressed1,
	output testButton1
    );

	reg[31:0] satCounter; 		initial satCounter = 32'd0;
	reg[16:0] smpFreqCntr; 		initial smpFreqCntr = 17'd0; 
	reg smpClk;					initial smpClk = 1'b0;

	assign testButton1 = button1;

	/*////////////////////////////////////////////////////////////////////////////////////// 		
			Determine appropriate sample frequency for button1

			100Mhz/x = 100khz => 100Mhz/1kz = x => x = 100khz where sample freq = x = 100khz
			
			100khz reg = log2(100 x 10^3) + 1 = 17
	*////////////////////////////////////////////////////////////////////////////////////////

	always @(posedge clock1)
	begin
		// Sample clock pulse
		if(smpFreqCntr >= 17'd100000) 
			begin
				smpClk <= ~smpClk;
				smpFreqCntr <= 17'd0;
			end
		else
			begin 						
				smpClk <= smpClk;
				smpFreqCntr <= smpFreqCntr + 1'b1;
			end
	end

	// 1ms sample rate => sample freq = 1kz, button1 press must last 8ms
	always @(posedge smpClk)
	begin
		if (button1) 
			begin

				// Check if button1 has been pressed for 8ms, then update btnPressed
				if(satCounter == 32'b11111111111111111111111111111111)
					begin
						btnPressed1 <= 1;
						satCounter <= 32'd0;
					end
				else
					begin
						btnPressed1 <= 0;					
						satCounter <= {satCounter[30:0], 1'b1};
					end
			end		
		else    // button1 is not being pressed
			begin
				btnPressed1 <= 0;
				satCounter <= 32'd0;
			end
	end

endmodule
