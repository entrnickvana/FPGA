`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:49 09/16/2017 
// Design Name: 
// Module Name:    pixel_gen 
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
module pixel_gen(
	input clk,
	input req,
	input[9:0] col, 				
	input[9:0] row,
	input[9:0] switches,
	input[15:0] fetched_data,
	output reg[7:0] next_color,
	output reg[13:0] fetch_addr,
	input [9:0] next_col_in,		
	input [9:0] next_row_in  		
    );
	
	///////////////////  GLYPH LOGIC  ///////////////////////

	wire [9:0]logic_col = col - 10'd46;
	wire [9:0]logic_row = row - 10'd33;

	// Divide 640 /8 = 80, 480/ 8 = 60
	wire h_before_frame = col < 48;
	wire v_before_frame = row < 33;
	wire h_after_frame = col >= (48 + 640);
	wire v_after_frame = row >= (32 + 480);
																			// 640 X 480 
	wire[6:0] glyph_col = reg_logical_col[9:3];	//h_before_frame ? 7'd0 : h_after_frame ? 7'd127 : reg_logical_col[8:3];
	wire[5:0] glyph_row = reg_logical_row[8:3];	//v_before_frame ? 6'd0 : v_after_frame ? 5'd63  : reg_logical_row[7:3];

	// Is the current pixel within visible area
	wire h_in_frame = col >= 48 && col < (48 + 640);
	wire v_in_frame = row >= 33 && row < (32 + 480);
	wire in_frame = h_in_frame && v_in_frame;
	wire[9:0] check = row ^ col;
	wire check2 = reg_logical_row[9] ^ reg_logical_col[9];


	wire[13:0] fetch_text_addr;
											// x4					+
	reg[7:0] char_data_out; 		initial char_data_out = 8'd0;

	wire[15:0] char_data_wire = fetched_data;

 	reg[15:0] glyph_data_out;		initial glyph_data_out = 16'd0;

	wire[13:0] ascii_to_glyph = {char_data_wire[7:0], 1'b0, 1'b0} + glyph_word_index + 14'd8192;
	//128 * 64							2 + 5 + 7 = 14 bit                    
	wire[13:0] char_data_address = {1'd0, glyph_row, 7'd0} + {8'd0, glyph_col};

	reg[1:0] glyph_word_index;

	wire[3:0] glyph_bit_index = 4'd15 - reg_logical_col[3:0];

	wire glyph_bit = reg_logical_row[0] == 0 ? glyph_data_out[7 - glyph_bit_index[2:0] + 8] :  glyph_data_out[7 - glyph_bit_index[2:0]];

	
	///////////////  DETERMINE GLYPH WORD INDEX  /////////////////////////
	always @(*)
	begin
		case(reg_logical_row[2:0])
		3'd0: glyph_word_index = 2'd0;
		3'd1: glyph_word_index = 2'd0;
		3'd2: glyph_word_index = 2'd1;
		3'd3: glyph_word_index = 2'd1;
		3'd4: glyph_word_index = 2'd2;
		3'd5: glyph_word_index = 2'd2;
		3'd6: glyph_word_index = 2'd3;
		3'd7: glyph_word_index = 2'd3;
		endcase
	end
	///////////////////////////////////////////////////////////////////////



	////////////////  MULTIPLEX WIRE INPUTS TO MEM ADDRESS BASED ON STATE  ///////////////////////
	always@(*)
	begin
		case(state)
		2'd0: begin
			  	fetch_addr = char_data_address;
	    	  end 
		2'd1: begin
				fetch_addr = ascii_to_glyph;
	    	  end 
		2'd2: begin
				fetch_addr = ascii_to_glyph;
	    	  end 
		2'd3: begin
				fetch_addr = ascii_to_glyph;
	    	  end 
		endcase
	end
	/////////////////////////////////////////////////////////////////////////////////////////////////


	///////////////  DETERMINE GLYPH WORD INDEX  /////////////////////////

	/////////////////////////////////////////////////////////

	wire checker = reg_logical_col[6] ^ reg_logical_row[6];

	reg[30:0] random;		 				initial random = 31'd733;
	reg[1:0] state;							initial state = 2'd0;
	reg[9:0] reg_logical_col;  				initial reg_logical_col = 10'd0 - 10'd48;	
	reg[9:0] reg_logical_row;  				initial reg_logical_row = 10'd0 - 10'd33;

	//wire[7:0] new_next_color =  glyph_bit ? char_data_out[15:8] : 8'b00000000;  //snowButton ? random[7:0] : checker ? 8'd0 : switches[7:0];
	reg[7:0] new_next_color;

	always @(*)
	begin
		case(switches[9:8])
		2'd0: new_next_color = checker ? 8'd0 : switches[7:0];
		2'd1: new_next_color = random[7:0];
		2'd2: new_next_color = glyph_bit ? char_data_out[7:0] : 8'b00000000;
 		2'd3: new_next_color =  glyph_bit ? 8'b11111111 : 8'b00000000; 
		endcase
	end

	always @(posedge clk) 
	begin

		/////////////////  RANDOM NUMBER GENERATION  ////////////////////////////////
		random <= {random[28:0], random[30] ^ random[28], random[29] ^ random[27]};

		/////////////////  REQUEST LOGIC  ////////////////////////////////
		if(req == 1'b1)
			begin
				next_color <= new_next_color;
				state <= 2'd0;				
			end
		else
			begin
				next_color <= next_color;
				state <= state + 1'b1;			
			end
		//////////////////////////////////////////////////////////////////


		/////////////////  REQUEST LOGIC  ////////////////////////////////
		/////////////////  REQUEST LOGIC  ////////////////////////////////				

		case(state)
		2'd0:begin
			/////////   Fetch Text Data   	  /////////////
			/////////   Logic Col Available   /////////////
			/////////   Logic Row Available   /////////////
				char_data_out 	<= char_data_out;  
				glyph_data_out 	<= glyph_data_out;
				reg_logical_col <= reg_logical_col;
				reg_logical_row <= reg_logical_row;
			 end
		2'd1:begin
			/////////   Fetch Glyph Data   	  /////////////
			/////////   Text Data Available   /////////////			
				char_data_out 	<= fetched_data[7:0];
				glyph_data_out 	<= glyph_data_out;
				reg_logical_col <= reg_logical_col;
				reg_logical_row <= reg_logical_row;
			 end
		2'd2:begin
			/////////   Glyph Data Available   /////////////
				char_data_out 	<= char_data_out;
				glyph_data_out 	<= fetched_data;
				reg_logical_col <= reg_logical_col;
				reg_logical_row <= reg_logical_row;
			 end
		2'd3:begin
			////////    STAGE NEXT LOG ROW & LOG COL  ////////////
				char_data_out 	<= char_data_out;
				glyph_data_out 	<= glyph_data_out;
				reg_logical_col <= next_col_in - 10'd48;
				reg_logical_row <= next_row_in - 10'd33;
			 end	
		endcase
	end


endmodule
