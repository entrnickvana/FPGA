`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: JWL Industries
// Engineer: Nicholas Elliott
// 
// Create Date:    00:33:02 08/26/2017 
// Design Name: 
// Module Name:    led_Mod 
// Project Name: 
// Target Devices: Spartan 6
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
module led_Mod(
	input x1,
	input [7:0] switches,
	input bBottom,
	input bLeft,
	output [7:0] leds,
	output [3:0] anodes,
	output reg[7:0] SSD
	    );

	
	wire clock;
	wire stopButton;
	wire leftButton;
	wire anode1;


	//Create a counter which will be incremented by clock signal
	reg [10:0] clockDivider;
	reg [28:0] counter;
	reg [3:0] anodesReg;
	reg [3:0] SSD_REG_OUT;  
	reg [1:0] anodeState;

	/*  For Future use with text

	*/
	wire[7:0] a; assign a = 8'b10001000;
	wire[7:0] b; assign b = 8'b10000011;
	wire[7:0] c; assign c = 8'b11000110;
	wire[7:0] d; assign d = 8'b10100001;
	wire[7:0] e; assign e = 8'b10000110;
	wire[7:0] f; assign f = 8'b10001110;

	/* For use in case statment for Seven Segment output

	*/
	wire[7:0] num0; assign num0 = 8'b11000000;
	wire[7:0] num1; assign num1 = 8'b11111001;
	wire[7:0] num2; assign num2 = 8'b10100100;
	wire[7:0] num3; assign num3 = 8'b10110000;
	wire[7:0] num4; assign num4 = 8'b10011001;
	wire[7:0] num5; assign num5 = 8'b10010010;
	wire[7:0] num6; assign num6 = 8'b10000010;
	wire[7:0] num7; assign num7 = 8'b11111000;
	wire[7:0] num8; assign num8 = 8'b10000000;
	wire[7:0] num9; assign num9 = 8'b10010000;
	wire[7:0] numA; assign numA = a;
	wire[7:0] numB; assign numB = b;
	wire[7:0] numC; assign numC = c;
	wire[7:0] numD; assign numD = d;
	wire[7:0] numE; assign numE = e;
	wire[7:0] numF; assign numF = f;

	
	//Bind crystal to clock
	assign clock = x1;
	assign stopButton = bBottom;
	assign leftButton = bLeft;

	// Bind upper bits of counter to leds
	assign leds = counter[28:21];



	// Initialize counter to value of zero, no reset needed
	initial counter = 0;
	initial anodesReg = 4'b0000;
	initial anodeState = 2'b01;
	initial SSD_REG_OUT = 8'b00000000;
	initial clockDivider = 11'b00000000000;

	/* Defines behavior of LED counter
	   When bottom button is pressed counting stops
	*/
	always@(posedge clock)
	begin

		if(stopButton == 1'b1) 
			begin
				counter <= counter;			
			end
		else 
			begin
				counter <= counter + 1'b1;			
			end

	end


	/*  clockDivider counts to 1,250 and then allows anodeState to increment
		Crystal x1 = 100Mhz, Clock divider divides by x1@100Mhz by 1,250 = 80khz.
		anodeState has four states which further divides 80khz by 4 = 20khz.

		=> 100Mhz/(4*1,250) = 20khz
	*/
	always @(posedge clock)
	begin

		if(clockDivider == 11'b10011100010)  // Dive clock to 20khz
			begin
				anodeState <= anodeState + 1'b1;
				clockDivider <= 11'b00000000000;			
			end
		else 
			begin
				anodeState <= anodeState;
				clockDivider <= clockDivider + 1'b1; 
			end

	end


	/* 4 State, Case defined state machine.
	   Each state will produce a lit digit for 1/20khz = 50 useconds per digit.
	   SSD_REG_OUT works as a multiplexer which defines Seven Segment Displays physical output.
	*/
	always @(posedge clock) 
	begin

		// If left button is not pressed, output switch values represented as HEX on SSD
		if(leftButton == 1'b0)
			begin
				case(anodeState)
				2'b00:begin
							anodesReg <= 4'b1110;
							SSD_REG_OUT <= switches[3:0];
					  end
				2'b01:begin
							anodesReg <= 4'b1101;
							SSD_REG_OUT <= switches[7:4];
					  end
				2'b10:begin
							anodesReg <= 4'b1011;		
							SSD_REG_OUT <= 8'b00000000;
					  end
				2'b11:begin
							anodesReg <= 4'b0111;
							SSD_REG_OUT <= 8'b00000000;
					  end
				endcase
			end
		else // if button is pressed, display the values of the clock counter on SSD
			begin
							case(anodeState)
				2'b00:begin
							anodesReg <= 4'b1110;
							SSD_REG_OUT <= counter[16:13];
					  end
				2'b01:begin
							anodesReg <= 4'b1101;
							SSD_REG_OUT <= counter[20:17];
					  end
				2'b10:begin
							anodesReg <= 4'b1011;		
							SSD_REG_OUT <= counter[24:21];
					  end
				2'b11:begin
							anodesReg <= 4'b0111;
							SSD_REG_OUT <= counter[28:25];
					  end
				endcase
				
			end
	end

	// Assign register output to physical Anode pins
	assign anodes = anodesReg;	

	/*	Multiplexed SSD outputs selected by SSD_REG_OUT
		
	*/
	always @(*) 
	begin
		case(SSD_REG_OUT)
		4'd0:SSD = num0;
		4'd1:SSD = num1;
		4'd2:SSD = num2;
		4'd3:SSD = num3;
		4'd4:SSD = num4;
		4'd5:SSD = num5;
		4'd6:SSD = num6;
		4'd7:SSD = num7;
		4'd8:SSD = num8;
		4'd9:SSD = num9;
		4'd10:SSD = numA;
		4'd11:SSD = numB;
		4'd12:SSD = numC;
		4'd13:SSD = numD;
		4'd14:SSD = numE;
		4'd15:SSD = numF;
		endcase
	end
	

endmodule