`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:56:58 08/30/2017 
// Design Name: 
// Module Name:    groupN_seg_7 
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
module groupN_seg_7 #(parameter N = 1, parameter f = 100000000)(
	input selectHexN[N*4-1:0],
	input clock,
	output [N*8-1:0] segValN,
	output anodesN
    );

	wire clk; assign clk = clock;

	reg [N*4-1:0]selectHexN_Reg; 		assign selectHexN_Reg = selectHexN;
	reg [N*8-1:0]segValN_Reg; 	 		assign segValN = selectHexN_Reg;
	reg [N-1:0]anodesN_Reg; 			assign anodesN = anodesN_Reg;

	reg [N-1:0] anodeIndex; 			initial anodeIndex = 1;
	wire [N-1:0] anodePattern; 

	assign anodePattern = anodeIndex ^ {N{1'b1}};  //Negate 

	integer segFreq = f/(N*60);  //freq for each seg: f/(N*x) = 60hz => f/(N*60hz) = x
	integer counterSegFreq = $clog(segFreq);

	reg[counterSegFreq+1:0] counter; 		initial counter = 0;

	// Describe Anode Behavior
	always @(posedge clk) 
	begin
		if(counter >= segFreq)
			begin
				counter <= 0;
				anodeIndex <= {anodeIndex[6:0], anodeIndex[7]}; // Shift 0001 left
			end
		else 			
			begin
				counter <= counter + 1'b1;
				anodeIndex <= anodeIndex;
			end
	end

	assign anodesN = anodePattern;


	generate
		for(i = 0; i < N-1; i = i + 1)
			begin
					//module seg_7(input [3:0] selectHex, output [7:0] segVal);
					seg_7 SSD(selectHexN[i*4-1:0], segValN[i*8-1:0]);
			end
		
	endgenerate




endmodule
