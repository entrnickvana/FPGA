`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:07 08/30/2017 
// Design Name: 
// Module Name:    buttonDebouncer 
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


module buttonDebouncer(
	input clock,
	input button,
	output testButton,
	output reg buttonState,
	output reg[5:0] testCounter
    );

	assign testButton = button;
	
	wire clk; 	assign clk = clock;
	wire btn;	assign btn = button;

	reg[17:0] btnCounter;					initial btnCounter = 18'd0;
	reg[17:0] resetBtnCounter;				initial resetBtnCounter = 18'd0;
	reg btnSmplClk;							initial btnSmplClk = 1'b0;
	reg [13:0] btnSmplCntr;					initial btnSmplCntr = 14'd0;
	initial	testCounter = 6'b111111;
	initial buttonState = 1'b0;


	/*	Reduce button press sampling rate  14'b10011100010000 = 10,0000 = 10khz = 10,000 samples per second


	*/
 	always @(posedge clk) 
 	begin

 		if(btnSmplCntr >= 14'd10)
 		btnSmplClk <= btnSmplClk ^ 1'b1;  //Negate/Invert Previous Reg Value
 		
 	end


	/*  Button Debouncer
	
	*/
	always @(posedge clk) 
	begin
		if(btn == 1'b1)
			begin
					testCounter <= 6'b010101;
								// 50,000					   				// 100,000
				if(btnCounter > 18'd80000 && resetBtnCounter < 18'd150000 )
					begin
					buttonState <= buttonState ^ 1'b1;  //Negation of current state
					btnCounter <= 18'd0;
					resetBtnCounter <= 18'd0;
				
					end
				else if(resetBtnCounter > 18'd150000)
					begin
					buttonState <= buttonState;
					btnCounter <= 18'd0;
					resetBtnCounter <= 18'd0;

					end
				else 
					begin
					buttonState <= buttonState;
					btnCounter <= btnCounter + 1'b1;
					resetBtnCounter <= resetBtnCounter + 1'b1;

					end
			end
		else
			begin
				if(resetBtnCounter > 18'd150000)
					begin
					buttonState <= buttonState;
					btnCounter <= 18'd0;
					resetBtnCounter <= 18'd0;
					testCounter <= 6'b001111;
					end
				else
					begin
					buttonState <= buttonState;
					btnCounter <= btnCounter;
					resetBtnCounter <= resetBtnCounter + 1'b1;
					testCounter <= 6'b011111;					
					end
			end
	end

endmodule
