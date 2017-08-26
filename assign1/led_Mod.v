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
#Net "seg<0>" LOC = T17 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L51P_M1DQ12, Sch name = CA
#Net "seg<1>" LOC = T18 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L51N_M1DQ13, Sch name = CB
#Net "seg<2>" LOC = U17 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L52P_M1DQ14, Sch name = CC
#Net "seg<3>" LOC = U18 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L52N_M1DQ15, Sch name = CD
#Net "seg<4>" LOC = M14 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L53P, Sch name = CE
#Net "seg<5>" LOC = N14 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L53N_VREF, Sch name = CF
#Net "seg<6>" LOC = L14 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L61P, Sch name = CG
#Net "seg<7>" LOC = M13 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L61N, Sch name = DP

#Net "an<0>" LOC = N16 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L50N_M1UDQSN, Sch name = AN0
#Net "an<1>" LOC = N15 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L50P_M1UDQS, Sch name = AN1
#Net "an<2>" LOC = P18 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L49N_M1DQ11, Sch name = AN2
#Net "an<3>" LOC = P17 | IOSTANDARD = LVCMOS33; #Bank = 1, pin name = IO_L49P_M1DQ10, Sch name = AN3



## Switches
#Net "sw<0>" LOC = T10 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L29N_GCLK2, Sch name = SW0
#Net "sw<1>" LOC = T9 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L32P_GCLK29, Sch name = SW1
#Net "sw<2>" LOC = V9 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L32N_GCLK28, Sch name = SW2
#Net "sw<3>" LOC = M8 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L40P, Sch name = SW3
#Net "sw<4>" LOC = N8 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L40N, Sch name = SW4
#Net "sw<5>" LOC = U8 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L41P, Sch name = SW5
#Net "sw<6>" LOC = V8 | IOSTANDARD = LVCMOS33; #Bank = 2, pin name = IO_L41N_VREF, Sch name = SW6
#Net "sw<7>" LOC = T5 | IOSTANDARD = LVCMOS33; #Bank = MISC, pin name = IO_L48N_RDWR_B_VREF_2, Sch name = SW7



*/
//////////////////////////////////////////////////////////////////////////////////
module led_Mod(
	input x1,
	output [7:0] leds
    );

	wire clock;

	//Bind crystal to clock
	assign clock = x1;



	//Create a counter which will be incremented by clock signal
	reg [28:0] counter;

	// Initialize counter to value of zero, no reset needed
	initial counter = 0;

	// On each clock edge increment counter by one bit value of one
	always@(posedge clock)
	begin
		counter <= counter + 1'b1;

		//Simulate a 7 with A, B, C grounded
	end

	// Bind upper bits of counter to leds
	assign leds = counter[28:21];

endmodule
