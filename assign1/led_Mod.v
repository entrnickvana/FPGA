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

/*


## 7 segment display
Net "SSD[0]" LOC = T17 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L51P_M1DQ12, Sch name = CA
Net "SSD[1]" LOC = T18 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L51N_M1DQ13, Sch name = CB
Net "SSD[2]" LOC = U17 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L52P_M1DQ14, Sch name = CC
Net "SSD[3]" LOC = U18 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L52N_M1DQ15, Sch name = CD
Net "SSD[4]" LOC = M14 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L53P, Sch name = CE
Net "SSD[5]" LOC = N14 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L53N_VREF, Sch name = CF
Net "SSD[6]" LOC = L14 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L61P, Sch name = CG
Net "SSD[7]" LOC = M13 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L61N, Sch name = DP

Net "anodes[0]" LOC = N16 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L50N_M1UDQSN, Sch name = AN0
Net "anodes[1]" LOC = N15 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L50P_M1UDQS, Sch name = AN1
Net "anodes[2]" LOC = P18 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L49N_M1DQ11, Sch name = AN2
Net "anodes[3]" LOC = P17 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L49P_M1DQ10, Sch name = AN3



## Switches
Net "switches[0]" LOC = T10 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L29N_GCLK2, Sch name = SW0
#Net "switches[1]" LOC = T9 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L32P_GCLK29, Sch name = SW1
#Net "switches[2]" LOC = V9 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L32N_GCLK28, Sch name = SW2
#Net "switches[3]" LOC = M8 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L40P, Sch name = SW3
#Net "switches[4]" LOC = N8 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L40N, Sch name = SW4
#Net "switches[5]" LOC = U8 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L41P, Sch name = SW5
#Net "switches[6]" LOC = V8 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L41N_VREF, Sch name = SW6
#Net "switches[7]" LOC = T5 | IOSTANDARD = LVCMOS33; #Bank = MISC, pin name = IO_L48N_RDWR_B_VREF_2, Sch name = SW7



*/
//////////////////////////////////////////////////////////////////////////////////
module led_Mod(
	input x1,
	input [7:0] switches,
	input bTop,
	input bBottom,
	input bLeft,
	input bRight,
	output [7:0] leds,
	//output aSeg, bSeg, cSeg, dSeg, eSeg, fSeg, gSeg, dpSeg,
	output [3:0] anodes,
	output reg[7:0] SSD
	    );

	
	wire clock;
	wire stopButton;
	wire anode1;
	wire switch;
	//Create a counter which will be incremented by clock signal
	reg [11:0] clockDivider;
	reg [28:0] counter;
	reg [3:0] anodesReg;
	reg [3:0] SSD_REG_OUT;  // 1 2 4 8 16 32 64 128 256 512 1024
							// 0 1 2 3 4  5 6   7   8   9   10


	/*
	reg [8:0] firstDigit;
	reg [8:0] secondDigit;
	reg [8:0] thirdDigit;
	reg [8:0] fourthDigit;
	*/

	reg [1:0] segMux;


	wire[7:0] a; assign a = 8'b10001000;

	wire[7:0] b; assign b = 8'b10000011;
	wire[7:0] c; assign c = 8'b11000110;
	wire[7:0] d; assign d = 8'b10100001;
	wire[7:0] e; assign e = 8'b10000110;
	wire[7:0] f; assign f = 8'b10001110;


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


	wire[7:0] numA;
	wire[7:0] numB;
	wire[7:0] numC;
	wire[7:0] numD;
	wire[7:0] numE;
	wire[7:0] numF;

	assign numA = a;
	assign numB = b;
	assign numC = c;
	assign numD = d;
	assign numE = e;
	assign numF = f;
	


	/*
	reg[7:0] e;
	reg[7:0] f;
	reg[7:0] g;
	reg[7:0] h;
	reg[7:0] i;
	reg[7:0] j;
	reg[7:0] k;
	reg[7:0] l;
	reg[7:0] m;
	reg[7:0] n;
	reg[7:0] o;
	reg[7:0] p;
	reg[7:0] q;
	reg[7:0] r;
	reg[7:0] s;
	reg[7:0] t;
	reg[7:0] u;
	reg[7:0] v;
	reg[7:0] w;
	reg[7:0] x;
	reg[7:0] y;
	reg[7:0] z;
	*/
	
	
	//Bind crystal to clock
	assign clock = x1;
	assign stopButton = bBottom;
	// Bind upper bits of counter to leds
	assign leds = counter[28:21];



	// Initialize counter to value of zero, no reset needed
	initial counter = 0;
	initial anodesReg = 4'b0000;
	initial segMux = 2'b01;
	initial SSD_REG_OUT = 8'b00000000;
	initial clockDivider = 11'b00000000000;
	//initial switchesTemp = 8'b00000000;


	// On each clock edge increment counter by one bit value of one
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

/*
	always@(posedge clock) 
	begin
		
		case(switches)
		4'b0000:begin // 0
				end
		4'b0001:begin // 1
			
				end
		4'b0010:begin // 2
			
				end
		4'b0011:begin // 3
			
				end
		4'b0100:begin // 4
			
				end
		4'b0101:begin // 5
			
				end
		4'b0110:begin // 6
			
				end
		4'b0111:begin // 7
			
				end
		4'b1000:begin // 8
			
				end
		4'b1001:begin // 9
			
				end
		4'b1010:begin // 10
			
				end
		4'b1011:begin // 11
			
				end
		4'b1100:begin // 12
			
				end
		4'b1101:begin // 13
			
				end
		4'b1110:begin // 14
			
				end
		4'b1111:begin // 15
			
				end
		default:begin // Default
				end
			
		endcase
	end
*/


/*
	always @(posedge clock)
	begin
		case(segMux)
		2'b00:begin

			  end
		2'b01:begin

			  end
		2'b10:begin

			  end
		2'b11:begin

			  end
		default:begin

			  end
		endcase
	end
*/


	/*
	Increment the select of the proper anode at 100Mhz /4 = 25Mhz, 100Mhz/x = 20khz 
	*/
	always @(posedge clock)
	begin

		if(clockDivider == 11'b10011100010)  // Dive clock to 20khz
			begin
				segMux <= segMux + 1'b1;
				clockDivider <= 11'b00000000000;			
			end
		else 
			begin
				segMux <= segMux;
				clockDivider <= clockDivider + 1'b1;
			end

	end



	always @(posedge clock) 
	begin

		case(segMux)
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
					SSD_REG_OUT <= switches[3:0];
			  end
		2'b11:begin
					anodesReg <= 4'b0111;
					SSD_REG_OUT <= switches[7:4];
			  end
		endcase
	end

	assign anodes = anodesReg;	



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
