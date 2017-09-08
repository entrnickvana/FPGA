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
	output btnPressed1
    );

	reg[16:0] dwnSmpClk;  initial dwnSmpClk = 17'd0;
	reg[16:0] satCounter; initial satCounter = 17'd0;
	reg btnPressedReg;    initial btnPressedReg = 1'b0;

	assign btnPressed1 = btnPressedReg;
	
	always @(posedge clock1)
	begin

		// Divide 100Mhz/100000 = 1khz
		if(dwnSmpClk == 17'd100000)  ////////////////// 1khz ///////////////////////////////////
			begin


				dwnSmpClk <= 17'd0; // Reset at 100,000 cycles
				


				if(button1 == 1'b1)  //// Is button pressed?
					begin

						if(satCounter == 16'b1111111111111111) /// held for 1ms * 16 = 16ms
							begin
								btnPressedReg <= 1'b1; // btnPressed for 1 100Mhz cycle

								//Flush sat counter, btnPress recorded
								satCounter <= 16'd0;	
							end
						else 								   /// Not yet 1ms * 16 = 16ms
							begin
								btnPressedReg <= 1'b0;
								satCounter <= {satCounter[14:0], 1'b1};
							end
		
					end
				else 										   /// Button not pressed, satCounter is flushed, btnPress LO
					begin
							satCounter <= 16'd0;			
							btnPressedReg <= 1'b0;
					end
			///////////////////////////////////////////////////////////

			end
		else 	////////////////// 100Mhz ///////////////////////////////////
			begin
				dwnSmpClk <= dwnSmpClk +1'b0;	
				satCounter <= satCounter;
				btnPressedReg <= 0;
			end

	end

endmodule
