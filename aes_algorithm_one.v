module aes_algorithm_one(clock,initial_state,final_state);
	input clock;
	input [127:0] initial_state;
	reg [127:0] cipher_key=128'h2b28ab097eaef7cf15d2154f16a6883c; //use
	reg [127:0] round_key; // use
	reg [127:0] initial_cipher_key=128'h2b28ab097eaef7cf15d2154f16a6883c;

	
	//reg [127:0] in_state=128'h328831e0435a3137f6309807a88da234; //delete
	reg [127:0] in_state=128'h3902dc1925dc116a8409850b1dfb9732; // decrypt key
	
	reg [127:0] out_state; // use (or delete)
	
	reg [7:0] two_A0,two_A1,two_A2,two_A3; //use
	reg [7:0] three_A0,three_A1,three_A2,three_A3; //use
	
	reg [7:0] nine_A0,nine_A1,nine_A2,nine_A3;
	reg [7:0] b_A0,b_A1,b_A2,b_A3;
	reg [7:0] d_A0,d_A1,d_A2,d_A3;
	reg [7:0] e_A0,e_A1,e_A2,e_A3;
	reg [7:0] A0,A1,A2,A3;
	
	reg [4:0] nine_process =5'd0;
	
	reg [31:0] temp_round; //use( or delete )
	
	reg [7:0] r_con; //use (or delete)


	output reg[127:0] final_state; //use

	reg [3:0] round=4'd0; //use(or reduce)
	reg [3:0] round_process=4'd0;  //use (or reduce)
	// 1. subBytes 2. shift Row 3. MixColumn 4. Add Round Key
	reg [4:0] process=5'd0; // box 1 to 16  //use (or reduce)
	reg [4:0] process1=5'd0; //use (or reduce
	reg [2:0] process2 = 3'd0; // for round_key
	reg encrypt=1'b0;
	
	reg [3:0] key_round = 4'd1;
	
	//reg [127:0] dec_in_state=128'h3902dc1925dc116a8409850b1dfb9732;
	
	always @(posedge clock)
	begin
		// intial round (add cipher key)
		if(encrypt) begin 
		if(round==4'd0) begin 
			out_state <= in_state^cipher_key; 
			round = round+4'd1;
		end // if(round==4'd0) begin 
		
		
		else if(round<=4'd10) begin 
			in_state <= out_state;
			if(round_process==4'd0) round_process=round_process+4'd1;

			else if(round_process==4'd1) begin // 1. subBytes
				if(process < 5'd16) begin 

		if(in_state[process*8 +: 8] == 8'h00) out_state[process*8 +: 8] <= 8'h63;
    else if(in_state[process*8 +: 8] == 8'h01) out_state[process*8 +: 8] <= 8'h7c;
    else if(in_state[process*8 +: 8] == 8'h02) out_state[process*8 +: 8] <= 8'h77;
    else if(in_state[process*8 +: 8] == 8'h03) out_state[process*8 +: 8] <= 8'h7b;
    else if(in_state[process*8 +: 8] == 8'h04) out_state[process*8 +: 8] <= 8'hf2;
    else if(in_state[process*8 +: 8] == 8'h05) out_state[process*8 +: 8] <= 8'h6b;
    else if(in_state[process*8 +: 8] == 8'h06) out_state[process*8 +: 8] <= 8'h6f;
    else if(in_state[process*8 +: 8] == 8'h07) out_state[process*8 +: 8] <= 8'hc5;
    else if(in_state[process*8 +: 8] == 8'h08) out_state[process*8 +: 8] <= 8'h30;
    else if(in_state[process*8 +: 8] == 8'h09) out_state[process*8 +: 8] <= 8'h01;
    else if(in_state[process*8 +: 8] == 8'h0a) out_state[process*8 +: 8] <= 8'h67;
    else if(in_state[process*8 +: 8] == 8'h0b) out_state[process*8 +: 8] <= 8'h2b;
    else if(in_state[process*8 +: 8] == 8'h0c) out_state[process*8 +: 8] <= 8'hfe;
    else if(in_state[process*8 +: 8] == 8'h0d) out_state[process*8 +: 8] <= 8'hd7;
    else if(in_state[process*8 +: 8] == 8'h0e) out_state[process*8 +: 8] <= 8'hab;
    else if(in_state[process*8 +: 8] == 8'h0f) out_state[process*8 +: 8] <= 8'h76;
    else if(in_state[process*8 +: 8] == 8'h10) out_state[process*8 +: 8] <= 8'hca;
    else if(in_state[process*8 +: 8] == 8'h11) out_state[process*8 +: 8] <= 8'h82;
    else if(in_state[process*8 +: 8] == 8'h12) out_state[process*8 +: 8] <= 8'hc9;
    else if(in_state[process*8 +: 8] == 8'h13) out_state[process*8 +: 8] <= 8'h7d;
    else if(in_state[process*8 +: 8] == 8'h14) out_state[process*8 +: 8] <= 8'hfa;
    else if(in_state[process*8 +: 8] == 8'h15) out_state[process*8 +: 8] <= 8'h59;
    else if(in_state[process*8 +: 8] == 8'h16) out_state[process*8 +: 8] <= 8'h47;
    else if(in_state[process*8 +: 8] == 8'h17) out_state[process*8 +: 8] <= 8'hf0;
    else if(in_state[process*8 +: 8] == 8'h18) out_state[process*8 +: 8] <= 8'had;
    else if(in_state[process*8 +: 8] == 8'h19) out_state[process*8 +: 8] <= 8'hd4;
    else if(in_state[process*8 +: 8] == 8'h1a) out_state[process*8 +: 8] <= 8'ha2;
    else if(in_state[process*8 +: 8] == 8'h1b) out_state[process*8 +: 8] <= 8'haf;
    else if(in_state[process*8 +: 8] == 8'h1c) out_state[process*8 +: 8] <= 8'h9c;
    else if(in_state[process*8 +: 8] == 8'h1d) out_state[process*8 +: 8] <= 8'ha4;
    else if(in_state[process*8 +: 8] == 8'h1e) out_state[process*8 +: 8] <= 8'h72;
    else if(in_state[process*8 +: 8] == 8'h1f) out_state[process*8 +: 8] <= 8'hc0;
    else if(in_state[process*8 +: 8] == 8'h20) out_state[process*8 +: 8] <= 8'hb7;
    else if(in_state[process*8 +: 8] == 8'h21) out_state[process*8 +: 8] <= 8'hfd;
    else if(in_state[process*8 +: 8] == 8'h22) out_state[process*8 +: 8] <= 8'h93;
    else if(in_state[process*8 +: 8] == 8'h23) out_state[process*8 +: 8] <= 8'h26;
    else if(in_state[process*8 +: 8] == 8'h24) out_state[process*8 +: 8] <= 8'h36;
    else if(in_state[process*8 +: 8] == 8'h25) out_state[process*8 +: 8] <= 8'h3f;
    else if(in_state[process*8 +: 8] == 8'h26) out_state[process*8 +: 8] <= 8'hf7;
    else if(in_state[process*8 +: 8] == 8'h27) out_state[process*8 +: 8] <= 8'hcc;
    else if(in_state[process*8 +: 8] == 8'h28) out_state[process*8 +: 8] <= 8'h34;
    else if(in_state[process*8 +: 8] == 8'h29) out_state[process*8 +: 8] <= 8'ha5;
    else if(in_state[process*8 +: 8] == 8'h2a) out_state[process*8 +: 8] <= 8'he5;
    else if(in_state[process*8 +: 8] == 8'h2b) out_state[process*8 +: 8] <= 8'hf1;
    else if(in_state[process*8 +: 8] == 8'h2c) out_state[process*8 +: 8] <= 8'h71;
    else if(in_state[process*8 +: 8] == 8'h2d) out_state[process*8 +: 8] <= 8'hd8;
    else if(in_state[process*8 +: 8] == 8'h2e) out_state[process*8 +: 8] <= 8'h31;
    else if(in_state[process*8 +: 8] == 8'h2f) out_state[process*8 +: 8] <= 8'h15;
    else if(in_state[process*8 +: 8] == 8'h30) out_state[process*8 +: 8] <= 8'h04;
    else if(in_state[process*8 +: 8] == 8'h31) out_state[process*8 +: 8] <= 8'hc7;
    else if(in_state[process*8 +: 8] == 8'h32) out_state[process*8 +: 8] <= 8'h23;
    else if(in_state[process*8 +: 8] == 8'h33) out_state[process*8 +: 8] <= 8'hc3;
    else if(in_state[process*8 +: 8] == 8'h34) out_state[process*8 +: 8] <= 8'h18;
    else if(in_state[process*8 +: 8] == 8'h35) out_state[process*8 +: 8] <= 8'h96;
    else if(in_state[process*8 +: 8] == 8'h36) out_state[process*8 +: 8] <= 8'h05;
    else if(in_state[process*8 +: 8] == 8'h37) out_state[process*8 +: 8] <= 8'h9a;
    else if(in_state[process*8 +: 8] == 8'h38) out_state[process*8 +: 8] <= 8'h07;
    else if(in_state[process*8 +: 8] == 8'h39) out_state[process*8 +: 8] <= 8'h12;
    else if(in_state[process*8 +: 8] == 8'h3a) out_state[process*8 +: 8] <= 8'h80;
    else if(in_state[process*8 +: 8] == 8'h3b) out_state[process*8 +: 8] <= 8'he2;
    else if(in_state[process*8 +: 8] == 8'h3c) out_state[process*8 +: 8] <= 8'heb;
    else if(in_state[process*8 +: 8] == 8'h3d) out_state[process*8 +: 8] <= 8'h27;
    else if(in_state[process*8 +: 8] == 8'h3e) out_state[process*8 +: 8] <= 8'hb2;
    else if(in_state[process*8 +: 8] == 8'h3f) out_state[process*8 +: 8] <= 8'h75;
    else if(in_state[process*8 +: 8] == 8'h40) out_state[process*8 +: 8] <= 8'h09;
    else if(in_state[process*8 +: 8] == 8'h41) out_state[process*8 +: 8] <= 8'h83;
    else if(in_state[process*8 +: 8] == 8'h42) out_state[process*8 +: 8] <= 8'h2c;
    else if(in_state[process*8 +: 8] == 8'h43) out_state[process*8 +: 8] <= 8'h1a;
    else if(in_state[process*8 +: 8] == 8'h44) out_state[process*8 +: 8] <= 8'h1b;
    else if(in_state[process*8 +: 8] == 8'h45) out_state[process*8 +: 8] <= 8'h6e;
    else if(in_state[process*8 +: 8] == 8'h46) out_state[process*8 +: 8] <= 8'h5a;
    else if(in_state[process*8 +: 8] == 8'h47) out_state[process*8 +: 8] <= 8'ha0;
    else if(in_state[process*8 +: 8] == 8'h48) out_state[process*8 +: 8] <= 8'h52;
    else if(in_state[process*8 +: 8] == 8'h49) out_state[process*8 +: 8] <= 8'h3b;
    else if(in_state[process*8 +: 8] == 8'h4a) out_state[process*8 +: 8] <= 8'hd6;
    else if(in_state[process*8 +: 8] == 8'h4b) out_state[process*8 +: 8] <= 8'hb3;
    else if(in_state[process*8 +: 8] == 8'h4c) out_state[process*8 +: 8] <= 8'h29;
    else if(in_state[process*8 +: 8] == 8'h4d) out_state[process*8 +: 8] <= 8'he3;
    else if(in_state[process*8 +: 8] == 8'h4e) out_state[process*8 +: 8] <= 8'h2f;
    else if(in_state[process*8 +: 8] == 8'h4f) out_state[process*8 +: 8] <= 8'h84;
    else if(in_state[process*8 +: 8] == 8'h50) out_state[process*8 +: 8] <= 8'h53;
    else if(in_state[process*8 +: 8] == 8'h51) out_state[process*8 +: 8] <= 8'hd1;
    else if(in_state[process*8 +: 8] == 8'h52) out_state[process*8 +: 8] <= 8'h00;
    else if(in_state[process*8 +: 8] == 8'h53) out_state[process*8 +: 8] <= 8'hed;
    else if(in_state[process*8 +: 8] == 8'h54) out_state[process*8 +: 8] <= 8'h20;
    else if(in_state[process*8 +: 8] == 8'h55) out_state[process*8 +: 8] <= 8'hfc;
    else if(in_state[process*8 +: 8] == 8'h56) out_state[process*8 +: 8] <= 8'hb1;
    else if(in_state[process*8 +: 8] == 8'h57) out_state[process*8 +: 8] <= 8'h5b;
    else if(in_state[process*8 +: 8] == 8'h58) out_state[process*8 +: 8] <= 8'h6a;
    else if(in_state[process*8 +: 8] == 8'h59) out_state[process*8 +: 8] <= 8'hcb;
    else if(in_state[process*8 +: 8] == 8'h5a) out_state[process*8 +: 8] <= 8'hbe;
    else if(in_state[process*8 +: 8] == 8'h5b) out_state[process*8 +: 8] <= 8'h39;
    else if(in_state[process*8 +: 8] == 8'h5c) out_state[process*8 +: 8] <= 8'h4a;
    else if(in_state[process*8 +: 8] == 8'h5d) out_state[process*8 +: 8] <= 8'h4c;
    else if(in_state[process*8 +: 8] == 8'h5e) out_state[process*8 +: 8] <= 8'h58;
    else if(in_state[process*8 +: 8] == 8'h5f) out_state[process*8 +: 8] <= 8'hcf;
    else if(in_state[process*8 +: 8] == 8'h60) out_state[process*8 +: 8] <= 8'hd0;
    else if(in_state[process*8 +: 8] == 8'h61) out_state[process*8 +: 8] <= 8'hef;
    else if(in_state[process*8 +: 8] == 8'h62) out_state[process*8 +: 8] <= 8'haa;
    else if(in_state[process*8 +: 8] == 8'h63) out_state[process*8 +: 8] <= 8'hfb;
    else if(in_state[process*8 +: 8] == 8'h64) out_state[process*8 +: 8] <= 8'h43;
    else if(in_state[process*8 +: 8] == 8'h65) out_state[process*8 +: 8] <= 8'h4d;
    else if(in_state[process*8 +: 8] == 8'h66) out_state[process*8 +: 8] <= 8'h33;
    else if(in_state[process*8 +: 8] == 8'h67) out_state[process*8 +: 8] <= 8'h85;
    else if(in_state[process*8 +: 8] == 8'h68) out_state[process*8 +: 8] <= 8'h45;
    else if(in_state[process*8 +: 8] == 8'h69) out_state[process*8 +: 8] <= 8'hf9;
    else if(in_state[process*8 +: 8] == 8'h6a) out_state[process*8 +: 8] <= 8'h02;
    else if(in_state[process*8 +: 8] == 8'h6b) out_state[process*8 +: 8] <= 8'h7f;
    else if(in_state[process*8 +: 8] == 8'h6c) out_state[process*8 +: 8] <= 8'h50;
    else if(in_state[process*8 +: 8] == 8'h6d) out_state[process*8 +: 8] <= 8'h3c;
    else if(in_state[process*8 +: 8] == 8'h6e) out_state[process*8 +: 8] <= 8'h9f;
    else if(in_state[process*8 +: 8] == 8'h6f) out_state[process*8 +: 8] <= 8'ha8;
    else if(in_state[process*8 +: 8] == 8'h70) out_state[process*8 +: 8] <= 8'h51;
    else if(in_state[process*8 +: 8] == 8'h71) out_state[process*8 +: 8] <= 8'ha3;
    else if(in_state[process*8 +: 8] == 8'h72) out_state[process*8 +: 8] <= 8'h40;
    else if(in_state[process*8 +: 8] == 8'h73) out_state[process*8 +: 8] <= 8'h8f;
    else if(in_state[process*8 +: 8] == 8'h74) out_state[process*8 +: 8] <= 8'h92;
    else if(in_state[process*8 +: 8] == 8'h75) out_state[process*8 +: 8] <= 8'h9d;
    else if(in_state[process*8 +: 8] == 8'h76) out_state[process*8 +: 8] <= 8'h38;
    else if(in_state[process*8 +: 8] == 8'h77) out_state[process*8 +: 8] <= 8'hf5;
    else if(in_state[process*8 +: 8] == 8'h78) out_state[process*8 +: 8] <= 8'hbc;
    else if(in_state[process*8 +: 8] == 8'h79) out_state[process*8 +: 8] <= 8'hb6;
    else if(in_state[process*8 +: 8] == 8'h7a) out_state[process*8 +: 8] <= 8'hda;
    else if(in_state[process*8 +: 8] == 8'h7b) out_state[process*8 +: 8] <= 8'h21;
    else if(in_state[process*8 +: 8] == 8'h7c) out_state[process*8 +: 8] <= 8'h10;
    else if(in_state[process*8 +: 8] == 8'h7d) out_state[process*8 +: 8] <= 8'hff;
    else if(in_state[process*8 +: 8] == 8'h7e) out_state[process*8 +: 8] <= 8'hf3;
    else if(in_state[process*8 +: 8] == 8'h7f) out_state[process*8 +: 8] <= 8'hd2;
    else if(in_state[process*8 +: 8] == 8'h80) out_state[process*8 +: 8] <= 8'hcd;
    else if(in_state[process*8 +: 8] == 8'h81) out_state[process*8 +: 8] <= 8'h0c;
    else if(in_state[process*8 +: 8] == 8'h82) out_state[process*8 +: 8] <= 8'h13;
    else if(in_state[process*8 +: 8] == 8'h83) out_state[process*8 +: 8] <= 8'hec;
    else if(in_state[process*8 +: 8] == 8'h84) out_state[process*8 +: 8] <= 8'h5f;
    else if(in_state[process*8 +: 8] == 8'h85) out_state[process*8 +: 8] <= 8'h97;
    else if(in_state[process*8 +: 8] == 8'h86) out_state[process*8 +: 8] <= 8'h44;
    else if(in_state[process*8 +: 8] == 8'h87) out_state[process*8 +: 8] <= 8'h17;
    else if(in_state[process*8 +: 8] == 8'h88) out_state[process*8 +: 8] <= 8'hc4;
    else if(in_state[process*8 +: 8] == 8'h89) out_state[process*8 +: 8] <= 8'ha7;
    else if(in_state[process*8 +: 8] == 8'h8a) out_state[process*8 +: 8] <= 8'h7e;
    else if(in_state[process*8 +: 8] == 8'h8b) out_state[process*8 +: 8] <= 8'h3d;
    else if(in_state[process*8 +: 8] == 8'h8c) out_state[process*8 +: 8] <= 8'h64;
    else if(in_state[process*8 +: 8] == 8'h8d) out_state[process*8 +: 8] <= 8'h5d;
    else if(in_state[process*8 +: 8] == 8'h8e) out_state[process*8 +: 8] <= 8'h19;
    else if(in_state[process*8 +: 8] == 8'h8f) out_state[process*8 +: 8] <= 8'h73;
    else if(in_state[process*8 +: 8] == 8'h90) out_state[process*8 +: 8] <= 8'h60;
    else if(in_state[process*8 +: 8] == 8'h91) out_state[process*8 +: 8] <= 8'h81;
    else if(in_state[process*8 +: 8] == 8'h92) out_state[process*8 +: 8] <= 8'h4f;
    else if(in_state[process*8 +: 8] == 8'h93) out_state[process*8 +: 8] <= 8'hdc;
    else if(in_state[process*8 +: 8] == 8'h94) out_state[process*8 +: 8] <= 8'h22;
    else if(in_state[process*8 +: 8] == 8'h95) out_state[process*8 +: 8] <= 8'h2a;
    else if(in_state[process*8 +: 8] == 8'h96) out_state[process*8 +: 8] <= 8'h90;
    else if(in_state[process*8 +: 8] == 8'h97) out_state[process*8 +: 8] <= 8'h88;
    else if(in_state[process*8 +: 8] == 8'h98) out_state[process*8 +: 8] <= 8'h46;
    else if(in_state[process*8 +: 8] == 8'h99) out_state[process*8 +: 8] <= 8'hee;
    else if(in_state[process*8 +: 8] == 8'h9a) out_state[process*8 +: 8] <= 8'hb8;
    else if(in_state[process*8 +: 8] == 8'h9b) out_state[process*8 +: 8] <= 8'h14;
    else if(in_state[process*8 +: 8] == 8'h9c) out_state[process*8 +: 8] <= 8'hde;
    else if(in_state[process*8 +: 8] == 8'h9d) out_state[process*8 +: 8] <= 8'h5e;
    else if(in_state[process*8 +: 8] == 8'h9e) out_state[process*8 +: 8] <= 8'h0b;
    else if(in_state[process*8 +: 8] == 8'h9f) out_state[process*8 +: 8] <= 8'hdb;
    else if(in_state[process*8 +: 8] == 8'ha0) out_state[process*8 +: 8] <= 8'he0;
    else if(in_state[process*8 +: 8] == 8'ha1) out_state[process*8 +: 8] <= 8'h32;
    else if(in_state[process*8 +: 8] == 8'ha2) out_state[process*8 +: 8] <= 8'h3a;
    else if(in_state[process*8 +: 8] == 8'ha3) out_state[process*8 +: 8] <= 8'h0a;
    else if(in_state[process*8 +: 8] == 8'ha4) out_state[process*8 +: 8] <= 8'h49;
    else if(in_state[process*8 +: 8] == 8'ha5) out_state[process*8 +: 8] <= 8'h06;
    else if(in_state[process*8 +: 8] == 8'ha6) out_state[process*8 +: 8] <= 8'h24;
    else if(in_state[process*8 +: 8] == 8'ha7) out_state[process*8 +: 8] <= 8'h5c;
    else if(in_state[process*8 +: 8] == 8'ha8) out_state[process*8 +: 8] <= 8'hc2;
    else if(in_state[process*8 +: 8] == 8'ha9) out_state[process*8 +: 8] <= 8'hd3;
    else if(in_state[process*8 +: 8] == 8'haa) out_state[process*8 +: 8] <= 8'hac;
    else if(in_state[process*8 +: 8] == 8'hab) out_state[process*8 +: 8] <= 8'h62;
    else if(in_state[process*8 +: 8] == 8'hac) out_state[process*8 +: 8] <= 8'h91;
    else if(in_state[process*8 +: 8] == 8'had) out_state[process*8 +: 8] <= 8'h95;
    else if(in_state[process*8 +: 8] == 8'hae) out_state[process*8 +: 8] <= 8'he4;
    else if(in_state[process*8 +: 8] == 8'haf) out_state[process*8 +: 8] <= 8'h79;
    else if(in_state[process*8 +: 8] == 8'hb0) out_state[process*8 +: 8] <= 8'he7;
    else if(in_state[process*8 +: 8] == 8'hb1) out_state[process*8 +: 8] <= 8'hc8;
    else if(in_state[process*8 +: 8] == 8'hb2) out_state[process*8 +: 8] <= 8'h37;
    else if(in_state[process*8 +: 8] == 8'hb3) out_state[process*8 +: 8] <= 8'h6d;
    else if(in_state[process*8 +: 8] == 8'hb4) out_state[process*8 +: 8] <= 8'h8d;
    else if(in_state[process*8 +: 8] == 8'hb5) out_state[process*8 +: 8] <= 8'hd5;
    else if(in_state[process*8 +: 8] == 8'hb6) out_state[process*8 +: 8] <= 8'h4e;
    else if(in_state[process*8 +: 8] == 8'hb7) out_state[process*8 +: 8] <= 8'ha9;
    else if(in_state[process*8 +: 8] == 8'hb8) out_state[process*8 +: 8] <= 8'h6c;
    else if(in_state[process*8 +: 8] == 8'hb9) out_state[process*8 +: 8] <= 8'h56;
    else if(in_state[process*8 +: 8] == 8'hba) out_state[process*8 +: 8] <= 8'hf4;
    else if(in_state[process*8 +: 8] == 8'hbb) out_state[process*8 +: 8] <= 8'hea;
    else if(in_state[process*8 +: 8] == 8'hbc) out_state[process*8 +: 8] <= 8'h65;
    else if(in_state[process*8 +: 8] == 8'hbd) out_state[process*8 +: 8] <= 8'h7a;
    else if(in_state[process*8 +: 8] == 8'hbe) out_state[process*8 +: 8] <= 8'hae;
    else if(in_state[process*8 +: 8] == 8'hbf) out_state[process*8 +: 8] <= 8'h08;
    else if(in_state[process*8 +: 8] == 8'hc0) out_state[process*8 +: 8] <= 8'hba;
    else if(in_state[process*8 +: 8] == 8'hc1) out_state[process*8 +: 8] <= 8'h78;
    else if(in_state[process*8 +: 8] == 8'hc2) out_state[process*8 +: 8] <= 8'h25;
    else if(in_state[process*8 +: 8] == 8'hc3) out_state[process*8 +: 8] <= 8'h2e;
    else if(in_state[process*8 +: 8] == 8'hc4) out_state[process*8 +: 8] <= 8'h1c;
    else if(in_state[process*8 +: 8] == 8'hc5) out_state[process*8 +: 8] <= 8'ha6;
    else if(in_state[process*8 +: 8] == 8'hc6) out_state[process*8 +: 8] <= 8'hb4;
    else if(in_state[process*8 +: 8] == 8'hc7) out_state[process*8 +: 8] <= 8'hc6;
    else if(in_state[process*8 +: 8] == 8'hc8) out_state[process*8 +: 8] <= 8'he8;
    else if(in_state[process*8 +: 8] == 8'hc9) out_state[process*8 +: 8] <= 8'hdd;
    else if(in_state[process*8 +: 8] == 8'hca) out_state[process*8 +: 8] <= 8'h74;
    else if(in_state[process*8 +: 8] == 8'hcb) out_state[process*8 +: 8] <= 8'h1f;
    else if(in_state[process*8 +: 8] == 8'hcc) out_state[process*8 +: 8] <= 8'h4b;
    else if(in_state[process*8 +: 8] == 8'hcd) out_state[process*8 +: 8] <= 8'hbd;
    else if(in_state[process*8 +: 8] == 8'hce) out_state[process*8 +: 8] <= 8'h8b;
    else if(in_state[process*8 +: 8] == 8'hcf) out_state[process*8 +: 8] <= 8'h8a;
    else if(in_state[process*8 +: 8] == 8'hd0) out_state[process*8 +: 8] <= 8'h70;
    else if(in_state[process*8 +: 8] == 8'hd1) out_state[process*8 +: 8] <= 8'h3e;
    else if(in_state[process*8 +: 8] == 8'hd2) out_state[process*8 +: 8] <= 8'hb5;
    else if(in_state[process*8 +: 8] == 8'hd3) out_state[process*8 +: 8] <= 8'h66;
    else if(in_state[process*8 +: 8] == 8'hd4) out_state[process*8 +: 8] <= 8'h48;
    else if(in_state[process*8 +: 8] == 8'hd5) out_state[process*8 +: 8] <= 8'h03;
    else if(in_state[process*8 +: 8] == 8'hd6) out_state[process*8 +: 8] <= 8'hf6;
    else if(in_state[process*8 +: 8] == 8'hd7) out_state[process*8 +: 8] <= 8'h0e;
    else if(in_state[process*8 +: 8] == 8'hd8) out_state[process*8 +: 8] <= 8'h61;
    else if(in_state[process*8 +: 8] == 8'hd9) out_state[process*8 +: 8] <= 8'h35;
    else if(in_state[process*8 +: 8] == 8'hda) out_state[process*8 +: 8] <= 8'h57;
    else if(in_state[process*8 +: 8] == 8'hdb) out_state[process*8 +: 8] <= 8'hb9;
    else if(in_state[process*8 +: 8] == 8'hdc) out_state[process*8 +: 8] <= 8'h86;
    else if(in_state[process*8 +: 8] == 8'hdd) out_state[process*8 +: 8] <= 8'hc1;
    else if(in_state[process*8 +: 8] == 8'hde) out_state[process*8 +: 8] <= 8'h1d;
    else if(in_state[process*8 +: 8] == 8'hdf) out_state[process*8 +: 8] <= 8'h9e;
    else if(in_state[process*8 +: 8] == 8'he0) out_state[process*8 +: 8] <= 8'he1;
    else if(in_state[process*8 +: 8] == 8'he1) out_state[process*8 +: 8] <= 8'hf8;
    else if(in_state[process*8 +: 8] == 8'he2) out_state[process*8 +: 8] <= 8'h98;
    else if(in_state[process*8 +: 8] == 8'he3) out_state[process*8 +: 8] <= 8'h11;
    else if(in_state[process*8 +: 8] == 8'he4) out_state[process*8 +: 8] <= 8'h69;
    else if(in_state[process*8 +: 8] == 8'he5) out_state[process*8 +: 8] <= 8'hd9;
    else if(in_state[process*8 +: 8] == 8'he6) out_state[process*8 +: 8] <= 8'h8e;
    else if(in_state[process*8 +: 8] == 8'he7) out_state[process*8 +: 8] <= 8'h94;
    else if(in_state[process*8 +: 8] == 8'he8) out_state[process*8 +: 8] <= 8'h9b;
    else if(in_state[process*8 +: 8] == 8'he9) out_state[process*8 +: 8] <= 8'h1e;
    else if(in_state[process*8 +: 8] == 8'hea) out_state[process*8 +: 8] <= 8'h87;
    else if(in_state[process*8 +: 8] == 8'heb) out_state[process*8 +: 8] <= 8'he9;
    else if(in_state[process*8 +: 8] == 8'hec) out_state[process*8 +: 8] <= 8'hce;
    else if(in_state[process*8 +: 8] == 8'hed) out_state[process*8 +: 8] <= 8'h55;
    else if(in_state[process*8 +: 8] == 8'hee) out_state[process*8 +: 8] <= 8'h28;
    else if(in_state[process*8 +: 8] == 8'hef) out_state[process*8 +: 8] <= 8'hdf;
    else if(in_state[process*8 +: 8] == 8'hf0) out_state[process*8 +: 8] <= 8'h8c;
    else if(in_state[process*8 +: 8] == 8'hf1) out_state[process*8 +: 8] <= 8'ha1;
    else if(in_state[process*8 +: 8] == 8'hf2) out_state[process*8 +: 8] <= 8'h89;
    else if(in_state[process*8 +: 8] == 8'hf3) out_state[process*8 +: 8] <= 8'h0d;
    else if(in_state[process*8 +: 8] == 8'hf4) out_state[process*8 +: 8] <= 8'hbf;
    else if(in_state[process*8 +: 8] == 8'hf5) out_state[process*8 +: 8] <= 8'he6;
    else if(in_state[process*8 +: 8] == 8'hf6) out_state[process*8 +: 8] <= 8'h42;
    else if(in_state[process*8 +: 8] == 8'hf7) out_state[process*8 +: 8] <= 8'h68;
    else if(in_state[process*8 +: 8] == 8'hf8) out_state[process*8 +: 8] <= 8'h41;
    else if(in_state[process*8 +: 8] == 8'hf9) out_state[process*8 +: 8] <= 8'h99;
    else if(in_state[process*8 +: 8] == 8'hfa) out_state[process*8 +: 8] <= 8'h2d;
    else if(in_state[process*8 +: 8] == 8'hfb) out_state[process*8 +: 8] <= 8'h0f;
    else if(in_state[process*8 +: 8] == 8'hfc) out_state[process*8 +: 8] <= 8'hb0;
    else if(in_state[process*8 +: 8] == 8'hfd) out_state[process*8 +: 8] <= 8'h54;
    else if(in_state[process*8 +: 8] == 8'hfe) out_state[process*8 +: 8] <= 8'hbb;
    else if(in_state[process*8 +: 8] == 8'hff) out_state[process*8 +: 8] <= 8'h16;

					
					process = process + 5'd1;
					
					end //if(process < 5'd16) begin 
					else begin 
							round_process=4'd2;
							process = 0;
							in_state <= out_state;
						end //if(process < 5'd16) begin 
				
						end //else if(round_process==4'd1) begin
			else if(round_process==4'd2) begin // 2. shift row
				if(process < 5'd2) begin 
					 out_state[127:96] <= in_state[127:96];
	
					 out_state[95:88] <= in_state[87:80];
					 out_state[87:80] <= in_state[79:72];
					 out_state[79:72] <= in_state[71:64];
					 out_state[71:64] <= in_state[95:88];
	
					 out_state[63:56] <= in_state[47:40];
					 out_state[55:48] <= in_state[39:32];
					 out_state[47:40] <= in_state[63:56];
					 out_state[39:32] <= in_state[55:48];
	
					 out_state[31:24] <= in_state[07:00];
					 out_state[23:16] <= in_state[31:24];
					 out_state[15:08] <= in_state[23:16];
					 out_state[07:00] <= in_state[15:08];
					 
					 process = process + 5'd1;
				end 
				
				else begin process = 0; round_process=4'd3; in_state <= out_state; end 
				
			end //else if(round_process==4'd2)
			
			else if(round_process==4'd3) begin // 3. Mix Columns
				if(round != 10) begin 
					if(process < 5'd4) begin 
						if(process1 ==5'd0) begin 
						if(in_state[(process+12)*8 +: 8] >= 8'b1000_0000) begin 
						//if((in_state[(process+12)*8 +: 8]<<1) & (9'b1_0000_0000) != 0) begin 
							two_A0[7:0] <= ((in_state[(process+12)*8 +: 8]<<1)&(8'b1111_1111))^(8'b0001_1011);
						end
						else begin two_A0[7:0] <= (in_state[(process+12)*8 +: 8]<<1); end 
						
						if(in_state[(process+8)*8 +: 8] >= 8'b1000_0000) begin 
						//if((in_state[(process+8)*8 +: 8]<<1)  & (9'b1_0000_0000) != 0) begin 
							two_A1[7:0] <= ((in_state[(process+8)*8 +: 8]<<1)&(8'b1111_1111))^(8'b0001_1011);
						end
						else begin two_A1[7:0] <= (in_state[(process+8)*8 +: 8]<<1); end 
						
						if(in_state[(process+4)*8 +: 8] >= 8'b1000_0000) begin 
						//if((in_state[(process+4)*8 +: 8]<<1)  & (9'b1_0000_0000) != 0) begin 
							two_A2[7:0] <= ((in_state[(process+4)*8 +: 8]<<1)&(8'b1111_1111))^(8'b0001_1011);
						end
						else begin two_A2[7:0] <= (in_state[(process+4)*8 +: 8]<<1); end 
						
						if(in_state[process*8 +: 8] >= 8'b1000_0000) begin 
						//if((in_state[process*8 +: 8]<<1)  & (9'b1_0000_0000) != 0) begin 
							two_A3[7:0] <= ((in_state[process*8 +: 8]<<1)&(8'b1111_1111))^(8'b0001_1011);
						end
						else begin two_A3[7:0] <= (in_state[process*8 +: 8]<<1); end 
						
						process1 = process1 + 5'd1;
						
						end // if(process1 <5'd1) begin 
						
						else if(process1 == 5'd1) begin 
						three_A0[7:0] <= two_A0[7:0]^in_state[(process+12)*8 +: 8];
						three_A1[7:0] <= two_A1[7:0]^in_state[(process+8)*8 +: 8];
						three_A2[7:0] <= two_A2[7:0]^in_state[(process+4)*8 +: 8];
						three_A3[7:0] <= two_A3[7:0]^in_state[process*8 +: 8];
						process1 = process1 + 5'd1;
						end 
						

						else begin  //process == 2
							out_state[(process+12)*8 +: 8] <= two_A0[7:0]^three_A1[7:0]^in_state[(process+4)*8 +: 8]^in_state[process*8 +: 8];
							out_state[(process+8)*8 +: 8] <= in_state[(process+12)*8 +: 8]^two_A1[7:0]^three_A2[7:0]^in_state[process*8 +: 8];
							out_state[(process+4)*8 +: 8] <= in_state[(process+12)*8 +: 8]^in_state[(process+8)*8 +: 8]^two_A2[7:0]^three_A3[7:0];
							out_state[process*8 +: 8] <= three_A0[7:0]^in_state[(process+8)*8 +: 8]^in_state[(process+4)*8 +: 8]^two_A3[7:0];
							process1 = 5'd0;
							process = process + 5'd1;
						end
						
						
					end // if(process < 5'd4) begin 
			

					else begin 
						round_process=4'd4; in_state <= out_state; process = 0; process1=0;
					end
    			end // round != 10 
    			
    			else begin 
    				round_process = 4'd4; in_state<= out_state; process = 0;process1=0;
    			end
    				
				
			end // else if(round_proces==4'd3) begin // 3. Mix Columns


			else if(round_process==4'd4) begin // 4. Add Round Key
				//if(process < 5'd4) begin
					if(process1 ==5'd0) begin // 4.1 Rotate word
						temp_round[31:24] <= cipher_key[71:64];
						temp_round[23:16] <= cipher_key[39:32];
						temp_round[15:8] <= cipher_key[7:0];
						temp_round[7:0] <= cipher_key[103:96];
						process1 = 5'd1;
						//process2 = 0;
					end // if(process1 == 5'd0)
					
					else if(process1 == 5'd1) begin  // 4.2 sub Bytes
						if(process2 < 3'd4) begin 
	if(temp_round[process2*8 +: 8] == 8'h00) temp_round[process2*8 +: 8] <= 8'h63;
	else if(temp_round[process2*8 +: 8] == 8'h01) temp_round[process2*8 +: 8] <= 8'h7c;
    else if(temp_round[process2*8 +: 8] == 8'h02) temp_round[process2*8 +: 8] <= 8'h77;
    else if(temp_round[process2*8 +: 8] == 8'h03) temp_round[process2*8 +: 8] <= 8'h7b;
    else if(temp_round[process2*8 +: 8] == 8'h04) temp_round[process2*8 +: 8] <= 8'hf2;
    else if(temp_round[process2*8 +: 8] == 8'h05) temp_round[process2*8 +: 8] <= 8'h6b;
    else if(temp_round[process2*8 +: 8] == 8'h06) temp_round[process2*8 +: 8] <= 8'h6f;
    else if(temp_round[process2*8 +: 8] == 8'h07) temp_round[process2*8 +: 8] <= 8'hc5;
    else if(temp_round[process2*8 +: 8] == 8'h08) temp_round[process2*8 +: 8] <= 8'h30;
    else if(temp_round[process2*8 +: 8] == 8'h09) temp_round[process2*8 +: 8] <= 8'h01;
    else if(temp_round[process2*8 +: 8] == 8'h0a) temp_round[process2*8 +: 8] <= 8'h67;
    else if(temp_round[process2*8 +: 8] == 8'h0b) temp_round[process2*8 +: 8] <= 8'h2b;
    else if(temp_round[process2*8 +: 8] == 8'h0c) temp_round[process2*8 +: 8] <= 8'hfe;
    else if(temp_round[process2*8 +: 8] == 8'h0d) temp_round[process2*8 +: 8] <= 8'hd7;
    else if(temp_round[process2*8 +: 8] == 8'h0e) temp_round[process2*8 +: 8] <= 8'hab;
    else if(temp_round[process2*8 +: 8] == 8'h0f) temp_round[process2*8 +: 8] <= 8'h76;
    else if(temp_round[process2*8 +: 8] == 8'h10) temp_round[process2*8 +: 8] <= 8'hca;
    else if(temp_round[process2*8 +: 8] == 8'h11) temp_round[process2*8 +: 8] <= 8'h82;
    else if(temp_round[process2*8 +: 8] == 8'h12) temp_round[process2*8 +: 8] <= 8'hc9;
    else if(temp_round[process2*8 +: 8] == 8'h13) temp_round[process2*8 +: 8] <= 8'h7d;
    else if(temp_round[process2*8 +: 8] == 8'h14) temp_round[process2*8 +: 8] <= 8'hfa;
    else if(temp_round[process2*8 +: 8] == 8'h15) temp_round[process2*8 +: 8] <= 8'h59;
    else if(temp_round[process2*8 +: 8] == 8'h16) temp_round[process2*8 +: 8] <= 8'h47;
    else if(temp_round[process2*8 +: 8] == 8'h17) temp_round[process2*8 +: 8] <= 8'hf0;
    else if(temp_round[process2*8 +: 8] == 8'h18) temp_round[process2*8 +: 8] <= 8'had;
    else if(temp_round[process2*8 +: 8] == 8'h19) temp_round[process2*8 +: 8] <= 8'hd4;
    else if(temp_round[process2*8 +: 8] == 8'h1a) temp_round[process2*8 +: 8] <= 8'ha2;
    else if(temp_round[process2*8 +: 8] == 8'h1b) temp_round[process2*8 +: 8] <= 8'haf;
    else if(temp_round[process2*8 +: 8] == 8'h1c) temp_round[process2*8 +: 8] <= 8'h9c;
    else if(temp_round[process2*8 +: 8] == 8'h1d) temp_round[process2*8 +: 8] <= 8'ha4;
    else if(temp_round[process2*8 +: 8] == 8'h1e) temp_round[process2*8 +: 8] <= 8'h72;
    else if(temp_round[process2*8 +: 8] == 8'h1f) temp_round[process2*8 +: 8] <= 8'hc0;
    else if(temp_round[process2*8 +: 8] == 8'h20) temp_round[process2*8 +: 8] <= 8'hb7;
    else if(temp_round[process2*8 +: 8] == 8'h21) temp_round[process2*8 +: 8] <= 8'hfd;
    else if(temp_round[process2*8 +: 8] == 8'h22) temp_round[process2*8 +: 8] <= 8'h93;
    else if(temp_round[process2*8 +: 8] == 8'h23) temp_round[process2*8 +: 8] <= 8'h26;
    else if(temp_round[process2*8 +: 8] == 8'h24) temp_round[process2*8 +: 8] <= 8'h36;
    else if(temp_round[process2*8 +: 8] == 8'h25) temp_round[process2*8 +: 8] <= 8'h3f;
    else if(temp_round[process2*8 +: 8] == 8'h26) temp_round[process2*8 +: 8] <= 8'hf7;
    else if(temp_round[process2*8 +: 8] == 8'h27) temp_round[process2*8 +: 8] <= 8'hcc;
    else if(temp_round[process2*8 +: 8] == 8'h28) temp_round[process2*8 +: 8] <= 8'h34;
    else if(temp_round[process2*8 +: 8] == 8'h29) temp_round[process2*8 +: 8] <= 8'ha5;
    else if(temp_round[process2*8 +: 8] == 8'h2a) temp_round[process2*8 +: 8] <= 8'he5;
    else if(temp_round[process2*8 +: 8] == 8'h2b) temp_round[process2*8 +: 8] <= 8'hf1;
    else if(temp_round[process2*8 +: 8] == 8'h2c) temp_round[process2*8 +: 8] <= 8'h71;
    else if(temp_round[process2*8 +: 8] == 8'h2d) temp_round[process2*8 +: 8] <= 8'hd8;
    else if(temp_round[process2*8 +: 8] == 8'h2e) temp_round[process2*8 +: 8] <= 8'h31;
    else if(temp_round[process2*8 +: 8] == 8'h2f) temp_round[process2*8 +: 8] <= 8'h15;
    else if(temp_round[process2*8 +: 8] == 8'h30) temp_round[process2*8 +: 8] <= 8'h04;
    else if(temp_round[process2*8 +: 8] == 8'h31) temp_round[process2*8 +: 8] <= 8'hc7;
    else if(temp_round[process2*8 +: 8] == 8'h32) temp_round[process2*8 +: 8] <= 8'h23;
    else if(temp_round[process2*8 +: 8] == 8'h33) temp_round[process2*8 +: 8] <= 8'hc3;
    else if(temp_round[process2*8 +: 8] == 8'h34) temp_round[process2*8 +: 8] <= 8'h18;
    else if(temp_round[process2*8 +: 8] == 8'h35) temp_round[process2*8 +: 8] <= 8'h96;
    else if(temp_round[process2*8 +: 8] == 8'h36) temp_round[process2*8 +: 8] <= 8'h05;
    else if(temp_round[process2*8 +: 8] == 8'h37) temp_round[process2*8 +: 8] <= 8'h9a;
    else if(temp_round[process2*8 +: 8] == 8'h38) temp_round[process2*8 +: 8] <= 8'h07;
    else if(temp_round[process2*8 +: 8] == 8'h39) temp_round[process2*8 +: 8] <= 8'h12;
    else if(temp_round[process2*8 +: 8] == 8'h3a) temp_round[process2*8 +: 8] <= 8'h80;
    else if(temp_round[process2*8 +: 8] == 8'h3b) temp_round[process2*8 +: 8] <= 8'he2;
    else if(temp_round[process2*8 +: 8] == 8'h3c) temp_round[process2*8 +: 8] <= 8'heb;
    else if(temp_round[process2*8 +: 8] == 8'h3d) temp_round[process2*8 +: 8] <= 8'h27;
    else if(temp_round[process2*8 +: 8] == 8'h3e) temp_round[process2*8 +: 8] <= 8'hb2;
    else if(temp_round[process2*8 +: 8] == 8'h3f) temp_round[process2*8 +: 8] <= 8'h75;
    else if(temp_round[process2*8 +: 8] == 8'h40) temp_round[process2*8 +: 8] <= 8'h09;
    else if(temp_round[process2*8 +: 8] == 8'h41) temp_round[process2*8 +: 8] <= 8'h83;
    else if(temp_round[process2*8 +: 8] == 8'h42) temp_round[process2*8 +: 8] <= 8'h2c;
    else if(temp_round[process2*8 +: 8] == 8'h43) temp_round[process2*8 +: 8] <= 8'h1a;
    else if(temp_round[process2*8 +: 8] == 8'h44) temp_round[process2*8 +: 8] <= 8'h1b;
    else if(temp_round[process2*8 +: 8] == 8'h45) temp_round[process2*8 +: 8] <= 8'h6e;
    else if(temp_round[process2*8 +: 8] == 8'h46) temp_round[process2*8 +: 8] <= 8'h5a;
    else if(temp_round[process2*8 +: 8] == 8'h47) temp_round[process2*8 +: 8] <= 8'ha0;
    else if(temp_round[process2*8 +: 8] == 8'h48) temp_round[process2*8 +: 8] <= 8'h52;
    else if(temp_round[process2*8 +: 8] == 8'h49) temp_round[process2*8 +: 8] <= 8'h3b;
    else if(temp_round[process2*8 +: 8] == 8'h4a) temp_round[process2*8 +: 8] <= 8'hd6;
    else if(temp_round[process2*8 +: 8] == 8'h4b) temp_round[process2*8 +: 8] <= 8'hb3;
    else if(temp_round[process2*8 +: 8] == 8'h4c) temp_round[process2*8 +: 8] <= 8'h29;
    else if(temp_round[process2*8 +: 8] == 8'h4d) temp_round[process2*8 +: 8] <= 8'he3;
    else if(temp_round[process2*8 +: 8] == 8'h4e) temp_round[process2*8 +: 8] <= 8'h2f;
    else if(temp_round[process2*8 +: 8] == 8'h4f) temp_round[process2*8 +: 8] <= 8'h84;
    else if(temp_round[process2*8 +: 8] == 8'h50) temp_round[process2*8 +: 8] <= 8'h53;
    else if(temp_round[process2*8 +: 8] == 8'h51) temp_round[process2*8 +: 8] <= 8'hd1;
    else if(temp_round[process2*8 +: 8] == 8'h52) temp_round[process2*8 +: 8] <= 8'h00;
    else if(temp_round[process2*8 +: 8] == 8'h53) temp_round[process2*8 +: 8] <= 8'hed;
    else if(temp_round[process2*8 +: 8] == 8'h54) temp_round[process2*8 +: 8] <= 8'h20;
    else if(temp_round[process2*8 +: 8] == 8'h55) temp_round[process2*8 +: 8] <= 8'hfc;
    else if(temp_round[process2*8 +: 8] == 8'h56) temp_round[process2*8 +: 8] <= 8'hb1;
    else if(temp_round[process2*8 +: 8] == 8'h57) temp_round[process2*8 +: 8] <= 8'h5b;
    else if(temp_round[process2*8 +: 8] == 8'h58) temp_round[process2*8 +: 8] <= 8'h6a;
    else if(temp_round[process2*8 +: 8] == 8'h59) temp_round[process2*8 +: 8] <= 8'hcb;
    else if(temp_round[process2*8 +: 8] == 8'h5a) temp_round[process2*8 +: 8] <= 8'hbe;
    else if(temp_round[process2*8 +: 8] == 8'h5b) temp_round[process2*8 +: 8] <= 8'h39;
    else if(temp_round[process2*8 +: 8] == 8'h5c) temp_round[process2*8 +: 8] <= 8'h4a;
    else if(temp_round[process2*8 +: 8] == 8'h5d) temp_round[process2*8 +: 8] <= 8'h4c;
    else if(temp_round[process2*8 +: 8] == 8'h5e) temp_round[process2*8 +: 8] <= 8'h58;
    else if(temp_round[process2*8 +: 8] == 8'h5f) temp_round[process2*8 +: 8] <= 8'hcf;
    else if(temp_round[process2*8 +: 8] == 8'h60) temp_round[process2*8 +: 8] <= 8'hd0;
    else if(temp_round[process2*8 +: 8] == 8'h61) temp_round[process2*8 +: 8] <= 8'hef;
    else if(temp_round[process2*8 +: 8] == 8'h62) temp_round[process2*8 +: 8] <= 8'haa;
    else if(temp_round[process2*8 +: 8] == 8'h63) temp_round[process2*8 +: 8] <= 8'hfb;
    else if(temp_round[process2*8 +: 8] == 8'h64) temp_round[process2*8 +: 8] <= 8'h43;
    else if(temp_round[process2*8 +: 8] == 8'h65) temp_round[process2*8 +: 8] <= 8'h4d;
    else if(temp_round[process2*8 +: 8] == 8'h66) temp_round[process2*8 +: 8] <= 8'h33;
    else if(temp_round[process2*8 +: 8] == 8'h67) temp_round[process2*8 +: 8] <= 8'h85;
    else if(temp_round[process2*8 +: 8] == 8'h68) temp_round[process2*8 +: 8] <= 8'h45;
    else if(temp_round[process2*8 +: 8] == 8'h69) temp_round[process2*8 +: 8] <= 8'hf9;
    else if(temp_round[process2*8 +: 8] == 8'h6a) temp_round[process2*8 +: 8] <= 8'h02;
    else if(temp_round[process2*8 +: 8] == 8'h6b) temp_round[process2*8 +: 8] <= 8'h7f;
    else if(temp_round[process2*8 +: 8] == 8'h6c) temp_round[process2*8 +: 8] <= 8'h50;
    else if(temp_round[process2*8 +: 8] == 8'h6d) temp_round[process2*8 +: 8] <= 8'h3c;
    else if(temp_round[process2*8 +: 8] == 8'h6e) temp_round[process2*8 +: 8] <= 8'h9f;
    else if(temp_round[process2*8 +: 8] == 8'h6f) temp_round[process2*8 +: 8] <= 8'ha8;
    else if(temp_round[process2*8 +: 8] == 8'h70) temp_round[process2*8 +: 8] <= 8'h51;
    else if(temp_round[process2*8 +: 8] == 8'h71) temp_round[process2*8 +: 8] <= 8'ha3;
    else if(temp_round[process2*8 +: 8] == 8'h72) temp_round[process2*8 +: 8] <= 8'h40;
    else if(temp_round[process2*8 +: 8] == 8'h73) temp_round[process2*8 +: 8] <= 8'h8f;
    else if(temp_round[process2*8 +: 8] == 8'h74) temp_round[process2*8 +: 8] <= 8'h92;
    else if(temp_round[process2*8 +: 8] == 8'h75) temp_round[process2*8 +: 8] <= 8'h9d;
    else if(temp_round[process2*8 +: 8] == 8'h76) temp_round[process2*8 +: 8] <= 8'h38;
    else if(temp_round[process2*8 +: 8] == 8'h77) temp_round[process2*8 +: 8] <= 8'hf5;
    else if(temp_round[process2*8 +: 8] == 8'h78) temp_round[process2*8 +: 8] <= 8'hbc;
    else if(temp_round[process2*8 +: 8] == 8'h79) temp_round[process2*8 +: 8] <= 8'hb6;
    else if(temp_round[process2*8 +: 8] == 8'h7a) temp_round[process2*8 +: 8] <= 8'hda;
    else if(temp_round[process2*8 +: 8] == 8'h7b) temp_round[process2*8 +: 8] <= 8'h21;
    else if(temp_round[process2*8 +: 8] == 8'h7c) temp_round[process2*8 +: 8] <= 8'h10;
    else if(temp_round[process2*8 +: 8] == 8'h7d) temp_round[process2*8 +: 8] <= 8'hff;
    else if(temp_round[process2*8 +: 8] == 8'h7e) temp_round[process2*8 +: 8] <= 8'hf3;
    else if(temp_round[process2*8 +: 8] == 8'h7f) temp_round[process2*8 +: 8] <= 8'hd2;
    else if(temp_round[process2*8 +: 8] == 8'h80) temp_round[process2*8 +: 8] <= 8'hcd;
    else if(temp_round[process2*8 +: 8] == 8'h81) temp_round[process2*8 +: 8] <= 8'h0c;
    else if(temp_round[process2*8 +: 8] == 8'h82) temp_round[process2*8 +: 8] <= 8'h13;
    else if(temp_round[process2*8 +: 8] == 8'h83) temp_round[process2*8 +: 8] <= 8'hec;
    else if(temp_round[process2*8 +: 8] == 8'h84) temp_round[process2*8 +: 8] <= 8'h5f;
    else if(temp_round[process2*8 +: 8] == 8'h85) temp_round[process2*8 +: 8] <= 8'h97;
    else if(temp_round[process2*8 +: 8] == 8'h86) temp_round[process2*8 +: 8] <= 8'h44;
    else if(temp_round[process2*8 +: 8] == 8'h87) temp_round[process2*8 +: 8] <= 8'h17;
    else if(temp_round[process2*8 +: 8] == 8'h88) temp_round[process2*8 +: 8] <= 8'hc4;
    else if(temp_round[process2*8 +: 8] == 8'h89) temp_round[process2*8 +: 8] <= 8'ha7;
    else if(temp_round[process2*8 +: 8] == 8'h8a) temp_round[process2*8 +: 8] <= 8'h7e;
    else if(temp_round[process2*8 +: 8] == 8'h8b) temp_round[process2*8 +: 8] <= 8'h3d;
    else if(temp_round[process2*8 +: 8] == 8'h8c) temp_round[process2*8 +: 8] <= 8'h64;
    else if(temp_round[process2*8 +: 8] == 8'h8d) temp_round[process2*8 +: 8] <= 8'h5d;
    else if(temp_round[process2*8 +: 8] == 8'h8e) temp_round[process2*8 +: 8] <= 8'h19;
    else if(temp_round[process2*8 +: 8] == 8'h8f) temp_round[process2*8 +: 8] <= 8'h73;
    else if(temp_round[process2*8 +: 8] == 8'h90) temp_round[process2*8 +: 8] <= 8'h60;
    else if(temp_round[process2*8 +: 8] == 8'h91) temp_round[process2*8 +: 8] <= 8'h81;
    else if(temp_round[process2*8 +: 8] == 8'h92) temp_round[process2*8 +: 8] <= 8'h4f;
    else if(temp_round[process2*8 +: 8] == 8'h93) temp_round[process2*8 +: 8] <= 8'hdc;
    else if(temp_round[process2*8 +: 8] == 8'h94) temp_round[process2*8 +: 8] <= 8'h22;
    else if(temp_round[process2*8 +: 8] == 8'h95) temp_round[process2*8 +: 8] <= 8'h2a;
    else if(temp_round[process2*8 +: 8] == 8'h96) temp_round[process2*8 +: 8] <= 8'h90;
    else if(temp_round[process2*8 +: 8] == 8'h97) temp_round[process2*8 +: 8] <= 8'h88;
    else if(temp_round[process2*8 +: 8] == 8'h98) temp_round[process2*8 +: 8] <= 8'h46;
    else if(temp_round[process2*8 +: 8] == 8'h99) temp_round[process2*8 +: 8] <= 8'hee;
    else if(temp_round[process2*8 +: 8] == 8'h9a) temp_round[process2*8 +: 8] <= 8'hb8;
    else if(temp_round[process2*8 +: 8] == 8'h9b) temp_round[process2*8 +: 8] <= 8'h14;
    else if(temp_round[process2*8 +: 8] == 8'h9c) temp_round[process2*8 +: 8] <= 8'hde;
    else if(temp_round[process2*8 +: 8] == 8'h9d) temp_round[process2*8 +: 8] <= 8'h5e;
    else if(temp_round[process2*8 +: 8] == 8'h9e) temp_round[process2*8 +: 8] <= 8'h0b;
    else if(temp_round[process2*8 +: 8] == 8'h9f) temp_round[process2*8 +: 8] <= 8'hdb;
    else if(temp_round[process2*8 +: 8] == 8'ha0) temp_round[process2*8 +: 8] <= 8'he0;
    else if(temp_round[process2*8 +: 8] == 8'ha1) temp_round[process2*8 +: 8] <= 8'h32;
    else if(temp_round[process2*8 +: 8] == 8'ha2) temp_round[process2*8 +: 8] <= 8'h3a;
    else if(temp_round[process2*8 +: 8] == 8'ha3) temp_round[process2*8 +: 8] <= 8'h0a;
    else if(temp_round[process2*8 +: 8] == 8'ha4) temp_round[process2*8 +: 8] <= 8'h49;
    else if(temp_round[process2*8 +: 8] == 8'ha5) temp_round[process2*8 +: 8] <= 8'h06;
    else if(temp_round[process2*8 +: 8] == 8'ha6) temp_round[process2*8 +: 8] <= 8'h24;
    else if(temp_round[process2*8 +: 8] == 8'ha7) temp_round[process2*8 +: 8] <= 8'h5c;
    else if(temp_round[process2*8 +: 8] == 8'ha8) temp_round[process2*8 +: 8] <= 8'hc2;
    else if(temp_round[process2*8 +: 8] == 8'ha9) temp_round[process2*8 +: 8] <= 8'hd3;
    else if(temp_round[process2*8 +: 8] == 8'haa) temp_round[process2*8 +: 8] <= 8'hac;
    else if(temp_round[process2*8 +: 8] == 8'hab) temp_round[process2*8 +: 8] <= 8'h62;
    else if(temp_round[process2*8 +: 8] == 8'hac) temp_round[process2*8 +: 8] <= 8'h91;
    else if(temp_round[process2*8 +: 8] == 8'had) temp_round[process2*8 +: 8] <= 8'h95;
    else if(temp_round[process2*8 +: 8] == 8'hae) temp_round[process2*8 +: 8] <= 8'he4;
    else if(temp_round[process2*8 +: 8] == 8'haf) temp_round[process2*8 +: 8] <= 8'h79;
    else if(temp_round[process2*8 +: 8] == 8'hb0) temp_round[process2*8 +: 8] <= 8'he7;
    else if(temp_round[process2*8 +: 8] == 8'hb1) temp_round[process2*8 +: 8] <= 8'hc8;
    else if(temp_round[process2*8 +: 8] == 8'hb2) temp_round[process2*8 +: 8] <= 8'h37;
    else if(temp_round[process2*8 +: 8] == 8'hb3) temp_round[process2*8 +: 8] <= 8'h6d;
    else if(temp_round[process2*8 +: 8] == 8'hb4) temp_round[process2*8 +: 8] <= 8'h8d;
    else if(temp_round[process2*8 +: 8] == 8'hb5) temp_round[process2*8 +: 8] <= 8'hd5;
    else if(temp_round[process2*8 +: 8] == 8'hb6) temp_round[process2*8 +: 8] <= 8'h4e;
    else if(temp_round[process2*8 +: 8] == 8'hb7) temp_round[process2*8 +: 8] <= 8'ha9;
    else if(temp_round[process2*8 +: 8] == 8'hb8) temp_round[process2*8 +: 8] <= 8'h6c;
    else if(temp_round[process2*8 +: 8] == 8'hb9) temp_round[process2*8 +: 8] <= 8'h56;
    else if(temp_round[process2*8 +: 8] == 8'hba) temp_round[process2*8 +: 8] <= 8'hf4;
    else if(temp_round[process2*8 +: 8] == 8'hbb) temp_round[process2*8 +: 8] <= 8'hea;
    else if(temp_round[process2*8 +: 8] == 8'hbc) temp_round[process2*8 +: 8] <= 8'h65;
    else if(temp_round[process2*8 +: 8] == 8'hbd) temp_round[process2*8 +: 8] <= 8'h7a;
    else if(temp_round[process2*8 +: 8] == 8'hbe) temp_round[process2*8 +: 8] <= 8'hae;
    else if(temp_round[process2*8 +: 8] == 8'hbf) temp_round[process2*8 +: 8] <= 8'h08;
    else if(temp_round[process2*8 +: 8] == 8'hc0) temp_round[process2*8 +: 8] <= 8'hba;
    else if(temp_round[process2*8 +: 8] == 8'hc1) temp_round[process2*8 +: 8] <= 8'h78;
    else if(temp_round[process2*8 +: 8] == 8'hc2) temp_round[process2*8 +: 8] <= 8'h25;
    else if(temp_round[process2*8 +: 8] == 8'hc3) temp_round[process2*8 +: 8] <= 8'h2e;
    else if(temp_round[process2*8 +: 8] == 8'hc4) temp_round[process2*8 +: 8] <= 8'h1c;
    else if(temp_round[process2*8 +: 8] == 8'hc5) temp_round[process2*8 +: 8] <= 8'ha6;
    else if(temp_round[process2*8 +: 8] == 8'hc6) temp_round[process2*8 +: 8] <= 8'hb4;
    else if(temp_round[process2*8 +: 8] == 8'hc7) temp_round[process2*8 +: 8] <= 8'hc6;
    else if(temp_round[process2*8 +: 8] == 8'hc8) temp_round[process2*8 +: 8] <= 8'he8;
    else if(temp_round[process2*8 +: 8] == 8'hc9) temp_round[process2*8 +: 8] <= 8'hdd;
    else if(temp_round[process2*8 +: 8] == 8'hca) temp_round[process2*8 +: 8] <= 8'h74;
    else if(temp_round[process2*8 +: 8] == 8'hcb) temp_round[process2*8 +: 8] <= 8'h1f;
    else if(temp_round[process2*8 +: 8] == 8'hcc) temp_round[process2*8 +: 8] <= 8'h4b;
    else if(temp_round[process2*8 +: 8] == 8'hcd) temp_round[process2*8 +: 8] <= 8'hbd;
    else if(temp_round[process2*8 +: 8] == 8'hce) temp_round[process2*8 +: 8] <= 8'h8b;
    else if(temp_round[process2*8 +: 8] == 8'hcf) temp_round[process2*8 +: 8] <= 8'h8a;
    else if(temp_round[process2*8 +: 8] == 8'hd0) temp_round[process2*8 +: 8] <= 8'h70;
    else if(temp_round[process2*8 +: 8] == 8'hd1) temp_round[process2*8 +: 8] <= 8'h3e;
    else if(temp_round[process2*8 +: 8] == 8'hd2) temp_round[process2*8 +: 8] <= 8'hb5;
    else if(temp_round[process2*8 +: 8] == 8'hd3) temp_round[process2*8 +: 8] <= 8'h66;
    else if(temp_round[process2*8 +: 8] == 8'hd4) temp_round[process2*8 +: 8] <= 8'h48;
    else if(temp_round[process2*8 +: 8] == 8'hd5) temp_round[process2*8 +: 8] <= 8'h03;
    else if(temp_round[process2*8 +: 8] == 8'hd6) temp_round[process2*8 +: 8] <= 8'hf6;
    else if(temp_round[process2*8 +: 8] == 8'hd7) temp_round[process2*8 +: 8] <= 8'h0e;
    else if(temp_round[process2*8 +: 8] == 8'hd8) temp_round[process2*8 +: 8] <= 8'h61;
    else if(temp_round[process2*8 +: 8] == 8'hd9) temp_round[process2*8 +: 8] <= 8'h35;
    else if(temp_round[process2*8 +: 8] == 8'hda) temp_round[process2*8 +: 8] <= 8'h57;
    else if(temp_round[process2*8 +: 8] == 8'hdb) temp_round[process2*8 +: 8] <= 8'hb9;
    else if(temp_round[process2*8 +: 8] == 8'hdc) temp_round[process2*8 +: 8] <= 8'h86;
    else if(temp_round[process2*8 +: 8] == 8'hdd) temp_round[process2*8 +: 8] <= 8'hc1;
    else if(temp_round[process2*8 +: 8] == 8'hde) temp_round[process2*8 +: 8] <= 8'h1d;
    else if(temp_round[process2*8 +: 8] == 8'hdf) temp_round[process2*8 +: 8] <= 8'h9e;
    else if(temp_round[process2*8 +: 8] == 8'he0) temp_round[process2*8 +: 8] <= 8'he1;
    else if(temp_round[process2*8 +: 8] == 8'he1) temp_round[process2*8 +: 8] <= 8'hf8;
    else if(temp_round[process2*8 +: 8] == 8'he2) temp_round[process2*8 +: 8] <= 8'h98;
    else if(temp_round[process2*8 +: 8] == 8'he3) temp_round[process2*8 +: 8] <= 8'h11;
    else if(temp_round[process2*8 +: 8] == 8'he4) temp_round[process2*8 +: 8] <= 8'h69;
    else if(temp_round[process2*8 +: 8] == 8'he5) temp_round[process2*8 +: 8] <= 8'hd9;
    else if(temp_round[process2*8 +: 8] == 8'he6) temp_round[process2*8 +: 8] <= 8'h8e;
    else if(temp_round[process2*8 +: 8] == 8'he7) temp_round[process2*8 +: 8] <= 8'h94;
    else if(temp_round[process2*8 +: 8] == 8'he8) temp_round[process2*8 +: 8] <= 8'h9b;
    else if(temp_round[process2*8 +: 8] == 8'he9) temp_round[process2*8 +: 8] <= 8'h1e;
    else if(temp_round[process2*8 +: 8] == 8'hea) temp_round[process2*8 +: 8] <= 8'h87;
    else if(temp_round[process2*8 +: 8] == 8'heb) temp_round[process2*8 +: 8] <= 8'he9;
    else if(temp_round[process2*8 +: 8] == 8'hec) temp_round[process2*8 +: 8] <= 8'hce;
    else if(temp_round[process2*8 +: 8] == 8'hed) temp_round[process2*8 +: 8] <= 8'h55;
    else if(temp_round[process2*8 +: 8] == 8'hee) temp_round[process2*8 +: 8] <= 8'h28;
    else if(temp_round[process2*8 +: 8] == 8'hef) temp_round[process2*8 +: 8] <= 8'hdf;
    else if(temp_round[process2*8 +: 8] == 8'hf0) temp_round[process2*8 +: 8] <= 8'h8c;
    else if(temp_round[process2*8 +: 8] == 8'hf1) temp_round[process2*8 +: 8] <= 8'ha1;
    else if(temp_round[process2*8 +: 8] == 8'hf2) temp_round[process2*8 +: 8] <= 8'h89;
    else if(temp_round[process2*8 +: 8] == 8'hf3) temp_round[process2*8 +: 8] <= 8'h0d;
    else if(temp_round[process2*8 +: 8] == 8'hf4) temp_round[process2*8 +: 8] <= 8'hbf;
    else if(temp_round[process2*8 +: 8] == 8'hf5) temp_round[process2*8 +: 8] <= 8'he6;
    else if(temp_round[process2*8 +: 8] == 8'hf6) temp_round[process2*8 +: 8] <= 8'h42;
    else if(temp_round[process2*8 +: 8] == 8'hf7) temp_round[process2*8 +: 8] <= 8'h68;
    else if(temp_round[process2*8 +: 8] == 8'hf8) temp_round[process2*8 +: 8] <= 8'h41;
    else if(temp_round[process2*8 +: 8] == 8'hf9) temp_round[process2*8 +: 8] <= 8'h99;
    else if(temp_round[process2*8 +: 8] == 8'hfa) temp_round[process2*8 +: 8] <= 8'h2d;
    else if(temp_round[process2*8 +: 8] == 8'hfb) temp_round[process2*8 +: 8] <= 8'h0f;
    else if(temp_round[process2*8 +: 8] == 8'hfc) temp_round[process2*8 +: 8] <= 8'hb0;
    else if(temp_round[process2*8 +: 8] == 8'hfd) temp_round[process2*8 +: 8] <= 8'h54;
    else if(temp_round[process2*8 +: 8] == 8'hfe) temp_round[process2*8 +: 8] <= 8'hbb;
    else if(temp_round[process2*8 +: 8] == 8'hff) temp_round[process2*8 +: 8] <= 8'h16;
							

							process2 = process2 + 3'd1;
							end // if(process2 <= 2'd3) begin 
						else begin // if(process2 <= 2'd3) begin 
							process1 = 5'd2;
						end 
						
					end // else begin if(process2 <= 2'd3) 
					
					else if(process1 == 5'd2) begin // 4.3 add Rcon and make 1'
						
						
						if(round==4'd1) r_con[7:0] = 8'h01;
						else if(round==4'd2) r_con[7:0] = 8'h02;
						else if(round==4'd3) r_con[7:0] = 8'h04;
						else if(round==4'd4) r_con[7:0] = 8'h08;
						else if(round==4'd5) r_con[7:0] = 8'h10;
						else if(round==4'd6) r_con[7:0] = 8'h20;
						else if(round==4'd7) r_con[7:0] = 8'h40;
						else if(round==4'd8) r_con[7:0] = 8'h80;
						else if(round==4'd9) r_con[7:0] = 8'h1b;
						else if(round==4'd10) r_con[7:0] = 8'h36;
						else begin end 
							
						round_key[127:120] <= cipher_key[127:120]^temp_round[31:24]^r_con[7:0];
						round_key[95:88] <= cipher_key[95:88]^temp_round[23:16]^8'h00;
						round_key[63:56] <= cipher_key[63:56]^temp_round[15:8]^8'h00;
						round_key[31:24] <= cipher_key[31:24]^temp_round[7:0]^8'h00;
						
						process1 =5'd3;
					end
					
					else if(process1 == 5'd3) begin // 4.4 2' = 2+1'
						round_key[119:112] <= cipher_key[119:112]^round_key[127:120];
						round_key[87:80] <= cipher_key[87:80]^round_key[95:88];
						round_key[55:48] <= cipher_key[55:48]^round_key[63:56];
						round_key[23:16] <= cipher_key[23:16]^round_key[31:24];
						
						process1 = 5'd4;
					end 
					
					else if(process1 == 5'd4) begin // 4.5 3' = 3+2'
						round_key[111:104] <= cipher_key[111:104]^round_key[119:112];
						round_key[79:72] <= cipher_key[79:72]^round_key[87:80];
						round_key[47:40] <= cipher_key[47:40]^round_key[55:48];
						round_key[15:08] <= cipher_key[15:08]^round_key[23:16];
						
						process1 = 5'd5;
					end
					
					else if(process1 == 5'd5) begin // 4.6 4' = 4+3'
						round_key[103:96] <= cipher_key[103:96]^round_key[111:104];
						round_key[71:64] <= cipher_key[71:64]^round_key[79:72];
						round_key[39:32] <= cipher_key[39:32]^round_key[47:40];
						round_key[7:0] <= cipher_key[7:0]^round_key[15:08];
						
						process1 = 5'd6;
					end
					
					else if(process1 == 5'd6) begin // add round key
						out_state <= in_state ^ round_key;
						cipher_key <= round_key;
						process1 = 5'd7;
					end 
					
					else begin // process1 = 5'd7 
							round_process = round_process + 4'd1;
							in_state <= out_state;
					end 
					
					
				//end  // if(process < 5'd4)
				
				//else begin //else (process)
					
				//end
				end  //else if(round_process=4'd4) 
				
			else begin 
				round = round +  4'd1; 
				round_process <= 0;
				process <= 0;
				process1 <= 0;
				process2 <= 0;
				
			end  	//if(round_process==4'd1) begin
				
		end // if(round==4'd1) begin 
		
		else begin //round>10
			final_state<=out_state;
		end 
		end

//	end // always @(posedge clock)
	

//always @(posedge clock)
//	begin
		else if(!encrypt) begin // If Decrypt mode
			if(round<=4'd9) begin // decrypt round 0 to 9
				/* If round is 0 -> except INV MixColumn */
				if(round_process == 4'd0) begin // If new round , reset cipher key
					/* Initial cipher key */
					cipher_key <= initial_cipher_key;
					round_process = 4'd1; // go to next round_process (4.Add Round Key)
				end //if(round_process ==4'd0)
				
				else if(round_process == 4'd1) begin // 4. Add Round Key
					/* 4. Add Round Key */
					if(key_round <= 4'd10-round) begin // repeat (10-round)times
						if(process1 ==5'd0) begin // 4.1 Rotate word
							temp_round[31:24] <= cipher_key[71:64];
							temp_round[23:16] <= cipher_key[39:32];
							temp_round[15:8] <= cipher_key[7:0];
							temp_round[7:0] <= cipher_key[103:96];
							process1 = 5'd1;
						end // if(process1 == 5'd0)
						
						else if(process1 == 5'd1) begin  // 4.2 sub Bytes
							if(process2 < 3'd4) begin 
								
	if(temp_round[process2*8 +: 8] == 8'h00) temp_round[process2*8 +: 8] <= 8'h63;
	else if(temp_round[process2*8 +: 8] == 8'h01) temp_round[process2*8 +: 8] <= 8'h7c;
    else if(temp_round[process2*8 +: 8] == 8'h02) temp_round[process2*8 +: 8] <= 8'h77;
    else if(temp_round[process2*8 +: 8] == 8'h03) temp_round[process2*8 +: 8] <= 8'h7b;
    else if(temp_round[process2*8 +: 8] == 8'h04) temp_round[process2*8 +: 8] <= 8'hf2;
    else if(temp_round[process2*8 +: 8] == 8'h05) temp_round[process2*8 +: 8] <= 8'h6b;
    else if(temp_round[process2*8 +: 8] == 8'h06) temp_round[process2*8 +: 8] <= 8'h6f;
    else if(temp_round[process2*8 +: 8] == 8'h07) temp_round[process2*8 +: 8] <= 8'hc5;
    else if(temp_round[process2*8 +: 8] == 8'h08) temp_round[process2*8 +: 8] <= 8'h30;
    else if(temp_round[process2*8 +: 8] == 8'h09) temp_round[process2*8 +: 8] <= 8'h01;
    else if(temp_round[process2*8 +: 8] == 8'h0a) temp_round[process2*8 +: 8] <= 8'h67;
    else if(temp_round[process2*8 +: 8] == 8'h0b) temp_round[process2*8 +: 8] <= 8'h2b;
    else if(temp_round[process2*8 +: 8] == 8'h0c) temp_round[process2*8 +: 8] <= 8'hfe;
    else if(temp_round[process2*8 +: 8] == 8'h0d) temp_round[process2*8 +: 8] <= 8'hd7;
    else if(temp_round[process2*8 +: 8] == 8'h0e) temp_round[process2*8 +: 8] <= 8'hab;
    else if(temp_round[process2*8 +: 8] == 8'h0f) temp_round[process2*8 +: 8] <= 8'h76;
    else if(temp_round[process2*8 +: 8] == 8'h10) temp_round[process2*8 +: 8] <= 8'hca;
    else if(temp_round[process2*8 +: 8] == 8'h11) temp_round[process2*8 +: 8] <= 8'h82;
    else if(temp_round[process2*8 +: 8] == 8'h12) temp_round[process2*8 +: 8] <= 8'hc9;
    else if(temp_round[process2*8 +: 8] == 8'h13) temp_round[process2*8 +: 8] <= 8'h7d;
    else if(temp_round[process2*8 +: 8] == 8'h14) temp_round[process2*8 +: 8] <= 8'hfa;
    else if(temp_round[process2*8 +: 8] == 8'h15) temp_round[process2*8 +: 8] <= 8'h59;
    else if(temp_round[process2*8 +: 8] == 8'h16) temp_round[process2*8 +: 8] <= 8'h47;
    else if(temp_round[process2*8 +: 8] == 8'h17) temp_round[process2*8 +: 8] <= 8'hf0;
    else if(temp_round[process2*8 +: 8] == 8'h18) temp_round[process2*8 +: 8] <= 8'had;
    else if(temp_round[process2*8 +: 8] == 8'h19) temp_round[process2*8 +: 8] <= 8'hd4;
    else if(temp_round[process2*8 +: 8] == 8'h1a) temp_round[process2*8 +: 8] <= 8'ha2;
    else if(temp_round[process2*8 +: 8] == 8'h1b) temp_round[process2*8 +: 8] <= 8'haf;
    else if(temp_round[process2*8 +: 8] == 8'h1c) temp_round[process2*8 +: 8] <= 8'h9c;
    else if(temp_round[process2*8 +: 8] == 8'h1d) temp_round[process2*8 +: 8] <= 8'ha4;
    else if(temp_round[process2*8 +: 8] == 8'h1e) temp_round[process2*8 +: 8] <= 8'h72;
    else if(temp_round[process2*8 +: 8] == 8'h1f) temp_round[process2*8 +: 8] <= 8'hc0;
    else if(temp_round[process2*8 +: 8] == 8'h20) temp_round[process2*8 +: 8] <= 8'hb7;
    else if(temp_round[process2*8 +: 8] == 8'h21) temp_round[process2*8 +: 8] <= 8'hfd;
    else if(temp_round[process2*8 +: 8] == 8'h22) temp_round[process2*8 +: 8] <= 8'h93;
    else if(temp_round[process2*8 +: 8] == 8'h23) temp_round[process2*8 +: 8] <= 8'h26;
    else if(temp_round[process2*8 +: 8] == 8'h24) temp_round[process2*8 +: 8] <= 8'h36;
    else if(temp_round[process2*8 +: 8] == 8'h25) temp_round[process2*8 +: 8] <= 8'h3f;
    else if(temp_round[process2*8 +: 8] == 8'h26) temp_round[process2*8 +: 8] <= 8'hf7;
    else if(temp_round[process2*8 +: 8] == 8'h27) temp_round[process2*8 +: 8] <= 8'hcc;
    else if(temp_round[process2*8 +: 8] == 8'h28) temp_round[process2*8 +: 8] <= 8'h34;
    else if(temp_round[process2*8 +: 8] == 8'h29) temp_round[process2*8 +: 8] <= 8'ha5;
    else if(temp_round[process2*8 +: 8] == 8'h2a) temp_round[process2*8 +: 8] <= 8'he5;
    else if(temp_round[process2*8 +: 8] == 8'h2b) temp_round[process2*8 +: 8] <= 8'hf1;
    else if(temp_round[process2*8 +: 8] == 8'h2c) temp_round[process2*8 +: 8] <= 8'h71;
    else if(temp_round[process2*8 +: 8] == 8'h2d) temp_round[process2*8 +: 8] <= 8'hd8;
    else if(temp_round[process2*8 +: 8] == 8'h2e) temp_round[process2*8 +: 8] <= 8'h31;
    else if(temp_round[process2*8 +: 8] == 8'h2f) temp_round[process2*8 +: 8] <= 8'h15;
    else if(temp_round[process2*8 +: 8] == 8'h30) temp_round[process2*8 +: 8] <= 8'h04;
    else if(temp_round[process2*8 +: 8] == 8'h31) temp_round[process2*8 +: 8] <= 8'hc7;
    else if(temp_round[process2*8 +: 8] == 8'h32) temp_round[process2*8 +: 8] <= 8'h23;
    else if(temp_round[process2*8 +: 8] == 8'h33) temp_round[process2*8 +: 8] <= 8'hc3;
    else if(temp_round[process2*8 +: 8] == 8'h34) temp_round[process2*8 +: 8] <= 8'h18;
    else if(temp_round[process2*8 +: 8] == 8'h35) temp_round[process2*8 +: 8] <= 8'h96;
    else if(temp_round[process2*8 +: 8] == 8'h36) temp_round[process2*8 +: 8] <= 8'h05;
    else if(temp_round[process2*8 +: 8] == 8'h37) temp_round[process2*8 +: 8] <= 8'h9a;
    else if(temp_round[process2*8 +: 8] == 8'h38) temp_round[process2*8 +: 8] <= 8'h07;
    else if(temp_round[process2*8 +: 8] == 8'h39) temp_round[process2*8 +: 8] <= 8'h12;
    else if(temp_round[process2*8 +: 8] == 8'h3a) temp_round[process2*8 +: 8] <= 8'h80;
    else if(temp_round[process2*8 +: 8] == 8'h3b) temp_round[process2*8 +: 8] <= 8'he2;
    else if(temp_round[process2*8 +: 8] == 8'h3c) temp_round[process2*8 +: 8] <= 8'heb;
    else if(temp_round[process2*8 +: 8] == 8'h3d) temp_round[process2*8 +: 8] <= 8'h27;
    else if(temp_round[process2*8 +: 8] == 8'h3e) temp_round[process2*8 +: 8] <= 8'hb2;
    else if(temp_round[process2*8 +: 8] == 8'h3f) temp_round[process2*8 +: 8] <= 8'h75;
    else if(temp_round[process2*8 +: 8] == 8'h40) temp_round[process2*8 +: 8] <= 8'h09;
    else if(temp_round[process2*8 +: 8] == 8'h41) temp_round[process2*8 +: 8] <= 8'h83;
    else if(temp_round[process2*8 +: 8] == 8'h42) temp_round[process2*8 +: 8] <= 8'h2c;
    else if(temp_round[process2*8 +: 8] == 8'h43) temp_round[process2*8 +: 8] <= 8'h1a;
    else if(temp_round[process2*8 +: 8] == 8'h44) temp_round[process2*8 +: 8] <= 8'h1b;
    else if(temp_round[process2*8 +: 8] == 8'h45) temp_round[process2*8 +: 8] <= 8'h6e;
    else if(temp_round[process2*8 +: 8] == 8'h46) temp_round[process2*8 +: 8] <= 8'h5a;
    else if(temp_round[process2*8 +: 8] == 8'h47) temp_round[process2*8 +: 8] <= 8'ha0;
    else if(temp_round[process2*8 +: 8] == 8'h48) temp_round[process2*8 +: 8] <= 8'h52;
    else if(temp_round[process2*8 +: 8] == 8'h49) temp_round[process2*8 +: 8] <= 8'h3b;
    else if(temp_round[process2*8 +: 8] == 8'h4a) temp_round[process2*8 +: 8] <= 8'hd6;
    else if(temp_round[process2*8 +: 8] == 8'h4b) temp_round[process2*8 +: 8] <= 8'hb3;
    else if(temp_round[process2*8 +: 8] == 8'h4c) temp_round[process2*8 +: 8] <= 8'h29;
    else if(temp_round[process2*8 +: 8] == 8'h4d) temp_round[process2*8 +: 8] <= 8'he3;
    else if(temp_round[process2*8 +: 8] == 8'h4e) temp_round[process2*8 +: 8] <= 8'h2f;
    else if(temp_round[process2*8 +: 8] == 8'h4f) temp_round[process2*8 +: 8] <= 8'h84;
    else if(temp_round[process2*8 +: 8] == 8'h50) temp_round[process2*8 +: 8] <= 8'h53;
    else if(temp_round[process2*8 +: 8] == 8'h51) temp_round[process2*8 +: 8] <= 8'hd1;
    else if(temp_round[process2*8 +: 8] == 8'h52) temp_round[process2*8 +: 8] <= 8'h00;
    else if(temp_round[process2*8 +: 8] == 8'h53) temp_round[process2*8 +: 8] <= 8'hed;
    else if(temp_round[process2*8 +: 8] == 8'h54) temp_round[process2*8 +: 8] <= 8'h20;
    else if(temp_round[process2*8 +: 8] == 8'h55) temp_round[process2*8 +: 8] <= 8'hfc;
    else if(temp_round[process2*8 +: 8] == 8'h56) temp_round[process2*8 +: 8] <= 8'hb1;
    else if(temp_round[process2*8 +: 8] == 8'h57) temp_round[process2*8 +: 8] <= 8'h5b;
    else if(temp_round[process2*8 +: 8] == 8'h58) temp_round[process2*8 +: 8] <= 8'h6a;
    else if(temp_round[process2*8 +: 8] == 8'h59) temp_round[process2*8 +: 8] <= 8'hcb;
    else if(temp_round[process2*8 +: 8] == 8'h5a) temp_round[process2*8 +: 8] <= 8'hbe;
    else if(temp_round[process2*8 +: 8] == 8'h5b) temp_round[process2*8 +: 8] <= 8'h39;
    else if(temp_round[process2*8 +: 8] == 8'h5c) temp_round[process2*8 +: 8] <= 8'h4a;
    else if(temp_round[process2*8 +: 8] == 8'h5d) temp_round[process2*8 +: 8] <= 8'h4c;
    else if(temp_round[process2*8 +: 8] == 8'h5e) temp_round[process2*8 +: 8] <= 8'h58;
    else if(temp_round[process2*8 +: 8] == 8'h5f) temp_round[process2*8 +: 8] <= 8'hcf;
    else if(temp_round[process2*8 +: 8] == 8'h60) temp_round[process2*8 +: 8] <= 8'hd0;
    else if(temp_round[process2*8 +: 8] == 8'h61) temp_round[process2*8 +: 8] <= 8'hef;
    else if(temp_round[process2*8 +: 8] == 8'h62) temp_round[process2*8 +: 8] <= 8'haa;
    else if(temp_round[process2*8 +: 8] == 8'h63) temp_round[process2*8 +: 8] <= 8'hfb;
    else if(temp_round[process2*8 +: 8] == 8'h64) temp_round[process2*8 +: 8] <= 8'h43;
    else if(temp_round[process2*8 +: 8] == 8'h65) temp_round[process2*8 +: 8] <= 8'h4d;
    else if(temp_round[process2*8 +: 8] == 8'h66) temp_round[process2*8 +: 8] <= 8'h33;
    else if(temp_round[process2*8 +: 8] == 8'h67) temp_round[process2*8 +: 8] <= 8'h85;
    else if(temp_round[process2*8 +: 8] == 8'h68) temp_round[process2*8 +: 8] <= 8'h45;
    else if(temp_round[process2*8 +: 8] == 8'h69) temp_round[process2*8 +: 8] <= 8'hf9;
    else if(temp_round[process2*8 +: 8] == 8'h6a) temp_round[process2*8 +: 8] <= 8'h02;
    else if(temp_round[process2*8 +: 8] == 8'h6b) temp_round[process2*8 +: 8] <= 8'h7f;
    else if(temp_round[process2*8 +: 8] == 8'h6c) temp_round[process2*8 +: 8] <= 8'h50;
    else if(temp_round[process2*8 +: 8] == 8'h6d) temp_round[process2*8 +: 8] <= 8'h3c;
    else if(temp_round[process2*8 +: 8] == 8'h6e) temp_round[process2*8 +: 8] <= 8'h9f;
    else if(temp_round[process2*8 +: 8] == 8'h6f) temp_round[process2*8 +: 8] <= 8'ha8;
    else if(temp_round[process2*8 +: 8] == 8'h70) temp_round[process2*8 +: 8] <= 8'h51;
    else if(temp_round[process2*8 +: 8] == 8'h71) temp_round[process2*8 +: 8] <= 8'ha3;
    else if(temp_round[process2*8 +: 8] == 8'h72) temp_round[process2*8 +: 8] <= 8'h40;
    else if(temp_round[process2*8 +: 8] == 8'h73) temp_round[process2*8 +: 8] <= 8'h8f;
    else if(temp_round[process2*8 +: 8] == 8'h74) temp_round[process2*8 +: 8] <= 8'h92;
    else if(temp_round[process2*8 +: 8] == 8'h75) temp_round[process2*8 +: 8] <= 8'h9d;
    else if(temp_round[process2*8 +: 8] == 8'h76) temp_round[process2*8 +: 8] <= 8'h38;
    else if(temp_round[process2*8 +: 8] == 8'h77) temp_round[process2*8 +: 8] <= 8'hf5;
    else if(temp_round[process2*8 +: 8] == 8'h78) temp_round[process2*8 +: 8] <= 8'hbc;
    else if(temp_round[process2*8 +: 8] == 8'h79) temp_round[process2*8 +: 8] <= 8'hb6;
    else if(temp_round[process2*8 +: 8] == 8'h7a) temp_round[process2*8 +: 8] <= 8'hda;
    else if(temp_round[process2*8 +: 8] == 8'h7b) temp_round[process2*8 +: 8] <= 8'h21;
    else if(temp_round[process2*8 +: 8] == 8'h7c) temp_round[process2*8 +: 8] <= 8'h10;
    else if(temp_round[process2*8 +: 8] == 8'h7d) temp_round[process2*8 +: 8] <= 8'hff;
    else if(temp_round[process2*8 +: 8] == 8'h7e) temp_round[process2*8 +: 8] <= 8'hf3;
    else if(temp_round[process2*8 +: 8] == 8'h7f) temp_round[process2*8 +: 8] <= 8'hd2;
    else if(temp_round[process2*8 +: 8] == 8'h80) temp_round[process2*8 +: 8] <= 8'hcd;
    else if(temp_round[process2*8 +: 8] == 8'h81) temp_round[process2*8 +: 8] <= 8'h0c;
    else if(temp_round[process2*8 +: 8] == 8'h82) temp_round[process2*8 +: 8] <= 8'h13;
    else if(temp_round[process2*8 +: 8] == 8'h83) temp_round[process2*8 +: 8] <= 8'hec;
    else if(temp_round[process2*8 +: 8] == 8'h84) temp_round[process2*8 +: 8] <= 8'h5f;
    else if(temp_round[process2*8 +: 8] == 8'h85) temp_round[process2*8 +: 8] <= 8'h97;
    else if(temp_round[process2*8 +: 8] == 8'h86) temp_round[process2*8 +: 8] <= 8'h44;
    else if(temp_round[process2*8 +: 8] == 8'h87) temp_round[process2*8 +: 8] <= 8'h17;
    else if(temp_round[process2*8 +: 8] == 8'h88) temp_round[process2*8 +: 8] <= 8'hc4;
    else if(temp_round[process2*8 +: 8] == 8'h89) temp_round[process2*8 +: 8] <= 8'ha7;
    else if(temp_round[process2*8 +: 8] == 8'h8a) temp_round[process2*8 +: 8] <= 8'h7e;
    else if(temp_round[process2*8 +: 8] == 8'h8b) temp_round[process2*8 +: 8] <= 8'h3d;
    else if(temp_round[process2*8 +: 8] == 8'h8c) temp_round[process2*8 +: 8] <= 8'h64;
    else if(temp_round[process2*8 +: 8] == 8'h8d) temp_round[process2*8 +: 8] <= 8'h5d;
    else if(temp_round[process2*8 +: 8] == 8'h8e) temp_round[process2*8 +: 8] <= 8'h19;
    else if(temp_round[process2*8 +: 8] == 8'h8f) temp_round[process2*8 +: 8] <= 8'h73;
    else if(temp_round[process2*8 +: 8] == 8'h90) temp_round[process2*8 +: 8] <= 8'h60;
    else if(temp_round[process2*8 +: 8] == 8'h91) temp_round[process2*8 +: 8] <= 8'h81;
    else if(temp_round[process2*8 +: 8] == 8'h92) temp_round[process2*8 +: 8] <= 8'h4f;
    else if(temp_round[process2*8 +: 8] == 8'h93) temp_round[process2*8 +: 8] <= 8'hdc;
    else if(temp_round[process2*8 +: 8] == 8'h94) temp_round[process2*8 +: 8] <= 8'h22;
    else if(temp_round[process2*8 +: 8] == 8'h95) temp_round[process2*8 +: 8] <= 8'h2a;
    else if(temp_round[process2*8 +: 8] == 8'h96) temp_round[process2*8 +: 8] <= 8'h90;
    else if(temp_round[process2*8 +: 8] == 8'h97) temp_round[process2*8 +: 8] <= 8'h88;
    else if(temp_round[process2*8 +: 8] == 8'h98) temp_round[process2*8 +: 8] <= 8'h46;
    else if(temp_round[process2*8 +: 8] == 8'h99) temp_round[process2*8 +: 8] <= 8'hee;
    else if(temp_round[process2*8 +: 8] == 8'h9a) temp_round[process2*8 +: 8] <= 8'hb8;
    else if(temp_round[process2*8 +: 8] == 8'h9b) temp_round[process2*8 +: 8] <= 8'h14;
    else if(temp_round[process2*8 +: 8] == 8'h9c) temp_round[process2*8 +: 8] <= 8'hde;
    else if(temp_round[process2*8 +: 8] == 8'h9d) temp_round[process2*8 +: 8] <= 8'h5e;
    else if(temp_round[process2*8 +: 8] == 8'h9e) temp_round[process2*8 +: 8] <= 8'h0b;
    else if(temp_round[process2*8 +: 8] == 8'h9f) temp_round[process2*8 +: 8] <= 8'hdb;
    else if(temp_round[process2*8 +: 8] == 8'ha0) temp_round[process2*8 +: 8] <= 8'he0;
    else if(temp_round[process2*8 +: 8] == 8'ha1) temp_round[process2*8 +: 8] <= 8'h32;
    else if(temp_round[process2*8 +: 8] == 8'ha2) temp_round[process2*8 +: 8] <= 8'h3a;
    else if(temp_round[process2*8 +: 8] == 8'ha3) temp_round[process2*8 +: 8] <= 8'h0a;
    else if(temp_round[process2*8 +: 8] == 8'ha4) temp_round[process2*8 +: 8] <= 8'h49;
    else if(temp_round[process2*8 +: 8] == 8'ha5) temp_round[process2*8 +: 8] <= 8'h06;
    else if(temp_round[process2*8 +: 8] == 8'ha6) temp_round[process2*8 +: 8] <= 8'h24;
    else if(temp_round[process2*8 +: 8] == 8'ha7) temp_round[process2*8 +: 8] <= 8'h5c;
    else if(temp_round[process2*8 +: 8] == 8'ha8) temp_round[process2*8 +: 8] <= 8'hc2;
    else if(temp_round[process2*8 +: 8] == 8'ha9) temp_round[process2*8 +: 8] <= 8'hd3;
    else if(temp_round[process2*8 +: 8] == 8'haa) temp_round[process2*8 +: 8] <= 8'hac;
    else if(temp_round[process2*8 +: 8] == 8'hab) temp_round[process2*8 +: 8] <= 8'h62;
    else if(temp_round[process2*8 +: 8] == 8'hac) temp_round[process2*8 +: 8] <= 8'h91;
    else if(temp_round[process2*8 +: 8] == 8'had) temp_round[process2*8 +: 8] <= 8'h95;
    else if(temp_round[process2*8 +: 8] == 8'hae) temp_round[process2*8 +: 8] <= 8'he4;
    else if(temp_round[process2*8 +: 8] == 8'haf) temp_round[process2*8 +: 8] <= 8'h79;
    else if(temp_round[process2*8 +: 8] == 8'hb0) temp_round[process2*8 +: 8] <= 8'he7;
    else if(temp_round[process2*8 +: 8] == 8'hb1) temp_round[process2*8 +: 8] <= 8'hc8;
    else if(temp_round[process2*8 +: 8] == 8'hb2) temp_round[process2*8 +: 8] <= 8'h37;
    else if(temp_round[process2*8 +: 8] == 8'hb3) temp_round[process2*8 +: 8] <= 8'h6d;
    else if(temp_round[process2*8 +: 8] == 8'hb4) temp_round[process2*8 +: 8] <= 8'h8d;
    else if(temp_round[process2*8 +: 8] == 8'hb5) temp_round[process2*8 +: 8] <= 8'hd5;
    else if(temp_round[process2*8 +: 8] == 8'hb6) temp_round[process2*8 +: 8] <= 8'h4e;
    else if(temp_round[process2*8 +: 8] == 8'hb7) temp_round[process2*8 +: 8] <= 8'ha9;
    else if(temp_round[process2*8 +: 8] == 8'hb8) temp_round[process2*8 +: 8] <= 8'h6c;
    else if(temp_round[process2*8 +: 8] == 8'hb9) temp_round[process2*8 +: 8] <= 8'h56;
    else if(temp_round[process2*8 +: 8] == 8'hba) temp_round[process2*8 +: 8] <= 8'hf4;
    else if(temp_round[process2*8 +: 8] == 8'hbb) temp_round[process2*8 +: 8] <= 8'hea;
    else if(temp_round[process2*8 +: 8] == 8'hbc) temp_round[process2*8 +: 8] <= 8'h65;
    else if(temp_round[process2*8 +: 8] == 8'hbd) temp_round[process2*8 +: 8] <= 8'h7a;
    else if(temp_round[process2*8 +: 8] == 8'hbe) temp_round[process2*8 +: 8] <= 8'hae;
    else if(temp_round[process2*8 +: 8] == 8'hbf) temp_round[process2*8 +: 8] <= 8'h08;
    else if(temp_round[process2*8 +: 8] == 8'hc0) temp_round[process2*8 +: 8] <= 8'hba;
    else if(temp_round[process2*8 +: 8] == 8'hc1) temp_round[process2*8 +: 8] <= 8'h78;
    else if(temp_round[process2*8 +: 8] == 8'hc2) temp_round[process2*8 +: 8] <= 8'h25;
    else if(temp_round[process2*8 +: 8] == 8'hc3) temp_round[process2*8 +: 8] <= 8'h2e;
    else if(temp_round[process2*8 +: 8] == 8'hc4) temp_round[process2*8 +: 8] <= 8'h1c;
    else if(temp_round[process2*8 +: 8] == 8'hc5) temp_round[process2*8 +: 8] <= 8'ha6;
    else if(temp_round[process2*8 +: 8] == 8'hc6) temp_round[process2*8 +: 8] <= 8'hb4;
    else if(temp_round[process2*8 +: 8] == 8'hc7) temp_round[process2*8 +: 8] <= 8'hc6;
    else if(temp_round[process2*8 +: 8] == 8'hc8) temp_round[process2*8 +: 8] <= 8'he8;
    else if(temp_round[process2*8 +: 8] == 8'hc9) temp_round[process2*8 +: 8] <= 8'hdd;
    else if(temp_round[process2*8 +: 8] == 8'hca) temp_round[process2*8 +: 8] <= 8'h74;
    else if(temp_round[process2*8 +: 8] == 8'hcb) temp_round[process2*8 +: 8] <= 8'h1f;
    else if(temp_round[process2*8 +: 8] == 8'hcc) temp_round[process2*8 +: 8] <= 8'h4b;
    else if(temp_round[process2*8 +: 8] == 8'hcd) temp_round[process2*8 +: 8] <= 8'hbd;
    else if(temp_round[process2*8 +: 8] == 8'hce) temp_round[process2*8 +: 8] <= 8'h8b;
    else if(temp_round[process2*8 +: 8] == 8'hcf) temp_round[process2*8 +: 8] <= 8'h8a;
    else if(temp_round[process2*8 +: 8] == 8'hd0) temp_round[process2*8 +: 8] <= 8'h70;
    else if(temp_round[process2*8 +: 8] == 8'hd1) temp_round[process2*8 +: 8] <= 8'h3e;
    else if(temp_round[process2*8 +: 8] == 8'hd2) temp_round[process2*8 +: 8] <= 8'hb5;
    else if(temp_round[process2*8 +: 8] == 8'hd3) temp_round[process2*8 +: 8] <= 8'h66;
    else if(temp_round[process2*8 +: 8] == 8'hd4) temp_round[process2*8 +: 8] <= 8'h48;
    else if(temp_round[process2*8 +: 8] == 8'hd5) temp_round[process2*8 +: 8] <= 8'h03;
    else if(temp_round[process2*8 +: 8] == 8'hd6) temp_round[process2*8 +: 8] <= 8'hf6;
    else if(temp_round[process2*8 +: 8] == 8'hd7) temp_round[process2*8 +: 8] <= 8'h0e;
    else if(temp_round[process2*8 +: 8] == 8'hd8) temp_round[process2*8 +: 8] <= 8'h61;
    else if(temp_round[process2*8 +: 8] == 8'hd9) temp_round[process2*8 +: 8] <= 8'h35;
    else if(temp_round[process2*8 +: 8] == 8'hda) temp_round[process2*8 +: 8] <= 8'h57;
    else if(temp_round[process2*8 +: 8] == 8'hdb) temp_round[process2*8 +: 8] <= 8'hb9;
    else if(temp_round[process2*8 +: 8] == 8'hdc) temp_round[process2*8 +: 8] <= 8'h86;
    else if(temp_round[process2*8 +: 8] == 8'hdd) temp_round[process2*8 +: 8] <= 8'hc1;
    else if(temp_round[process2*8 +: 8] == 8'hde) temp_round[process2*8 +: 8] <= 8'h1d;
    else if(temp_round[process2*8 +: 8] == 8'hdf) temp_round[process2*8 +: 8] <= 8'h9e;
    else if(temp_round[process2*8 +: 8] == 8'he0) temp_round[process2*8 +: 8] <= 8'he1;
    else if(temp_round[process2*8 +: 8] == 8'he1) temp_round[process2*8 +: 8] <= 8'hf8;
    else if(temp_round[process2*8 +: 8] == 8'he2) temp_round[process2*8 +: 8] <= 8'h98;
    else if(temp_round[process2*8 +: 8] == 8'he3) temp_round[process2*8 +: 8] <= 8'h11;
    else if(temp_round[process2*8 +: 8] == 8'he4) temp_round[process2*8 +: 8] <= 8'h69;
    else if(temp_round[process2*8 +: 8] == 8'he5) temp_round[process2*8 +: 8] <= 8'hd9;
    else if(temp_round[process2*8 +: 8] == 8'he6) temp_round[process2*8 +: 8] <= 8'h8e;
    else if(temp_round[process2*8 +: 8] == 8'he7) temp_round[process2*8 +: 8] <= 8'h94;
    else if(temp_round[process2*8 +: 8] == 8'he8) temp_round[process2*8 +: 8] <= 8'h9b;
    else if(temp_round[process2*8 +: 8] == 8'he9) temp_round[process2*8 +: 8] <= 8'h1e;
    else if(temp_round[process2*8 +: 8] == 8'hea) temp_round[process2*8 +: 8] <= 8'h87;
    else if(temp_round[process2*8 +: 8] == 8'heb) temp_round[process2*8 +: 8] <= 8'he9;
    else if(temp_round[process2*8 +: 8] == 8'hec) temp_round[process2*8 +: 8] <= 8'hce;
    else if(temp_round[process2*8 +: 8] == 8'hed) temp_round[process2*8 +: 8] <= 8'h55;
    else if(temp_round[process2*8 +: 8] == 8'hee) temp_round[process2*8 +: 8] <= 8'h28;
    else if(temp_round[process2*8 +: 8] == 8'hef) temp_round[process2*8 +: 8] <= 8'hdf;
    else if(temp_round[process2*8 +: 8] == 8'hf0) temp_round[process2*8 +: 8] <= 8'h8c;
    else if(temp_round[process2*8 +: 8] == 8'hf1) temp_round[process2*8 +: 8] <= 8'ha1;
    else if(temp_round[process2*8 +: 8] == 8'hf2) temp_round[process2*8 +: 8] <= 8'h89;
    else if(temp_round[process2*8 +: 8] == 8'hf3) temp_round[process2*8 +: 8] <= 8'h0d;
    else if(temp_round[process2*8 +: 8] == 8'hf4) temp_round[process2*8 +: 8] <= 8'hbf;
    else if(temp_round[process2*8 +: 8] == 8'hf5) temp_round[process2*8 +: 8] <= 8'he6;
    else if(temp_round[process2*8 +: 8] == 8'hf6) temp_round[process2*8 +: 8] <= 8'h42;
    else if(temp_round[process2*8 +: 8] == 8'hf7) temp_round[process2*8 +: 8] <= 8'h68;
    else if(temp_round[process2*8 +: 8] == 8'hf8) temp_round[process2*8 +: 8] <= 8'h41;
    else if(temp_round[process2*8 +: 8] == 8'hf9) temp_round[process2*8 +: 8] <= 8'h99;
    else if(temp_round[process2*8 +: 8] == 8'hfa) temp_round[process2*8 +: 8] <= 8'h2d;
    else if(temp_round[process2*8 +: 8] == 8'hfb) temp_round[process2*8 +: 8] <= 8'h0f;
    else if(temp_round[process2*8 +: 8] == 8'hfc) temp_round[process2*8 +: 8] <= 8'hb0;
    else if(temp_round[process2*8 +: 8] == 8'hfd) temp_round[process2*8 +: 8] <= 8'h54;
    else if(temp_round[process2*8 +: 8] == 8'hfe) temp_round[process2*8 +: 8] <= 8'hbb;
    else if(temp_round[process2*8 +: 8] == 8'hff) temp_round[process2*8 +: 8] <= 8'h16;
							
								
								process2 = process2 + 3'd1;
							end // if(process2 <= 2'd3) begin 
							
							else begin // if(process2 <= 2'd3) begin 
								process1 = 5'd2; /// go to 4.3 add Rcon
							end // else begin if(process2 <= 2'd3) 
						end // else if(process1==5'd1)
						
						else if(process1 == 5'd2) begin // 4.3 add Rcon and make 1'
						
						
							if(key_round==4'd1) r_con[7:0] = 8'h01;
							else if(key_round==4'd2) r_con[7:0] = 8'h02;
							else if(key_round==4'd3) r_con[7:0] = 8'h04;
							else if(key_round==4'd4) r_con[7:0] = 8'h08;
							else if(key_round==4'd5) r_con[7:0] = 8'h10;
							else if(key_round==4'd6) r_con[7:0] = 8'h20;
							else if(key_round==4'd7) r_con[7:0] = 8'h40;
							else if(key_round==4'd8) r_con[7:0] = 8'h80;
							else if(key_round==4'd9) r_con[7:0] = 8'h1b;
							else if(key_round==4'd10) r_con[7:0] = 8'h36;
							else begin end 
							
							round_key[127:120] <= cipher_key[127:120]^temp_round[31:24]^r_con[7:0];
							round_key[95:88] <= cipher_key[95:88]^temp_round[23:16]^8'h00;
							round_key[63:56] <= cipher_key[63:56]^temp_round[15:8]^8'h00;
							round_key[31:24] <= cipher_key[31:24]^temp_round[7:0]^8'h00;
						
							process1 =5'd3;
						end //(process1 == 5'd2) END 
						
						else if(process1 == 5'd3) begin // 4.4 2' = 2+1'
							round_key[119:112] <= cipher_key[119:112]^round_key[127:120];
							round_key[87:80] <= cipher_key[87:80]^round_key[95:88];
							round_key[55:48] <= cipher_key[55:48]^round_key[63:56];
							round_key[23:16] <= cipher_key[23:16]^round_key[31:24];
						
							process1 = 5'd4;
						end 
						
						else if(process1 == 5'd4) begin // 4.5 3' = 3+2'
							round_key[111:104] <= cipher_key[111:104]^round_key[119:112];
							round_key[79:72] <= cipher_key[79:72]^round_key[87:80];
							round_key[47:40] <= cipher_key[47:40]^round_key[55:48];
							round_key[15:08] <= cipher_key[15:08]^round_key[23:16];
						
							process1 = 5'd5;
						end //(process1 == 5'd4) END 
						
						else if(process1 == 5'd5) begin // 4.6 4' = 4+3'
							round_key[103:96] <= cipher_key[103:96]^round_key[111:104];
							round_key[71:64] <= cipher_key[71:64]^round_key[79:72];
							round_key[39:32] <= cipher_key[39:32]^round_key[47:40];
							round_key[7:0] <= cipher_key[7:0]^round_key[15:08];
							
							process1 = 5'd6;
						end //(process1 == 5'd5) END 
						
						else if(process1 == 5'd6) begin // add round key
							
							cipher_key <= round_key;
							process1 = 5'd7;
						end // (process1 == 5'd6) END 
						
						else begin // process1 = 5'd7 
							
							process1 = 0;
							process2 = 0;
							key_round = key_round +4'd1;
						end  //// process1 = 5'd7 
						
						
						
					end //if(key_round <= 4'd10-round)
					
					else if(key_round == 4'd10-round+4'd1) begin // if key_round > 10-round go to next stage
						/* 4.4 Add Round Key to dec_in_state */
						out_state <= in_state ^ round_key;// Add Round Key
						key_round = key_round +4'd1;
						
					end // else if (key_round == 4'd10)
					
					else begin // key_round > 10-round
						/* out_state -> in_state, reset variables , 
						go next stage 3.INV MIX COLUMN */
						key_round <= 4'd1;
						in_state <= out_state;
						cipher_key <= initial_cipher_key;
						process1=0;
						process2=0;
						round_process = 4'd2;
					end  //key_round > 10-round
				
				end //else if(round_process==1) 4. Add Round KEY END 
				
				else if(round_process == 4'd2) begin // 3. INV Mix Column
					if(round != 4'd0) begin // If round is 1 to 9
						/* 3. INV Mix Column */
						if(process < 5'd4) begin // loop for 4
							if(process1 == 5'd0) begin 
								/* Make nine */ //9 * x = ((((x*2)*2)*2)+x;
								if(nine_process <= 5'd22) begin 
									
								
									if(nine_process == 5'd0) begin 
										A0 = in_state[(process+12)*8 +: 8];
										A1 = in_state[(process+8)*8 +: 8];
										A2 = in_state[(process+4)*8 +: 8];
										A3 = in_state[(process)*8 +: 8];
										
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd1;
									end //nine_process =0
									
									else if(nine_process == 5'd1) begin 
										
										if(A0 >= 8'b1000_0000) begin //(x*2)*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //(x*2)*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //(x*2)*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //(x*2)*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd2;
									end //if(nine_process == 2'd1)
									
									else if(nine_process == 5'd2) begin 
										
										if(A0 >= 8'b1000_0000) begin //((x*2)*2)*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //((x*2)*2)*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //((x*2)*2)*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //((x*2)*2)*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd3;
									end //if(nine_process == 2'd2)
									
									else if(nine_process == 5'd3) begin 
										nine_A0 <= A0^in_state[(process+12)*8 +: 8]; //(((x*2)*2)*2)+x
										nine_A1 <= A1^in_state[(process+8)*8 +: 8]; //(((x*2)*2)*2)+x
										nine_A2 <= A2^in_state[(process+4)*8 +: 8]; //(((x*2)*2)*2)+x
										nine_A3 <= A3^in_state[(process)*8 +: 8]; //(((x*2)*2)*2)+x
										nine_process = 5'd4;
									end //if(nine_process == 2'd2)
									
									/* Make b */ //b * x = ((((x*2)*2)+x)*2)+x;
									
									else if(nine_process == 5'd4) begin 
										A0 <= in_state[(process+12)*8 +: 8];
										A1 <= in_state[(process+8)*8 +: 8];
										A2 <= in_state[(process+4)*8 +: 8];
										A3 <= in_state[(process)*8 +: 8];
										nine_process = 5'd5;
									end // if(nine_process == 5'd4)
									
									else if(nine_process == 5'd5) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd6;
									end // if(nine_process == 5'd5)
									
									else if(nine_process == 5'd6) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd7;
									end // if(nine_process == 5'd6)
									
									else if(nine_process == 5'd7) begin 
										A0 <= A0^in_state[(process+12)*8 +: 8];
										A1 <= A1^in_state[(process+8)*8 +: 8];
										A2 <= A2^in_state[(process+4)*8 +: 8];
										A3 <= A3^in_state[(process)*8 +: 8];
										
										nine_process = 5'd8;
									end // if(nine_process == 5'd7)
									
									else if(nine_process == 5'd8) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd9;
									end // if(nine_process == 5'd8)
									
									else if(nine_process == 5'd9) begin 
										b_A0 <= A0^in_state[(process+12)*8 +: 8];
										b_A1 <= A1^in_state[(process+8)*8 +: 8];
										b_A2 <= A2^in_state[(process+4)*8 +: 8];
										b_A3 <= A3^in_state[(process)*8 +: 8];
										
										nine_process = 5'd10;
									end // if(nine_process == 5'd9)
									
									/* Make d */
									
									else if(nine_process == 5'd10) begin 
										A0 <= in_state[(process+12)*8 +: 8];
										A1 <= in_state[(process+8)*8 +: 8];
										A2 <= in_state[(process+4)*8 +: 8];
										A3 <= in_state[(process)*8 +: 8];
										
										nine_process = 5'd11;
									end // if(nine_process == 5'd10)
									
									else if(nine_process == 5'd11) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd12;
									end // if(nine_process == 5'd11)
									
									else if(nine_process == 5'd12) begin 
										A0 <= A0^in_state[(process+12)*8 +: 8];
										A1 <= A1^in_state[(process+8)*8 +: 8];
										A2 <= A2^in_state[(process+4)*8 +: 8];
										A3 <= A3^in_state[(process)*8 +: 8];
										
										nine_process = 5'd13;
									end // if(nine_process == 5'd12)
									
									else if(nine_process == 5'd13) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd14;
									end // if(nine_process == 5'd13)
									
									else if(nine_process == 5'd14) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd15;
									end // if(nine_process == 5'd14)
									
									else if(nine_process == 5'd15) begin 
										d_A0 <= A0^in_state[(process+12)*8 +: 8];
										d_A1 <= A1^in_state[(process+8)*8 +: 8];
										d_A2 <= A2^in_state[(process+4)*8 +: 8];
										d_A3 <= A3^in_state[(process)*8 +: 8];
										
										nine_process = 5'd16;
									end // if(nine_process == 5'd15)
					
								/* Make e */
								
									else if(nine_process == 5'd16) begin 
										A0 <= in_state[(process+12)*8 +: 8];
										A1 <= in_state[(process+8)*8 +: 8];
										A2 <= in_state[(process+4)*8 +: 8];
										A3 <= in_state[(process)*8 +: 8];
										
										nine_process = 5'd17;
									end // if(nine_process == 5'd16)
									
									else if(nine_process == 5'd17) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd18;
									end // if(nine_process == 5'd17)
									
									else if(nine_process == 5'd18) begin 
										A0 <= A0^in_state[(process+12)*8 +: 8];
										A1 <= A1^in_state[(process+8)*8 +: 8];
										A2 <= A2^in_state[(process+4)*8 +: 8];
										A3 <= A3^in_state[(process)*8 +: 8];
										
										nine_process = 5'd19;
									end // if(nine_process == 5'd18)
									
									else if(nine_process == 5'd19) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd20;
									end // if(nine_process == 5'd19)
									
									else if(nine_process == 5'd20) begin 
										A0 <= A0^in_state[(process+12)*8 +: 8];
										A1 <= A1^in_state[(process+8)*8 +: 8];
										A2 <= A2^in_state[(process+4)*8 +: 8];
										A3 <= A3^in_state[(process)*8 +: 8];
										
										nine_process = 5'd21;
									end // if(nine_process == 5'd20)
									
									else if(nine_process == 5'd21) begin 
										if(A0 >= 8'b1000_0000) begin //x*2
											A0 <= ((A0<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A0>= 8'b1000_0000
										else begin A0 <= (A0<<1); end 
										
										if(A1 >= 8'b1000_0000) begin //x*2
											A1 <= ((A1<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A1>= 8'b1000_0000
										else begin A1 <= (A1<<1); end 
										
										if(A2 >= 8'b1000_0000) begin //x*2
											A2 <= ((A2<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A2>= 8'b1000_0000
										else begin A2 <= (A2<<1); end 
										
										if(A3 >= 8'b1000_0000) begin //x*2
											A3 <= ((A3<<1)&(8'b1111_1111))^(8'b0001_1011);
											end // A3>= 8'b1000_0000
										else begin A3 <= (A3<<1); end 
										
										nine_process = 5'd22;
									end // if(nine_process == 5'd21)
									
									else if(nine_process == 5'd22) begin 
										e_A0 <= A0;
										e_A1 <= A1;
										e_A2 <= A2;
										e_A3 <= A3;
										
										nine_process = 5'd23;
									end // if(nine_process == 5'd22)
								end //if(nine_process <= 5'd22) begin 	
									
								else begin 
									process1 = process1 + 5'd1;
								end
							end //process1 == 5'd0
							
							else if(process1 == 5'd1) begin 
								out_state[(process+12)*8 +: 8] <= e_A0[7:0]^b_A1[7:0]^d_A2[7:0]^nine_A3[7:0];
								out_state[(process+8)*8 +: 8] <= nine_A0[7:0]^e_A1[7:0]^b_A2[7:0]^d_A3[7:0];
								out_state[(process+4)*8 +: 8] <= d_A0^nine_A1^e_A2^b_A3;
								out_state[process*8 +: 8] <= b_A0[7:0]^d_A1[7:0]^nine_A2[7:0]^e_A3[7:0];
								nine_process = 5'd0;
								process1 = 5'd0;
								process = process + 5'd1;
							end //process1 == 5'd1
						end //if(process <5'd4)
						
						else begin // if(process >= 5'd4)
							in_state <= out_state;
							process = 0;
							process1 = 0;
							round_process = 4'd3;
						end // else (process >= 5'd4)
					end // if(round != 4'd0)
					
					else begin// if(round == 0) 
						/* SKIP INV MIX COULMN */
						process = 0;
						in_state <= out_state;
						round_process =4'd3; // go to next round process (2.INV Shift rows)
					end // else begin (if(round==0))
				end // else if(round_process == 4'd2) // 3. INV MIX COLUMN END
				
				else if(round_process == 4'd3) begin //2. INV Shift rows
					/* 2. INV Shift Rows */
					if(process < 5'd2) begin 
					 out_state[127:96] <= in_state[127:96];
	
					 out_state[95:88] <= in_state[71:64];
					 out_state[87:80] <= in_state[95:88];
					 out_state[79:72] <= in_state[87:80];
					 out_state[71:64] <= in_state[79:72];
	
					 out_state[63:56] <= in_state[47:40];
					 out_state[55:48] <= in_state[39:32];
					 out_state[47:40] <= in_state[63:56];
					 out_state[39:32] <= in_state[55:48];
	
					 out_state[31:24] <= in_state[23:16];
					 out_state[23:16] <= in_state[15:08];
					 out_state[15:08] <= in_state[07:00];
					 out_state[07:00] <= in_state[31:24];
					 
					 process = process + 5'd1;
				end 
				
				else begin // if(process == 5'd2)
					process = 0; round_process=4'd4; in_state <= out_state; 
				end // else process == 5'd2
					
				end // else if(round_process == 4'd3) // 2. INV SHIFT Rows END
				
				else if(round_process == 4'd4) begin // 1. Inv Sub Bytes
					/* 1. INV Sub Bytes */
					if(process < 5'd16) begin 
	if(in_state[process*8 +: 8] == 8'h00) out_state[process*8 +: 8] <= 8'h52;
    else if(in_state[process*8 +: 8] == 8'h01) out_state[process*8 +: 8] <= 8'h09;
    else if(in_state[process*8 +: 8] == 8'h02) out_state[process*8 +: 8] <= 8'h6a;
    else if(in_state[process*8 +: 8] == 8'h03) out_state[process*8 +: 8] <= 8'hd5;
    else if(in_state[process*8 +: 8] == 8'h04) out_state[process*8 +: 8] <= 8'h30;
    else if(in_state[process*8 +: 8] == 8'h05) out_state[process*8 +: 8] <= 8'h36;
    else if(in_state[process*8 +: 8] == 8'h06) out_state[process*8 +: 8] <= 8'ha5;
    else if(in_state[process*8 +: 8] == 8'h07) out_state[process*8 +: 8] <= 8'h38;
    else if(in_state[process*8 +: 8] == 8'h08) out_state[process*8 +: 8] <= 8'hbf;
    else if(in_state[process*8 +: 8] == 8'h09) out_state[process*8 +: 8] <= 8'h40;
    else if(in_state[process*8 +: 8] == 8'h0a) out_state[process*8 +: 8] <= 8'ha3;
    else if(in_state[process*8 +: 8] == 8'h0b) out_state[process*8 +: 8] <= 8'h9e;
    else if(in_state[process*8 +: 8] == 8'h0c) out_state[process*8 +: 8] <= 8'h81;
    else if(in_state[process*8 +: 8] == 8'h0d) out_state[process*8 +: 8] <= 8'hf3;
    else if(in_state[process*8 +: 8] == 8'h0e) out_state[process*8 +: 8] <= 8'hd7;
    else if(in_state[process*8 +: 8] == 8'h0f) out_state[process*8 +: 8] <= 8'hfb;
    else if(in_state[process*8 +: 8] == 8'h10) out_state[process*8 +: 8] <= 8'h7c;
    else if(in_state[process*8 +: 8] == 8'h11) out_state[process*8 +: 8] <= 8'he3;
    else if(in_state[process*8 +: 8] == 8'h12) out_state[process*8 +: 8] <= 8'h39;
    else if(in_state[process*8 +: 8] == 8'h13) out_state[process*8 +: 8] <= 8'h82;
    else if(in_state[process*8 +: 8] == 8'h14) out_state[process*8 +: 8] <= 8'h9b;
    else if(in_state[process*8 +: 8] == 8'h15) out_state[process*8 +: 8] <= 8'h2f;
    else if(in_state[process*8 +: 8] == 8'h16) out_state[process*8 +: 8] <= 8'hff;
    else if(in_state[process*8 +: 8] == 8'h17) out_state[process*8 +: 8] <= 8'h87;
    else if(in_state[process*8 +: 8] == 8'h18) out_state[process*8 +: 8] <= 8'h34;
    else if(in_state[process*8 +: 8] == 8'h19) out_state[process*8 +: 8] <= 8'h8e;
    else if(in_state[process*8 +: 8] == 8'h1a) out_state[process*8 +: 8] <= 8'h43;
    else if(in_state[process*8 +: 8] == 8'h1b) out_state[process*8 +: 8] <= 8'h44;
    else if(in_state[process*8 +: 8] == 8'h1c) out_state[process*8 +: 8] <= 8'hc4;
    else if(in_state[process*8 +: 8] == 8'h1d) out_state[process*8 +: 8] <= 8'hde;
    else if(in_state[process*8 +: 8] == 8'h1e) out_state[process*8 +: 8] <= 8'he9;
    else if(in_state[process*8 +: 8] == 8'h1f) out_state[process*8 +: 8] <= 8'hcb;
    else if(in_state[process*8 +: 8] == 8'h20) out_state[process*8 +: 8] <= 8'h54;
    else if(in_state[process*8 +: 8] == 8'h21) out_state[process*8 +: 8] <= 8'h7b;
    else if(in_state[process*8 +: 8] == 8'h22) out_state[process*8 +: 8] <= 8'h94;
    else if(in_state[process*8 +: 8] == 8'h23) out_state[process*8 +: 8] <= 8'h32;
    else if(in_state[process*8 +: 8] == 8'h24) out_state[process*8 +: 8] <= 8'ha6;
    else if(in_state[process*8 +: 8] == 8'h25) out_state[process*8 +: 8] <= 8'hc2;
    else if(in_state[process*8 +: 8] == 8'h26) out_state[process*8 +: 8] <= 8'h23;
    else if(in_state[process*8 +: 8] == 8'h27) out_state[process*8 +: 8] <= 8'h3d;
    else if(in_state[process*8 +: 8] == 8'h28) out_state[process*8 +: 8] <= 8'hee;
    else if(in_state[process*8 +: 8] == 8'h29) out_state[process*8 +: 8] <= 8'h4c;
    else if(in_state[process*8 +: 8] == 8'h2a) out_state[process*8 +: 8] <= 8'h95;
    else if(in_state[process*8 +: 8] == 8'h2b) out_state[process*8 +: 8] <= 8'h0b;
    else if(in_state[process*8 +: 8] == 8'h2c) out_state[process*8 +: 8] <= 8'h42;
    else if(in_state[process*8 +: 8] == 8'h2d) out_state[process*8 +: 8] <= 8'hfa;
    else if(in_state[process*8 +: 8] == 8'h2e) out_state[process*8 +: 8] <= 8'hc3;
    else if(in_state[process*8 +: 8] == 8'h2f) out_state[process*8 +: 8] <= 8'h4e;
    else if(in_state[process*8 +: 8] == 8'h30) out_state[process*8 +: 8] <= 8'h08;
    else if(in_state[process*8 +: 8] == 8'h31) out_state[process*8 +: 8] <= 8'h2e;
    else if(in_state[process*8 +: 8] == 8'h32) out_state[process*8 +: 8] <= 8'ha1;
    else if(in_state[process*8 +: 8] == 8'h33) out_state[process*8 +: 8] <= 8'h66;
    else if(in_state[process*8 +: 8] == 8'h34) out_state[process*8 +: 8] <= 8'h28;
    else if(in_state[process*8 +: 8] == 8'h35) out_state[process*8 +: 8] <= 8'hd9;
    else if(in_state[process*8 +: 8] == 8'h36) out_state[process*8 +: 8] <= 8'h24;
    else if(in_state[process*8 +: 8] == 8'h37) out_state[process*8 +: 8] <= 8'hb2;
    else if(in_state[process*8 +: 8] == 8'h38) out_state[process*8 +: 8] <= 8'h76;
    else if(in_state[process*8 +: 8] == 8'h39) out_state[process*8 +: 8] <= 8'h5b;
    else if(in_state[process*8 +: 8] == 8'h3a) out_state[process*8 +: 8] <= 8'ha2;
    else if(in_state[process*8 +: 8] == 8'h3b) out_state[process*8 +: 8] <= 8'h49;
    else if(in_state[process*8 +: 8] == 8'h3c) out_state[process*8 +: 8] <= 8'h6d;
    else if(in_state[process*8 +: 8] == 8'h3d) out_state[process*8 +: 8] <= 8'h8b;
    else if(in_state[process*8 +: 8] == 8'h3e) out_state[process*8 +: 8] <= 8'hd1;
    else if(in_state[process*8 +: 8] == 8'h3f) out_state[process*8 +: 8] <= 8'h25;
    else if(in_state[process*8 +: 8] == 8'h40) out_state[process*8 +: 8] <= 8'h72;
    else if(in_state[process*8 +: 8] == 8'h41) out_state[process*8 +: 8] <= 8'hf8;
    else if(in_state[process*8 +: 8] == 8'h42) out_state[process*8 +: 8] <= 8'hf6;
    else if(in_state[process*8 +: 8] == 8'h43) out_state[process*8 +: 8] <= 8'h64;
    else if(in_state[process*8 +: 8] == 8'h44) out_state[process*8 +: 8] <= 8'h86;
    else if(in_state[process*8 +: 8] == 8'h45) out_state[process*8 +: 8] <= 8'h68;
    else if(in_state[process*8 +: 8] == 8'h46) out_state[process*8 +: 8] <= 8'h98;
    else if(in_state[process*8 +: 8] == 8'h47) out_state[process*8 +: 8] <= 8'h16;
    else if(in_state[process*8 +: 8] == 8'h48) out_state[process*8 +: 8] <= 8'hd4;
    else if(in_state[process*8 +: 8] == 8'h49) out_state[process*8 +: 8] <= 8'ha4;
    else if(in_state[process*8 +: 8] == 8'h4a) out_state[process*8 +: 8] <= 8'h5c;
    else if(in_state[process*8 +: 8] == 8'h4b) out_state[process*8 +: 8] <= 8'hcc;
    else if(in_state[process*8 +: 8] == 8'h4c) out_state[process*8 +: 8] <= 8'h5d;
    else if(in_state[process*8 +: 8] == 8'h4d) out_state[process*8 +: 8] <= 8'h65;
    else if(in_state[process*8 +: 8] == 8'h4e) out_state[process*8 +: 8] <= 8'hb6;
    else if(in_state[process*8 +: 8] == 8'h4f) out_state[process*8 +: 8] <= 8'h92;
    else if(in_state[process*8 +: 8] == 8'h50) out_state[process*8 +: 8] <= 8'h6c;
    else if(in_state[process*8 +: 8] == 8'h51) out_state[process*8 +: 8] <= 8'h70;
    else if(in_state[process*8 +: 8] == 8'h52) out_state[process*8 +: 8] <= 8'h48;
    else if(in_state[process*8 +: 8] == 8'h53) out_state[process*8 +: 8] <= 8'h50;
    else if(in_state[process*8 +: 8] == 8'h54) out_state[process*8 +: 8] <= 8'hfd;
    else if(in_state[process*8 +: 8] == 8'h55) out_state[process*8 +: 8] <= 8'hed;
    else if(in_state[process*8 +: 8] == 8'h56) out_state[process*8 +: 8] <= 8'hb9;
    else if(in_state[process*8 +: 8] == 8'h57) out_state[process*8 +: 8] <= 8'hda;
    else if(in_state[process*8 +: 8] == 8'h58) out_state[process*8 +: 8] <= 8'h5e;
    else if(in_state[process*8 +: 8] == 8'h59) out_state[process*8 +: 8] <= 8'h15;
    else if(in_state[process*8 +: 8] == 8'h5a) out_state[process*8 +: 8] <= 8'h46;
    else if(in_state[process*8 +: 8] == 8'h5b) out_state[process*8 +: 8] <= 8'h57;
    else if(in_state[process*8 +: 8] == 8'h5c) out_state[process*8 +: 8] <= 8'ha7;
    else if(in_state[process*8 +: 8] == 8'h5d) out_state[process*8 +: 8] <= 8'h8d;
    else if(in_state[process*8 +: 8] == 8'h5e) out_state[process*8 +: 8] <= 8'h9d;
    else if(in_state[process*8 +: 8] == 8'h5f) out_state[process*8 +: 8] <= 8'h84;
    else if(in_state[process*8 +: 8] == 8'h60) out_state[process*8 +: 8] <= 8'h90;
    else if(in_state[process*8 +: 8] == 8'h61) out_state[process*8 +: 8] <= 8'hd8;
    else if(in_state[process*8 +: 8] == 8'h62) out_state[process*8 +: 8] <= 8'hab;
    else if(in_state[process*8 +: 8] == 8'h63) out_state[process*8 +: 8] <= 8'h00;
    else if(in_state[process*8 +: 8] == 8'h64) out_state[process*8 +: 8] <= 8'h8c;
    else if(in_state[process*8 +: 8] == 8'h65) out_state[process*8 +: 8] <= 8'hbc;
    else if(in_state[process*8 +: 8] == 8'h66) out_state[process*8 +: 8] <= 8'hd3;
    else if(in_state[process*8 +: 8] == 8'h67) out_state[process*8 +: 8] <= 8'h0a;
    else if(in_state[process*8 +: 8] == 8'h68) out_state[process*8 +: 8] <= 8'hf7;
    else if(in_state[process*8 +: 8] == 8'h69) out_state[process*8 +: 8] <= 8'he4;
    else if(in_state[process*8 +: 8] == 8'h6a) out_state[process*8 +: 8] <= 8'h58;
    else if(in_state[process*8 +: 8] == 8'h6b) out_state[process*8 +: 8] <= 8'h05;
    else if(in_state[process*8 +: 8] == 8'h6c) out_state[process*8 +: 8] <= 8'hb8;
    else if(in_state[process*8 +: 8] == 8'h6d) out_state[process*8 +: 8] <= 8'hb3;
    else if(in_state[process*8 +: 8] == 8'h6e) out_state[process*8 +: 8] <= 8'h45;
    else if(in_state[process*8 +: 8] == 8'h6f) out_state[process*8 +: 8] <= 8'h06;
    else if(in_state[process*8 +: 8] == 8'h70) out_state[process*8 +: 8] <= 8'hd0;
    else if(in_state[process*8 +: 8] == 8'h71) out_state[process*8 +: 8] <= 8'h2c;
    else if(in_state[process*8 +: 8] == 8'h72) out_state[process*8 +: 8] <= 8'h1e;
    else if(in_state[process*8 +: 8] == 8'h73) out_state[process*8 +: 8] <= 8'h8f;
    else if(in_state[process*8 +: 8] == 8'h74) out_state[process*8 +: 8] <= 8'hca;
    else if(in_state[process*8 +: 8] == 8'h75) out_state[process*8 +: 8] <= 8'h3f;
    else if(in_state[process*8 +: 8] == 8'h76) out_state[process*8 +: 8] <= 8'h0f;
    else if(in_state[process*8 +: 8] == 8'h77) out_state[process*8 +: 8] <= 8'h02;
    else if(in_state[process*8 +: 8] == 8'h78) out_state[process*8 +: 8] <= 8'hc1;
    else if(in_state[process*8 +: 8] == 8'h79) out_state[process*8 +: 8] <= 8'haf;
    else if(in_state[process*8 +: 8] == 8'h7a) out_state[process*8 +: 8] <= 8'hbd;
    else if(in_state[process*8 +: 8] == 8'h7b) out_state[process*8 +: 8] <= 8'h03;
    else if(in_state[process*8 +: 8] == 8'h7c) out_state[process*8 +: 8] <= 8'h01;
    else if(in_state[process*8 +: 8] == 8'h7d) out_state[process*8 +: 8] <= 8'h13;
    else if(in_state[process*8 +: 8] == 8'h7e) out_state[process*8 +: 8] <= 8'h8a;
    else if(in_state[process*8 +: 8] == 8'h7f) out_state[process*8 +: 8] <= 8'h6b;
    else if(in_state[process*8 +: 8] == 8'h80) out_state[process*8 +: 8] <= 8'h3a;
    else if(in_state[process*8 +: 8] == 8'h81) out_state[process*8 +: 8] <= 8'h91;
    else if(in_state[process*8 +: 8] == 8'h82) out_state[process*8 +: 8] <= 8'h11;
    else if(in_state[process*8 +: 8] == 8'h83) out_state[process*8 +: 8] <= 8'h41;
    else if(in_state[process*8 +: 8] == 8'h84) out_state[process*8 +: 8] <= 8'h4f;
    else if(in_state[process*8 +: 8] == 8'h85) out_state[process*8 +: 8] <= 8'h67;
    else if(in_state[process*8 +: 8] == 8'h86) out_state[process*8 +: 8] <= 8'hdc;
    else if(in_state[process*8 +: 8] == 8'h87) out_state[process*8 +: 8] <= 8'hea;
    else if(in_state[process*8 +: 8] == 8'h88) out_state[process*8 +: 8] <= 8'h97;
    else if(in_state[process*8 +: 8] == 8'h89) out_state[process*8 +: 8] <= 8'hf2;
    else if(in_state[process*8 +: 8] == 8'h8a) out_state[process*8 +: 8] <= 8'hcf;
    else if(in_state[process*8 +: 8] == 8'h8b) out_state[process*8 +: 8] <= 8'hce;
    else if(in_state[process*8 +: 8] == 8'h8c) out_state[process*8 +: 8] <= 8'hf0;
    else if(in_state[process*8 +: 8] == 8'h8d) out_state[process*8 +: 8] <= 8'hb4;
    else if(in_state[process*8 +: 8] == 8'h8e) out_state[process*8 +: 8] <= 8'he6;
    else if(in_state[process*8 +: 8] == 8'h8f) out_state[process*8 +: 8] <= 8'h73;
    else if(in_state[process*8 +: 8] == 8'h90) out_state[process*8 +: 8] <= 8'h96;
    else if(in_state[process*8 +: 8] == 8'h91) out_state[process*8 +: 8] <= 8'hac;
    else if(in_state[process*8 +: 8] == 8'h92) out_state[process*8 +: 8] <= 8'h74;
    else if(in_state[process*8 +: 8] == 8'h93) out_state[process*8 +: 8] <= 8'h22;
    else if(in_state[process*8 +: 8] == 8'h94) out_state[process*8 +: 8] <= 8'he7;
    else if(in_state[process*8 +: 8] == 8'h95) out_state[process*8 +: 8] <= 8'had;
    else if(in_state[process*8 +: 8] == 8'h96) out_state[process*8 +: 8] <= 8'h35;
    else if(in_state[process*8 +: 8] == 8'h97) out_state[process*8 +: 8] <= 8'h85;
    else if(in_state[process*8 +: 8] == 8'h98) out_state[process*8 +: 8] <= 8'he2;
    else if(in_state[process*8 +: 8] == 8'h99) out_state[process*8 +: 8] <= 8'hf9;
    else if(in_state[process*8 +: 8] == 8'h9a) out_state[process*8 +: 8] <= 8'h37;
    else if(in_state[process*8 +: 8] == 8'h9b) out_state[process*8 +: 8] <= 8'he8;
    else if(in_state[process*8 +: 8] == 8'h9c) out_state[process*8 +: 8] <= 8'h1c;
    else if(in_state[process*8 +: 8] == 8'h9d) out_state[process*8 +: 8] <= 8'h75;
    else if(in_state[process*8 +: 8] == 8'h9e) out_state[process*8 +: 8] <= 8'hdf;
    else if(in_state[process*8 +: 8] == 8'h9f) out_state[process*8 +: 8] <= 8'h6e;
    else if(in_state[process*8 +: 8] == 8'ha0) out_state[process*8 +: 8] <= 8'h47;
    else if(in_state[process*8 +: 8] == 8'ha1) out_state[process*8 +: 8] <= 8'hf1;
    else if(in_state[process*8 +: 8] == 8'ha2) out_state[process*8 +: 8] <= 8'h1a;
    else if(in_state[process*8 +: 8] == 8'ha3) out_state[process*8 +: 8] <= 8'h71;
    else if(in_state[process*8 +: 8] == 8'ha4) out_state[process*8 +: 8] <= 8'h1d;
    else if(in_state[process*8 +: 8] == 8'ha5) out_state[process*8 +: 8] <= 8'h29;
    else if(in_state[process*8 +: 8] == 8'ha6) out_state[process*8 +: 8] <= 8'hc5;
    else if(in_state[process*8 +: 8] == 8'ha7) out_state[process*8 +: 8] <= 8'h89;
    else if(in_state[process*8 +: 8] == 8'ha8) out_state[process*8 +: 8] <= 8'h6f;
    else if(in_state[process*8 +: 8] == 8'ha9) out_state[process*8 +: 8] <= 8'hb7;
    else if(in_state[process*8 +: 8] == 8'haa) out_state[process*8 +: 8] <= 8'h62;
    else if(in_state[process*8 +: 8] == 8'hab) out_state[process*8 +: 8] <= 8'h0e;
    else if(in_state[process*8 +: 8] == 8'hac) out_state[process*8 +: 8] <= 8'haa;
    else if(in_state[process*8 +: 8] == 8'had) out_state[process*8 +: 8] <= 8'h18;
    else if(in_state[process*8 +: 8] == 8'hae) out_state[process*8 +: 8] <= 8'hbe;
    else if(in_state[process*8 +: 8] == 8'haf) out_state[process*8 +: 8] <= 8'h1b;
    else if(in_state[process*8 +: 8] == 8'hb0) out_state[process*8 +: 8] <= 8'hfc;
    else if(in_state[process*8 +: 8] == 8'hb1) out_state[process*8 +: 8] <= 8'h56;
    else if(in_state[process*8 +: 8] == 8'hb2) out_state[process*8 +: 8] <= 8'h3e;
    else if(in_state[process*8 +: 8] == 8'hb3) out_state[process*8 +: 8] <= 8'h4b;
    else if(in_state[process*8 +: 8] == 8'hb4) out_state[process*8 +: 8] <= 8'hc6;
    else if(in_state[process*8 +: 8] == 8'hb5) out_state[process*8 +: 8] <= 8'hd2;
    else if(in_state[process*8 +: 8] == 8'hb6) out_state[process*8 +: 8] <= 8'h79;
    else if(in_state[process*8 +: 8] == 8'hb7) out_state[process*8 +: 8] <= 8'h20;
    else if(in_state[process*8 +: 8] == 8'hb8) out_state[process*8 +: 8] <= 8'h9a;
    else if(in_state[process*8 +: 8] == 8'hb9) out_state[process*8 +: 8] <= 8'hdb;
    else if(in_state[process*8 +: 8] == 8'hba) out_state[process*8 +: 8] <= 8'hc0;
    else if(in_state[process*8 +: 8] == 8'hbb) out_state[process*8 +: 8] <= 8'hfe;
    else if(in_state[process*8 +: 8] == 8'hbc) out_state[process*8 +: 8] <= 8'h78;
    else if(in_state[process*8 +: 8] == 8'hbd) out_state[process*8 +: 8] <= 8'hcd;
    else if(in_state[process*8 +: 8] == 8'hbe) out_state[process*8 +: 8] <= 8'h5a;
    else if(in_state[process*8 +: 8] == 8'hbf) out_state[process*8 +: 8] <= 8'hf4;
    else if(in_state[process*8 +: 8] == 8'hc0) out_state[process*8 +: 8] <= 8'h1f;
    else if(in_state[process*8 +: 8] == 8'hc1) out_state[process*8 +: 8] <= 8'hdd;
    else if(in_state[process*8 +: 8] == 8'hc2) out_state[process*8 +: 8] <= 8'ha8;
    else if(in_state[process*8 +: 8] == 8'hc3) out_state[process*8 +: 8] <= 8'h33;
    else if(in_state[process*8 +: 8] == 8'hc4) out_state[process*8 +: 8] <= 8'h88;
    else if(in_state[process*8 +: 8] == 8'hc5) out_state[process*8 +: 8] <= 8'h07;
    else if(in_state[process*8 +: 8] == 8'hc6) out_state[process*8 +: 8] <= 8'hc7;
    else if(in_state[process*8 +: 8] == 8'hc7) out_state[process*8 +: 8] <= 8'h31;
    else if(in_state[process*8 +: 8] == 8'hc8) out_state[process*8 +: 8] <= 8'hb1;
    else if(in_state[process*8 +: 8] == 8'hc9) out_state[process*8 +: 8] <= 8'h12;
    else if(in_state[process*8 +: 8] == 8'hca) out_state[process*8 +: 8] <= 8'h10;
    else if(in_state[process*8 +: 8] == 8'hcb) out_state[process*8 +: 8] <= 8'h59;
    else if(in_state[process*8 +: 8] == 8'hcc) out_state[process*8 +: 8] <= 8'h27;
    else if(in_state[process*8 +: 8] == 8'hcd) out_state[process*8 +: 8] <= 8'h80;
    else if(in_state[process*8 +: 8] == 8'hce) out_state[process*8 +: 8] <= 8'hec;
    else if(in_state[process*8 +: 8] == 8'hcf) out_state[process*8 +: 8] <= 8'h5f;
    else if(in_state[process*8 +: 8] == 8'hd0) out_state[process*8 +: 8] <= 8'h60;
    else if(in_state[process*8 +: 8] == 8'hd1) out_state[process*8 +: 8] <= 8'h51;
    else if(in_state[process*8 +: 8] == 8'hd2) out_state[process*8 +: 8] <= 8'h7f;
    else if(in_state[process*8 +: 8] == 8'hd3) out_state[process*8 +: 8] <= 8'ha9;
    else if(in_state[process*8 +: 8] == 8'hd4) out_state[process*8 +: 8] <= 8'h19;
    else if(in_state[process*8 +: 8] == 8'hd5) out_state[process*8 +: 8] <= 8'hb5;
    else if(in_state[process*8 +: 8] == 8'hd6) out_state[process*8 +: 8] <= 8'h4a;
    else if(in_state[process*8 +: 8] == 8'hd7) out_state[process*8 +: 8] <= 8'h0d;
    else if(in_state[process*8 +: 8] == 8'hd8) out_state[process*8 +: 8] <= 8'h2d;
    else if(in_state[process*8 +: 8] == 8'hd9) out_state[process*8 +: 8] <= 8'he5;
    else if(in_state[process*8 +: 8] == 8'hda) out_state[process*8 +: 8] <= 8'h7a;
    else if(in_state[process*8 +: 8] == 8'hdb) out_state[process*8 +: 8] <= 8'h9f;
    else if(in_state[process*8 +: 8] == 8'hdc) out_state[process*8 +: 8] <= 8'h93;
    else if(in_state[process*8 +: 8] == 8'hdd) out_state[process*8 +: 8] <= 8'hc9;
    else if(in_state[process*8 +: 8] == 8'hde) out_state[process*8 +: 8] <= 8'h9c;
    else if(in_state[process*8 +: 8] == 8'hdf) out_state[process*8 +: 8] <= 8'hef;
    else if(in_state[process*8 +: 8] == 8'he0) out_state[process*8 +: 8] <= 8'ha0;
    else if(in_state[process*8 +: 8] == 8'he1) out_state[process*8 +: 8] <= 8'he0;
    else if(in_state[process*8 +: 8] == 8'he2) out_state[process*8 +: 8] <= 8'h3b;
    else if(in_state[process*8 +: 8] == 8'he3) out_state[process*8 +: 8] <= 8'h4d;
    else if(in_state[process*8 +: 8] == 8'he4) out_state[process*8 +: 8] <= 8'hae;
    else if(in_state[process*8 +: 8] == 8'he5) out_state[process*8 +: 8] <= 8'h2a;
    else if(in_state[process*8 +: 8] == 8'he6) out_state[process*8 +: 8] <= 8'hf5;
    else if(in_state[process*8 +: 8] == 8'he7) out_state[process*8 +: 8] <= 8'hb0;
    else if(in_state[process*8 +: 8] == 8'he8) out_state[process*8 +: 8] <= 8'hc8;
    else if(in_state[process*8 +: 8] == 8'he9) out_state[process*8 +: 8] <= 8'heb;
    else if(in_state[process*8 +: 8] == 8'hea) out_state[process*8 +: 8] <= 8'hbb;
    else if(in_state[process*8 +: 8] == 8'heb) out_state[process*8 +: 8] <= 8'h3c;
    else if(in_state[process*8 +: 8] == 8'hec) out_state[process*8 +: 8] <= 8'h83;
    else if(in_state[process*8 +: 8] == 8'hed) out_state[process*8 +: 8] <= 8'h53;
    else if(in_state[process*8 +: 8] == 8'hee) out_state[process*8 +: 8] <= 8'h99;
    else if(in_state[process*8 +: 8] == 8'hef) out_state[process*8 +: 8] <= 8'h61;
    else if(in_state[process*8 +: 8] == 8'hf0) out_state[process*8 +: 8] <= 8'h17;
    else if(in_state[process*8 +: 8] == 8'hf1) out_state[process*8 +: 8] <= 8'h2b;
    else if(in_state[process*8 +: 8] == 8'hf2) out_state[process*8 +: 8] <= 8'h04;
    else if(in_state[process*8 +: 8] == 8'hf3) out_state[process*8 +: 8] <= 8'h7e;
    else if(in_state[process*8 +: 8] == 8'hf4) out_state[process*8 +: 8] <= 8'hba;
    else if(in_state[process*8 +: 8] == 8'hf5) out_state[process*8 +: 8] <= 8'h77;
    else if(in_state[process*8 +: 8] == 8'hf6) out_state[process*8 +: 8] <= 8'hd6;
    else if(in_state[process*8 +: 8] == 8'hf7) out_state[process*8 +: 8] <= 8'h26;
    else if(in_state[process*8 +: 8] == 8'hf8) out_state[process*8 +: 8] <= 8'he1;
    else if(in_state[process*8 +: 8] == 8'hf9) out_state[process*8 +: 8] <= 8'h69;
    else if(in_state[process*8 +: 8] == 8'hfa) out_state[process*8 +: 8] <= 8'h14;
    else if(in_state[process*8 +: 8] == 8'hfb) out_state[process*8 +: 8] <= 8'h63;
    else if(in_state[process*8 +: 8] == 8'hfc) out_state[process*8 +: 8] <= 8'h55;
    else if(in_state[process*8 +: 8] == 8'hfd) out_state[process*8 +: 8] <= 8'h21;
    else if(in_state[process*8 +: 8] == 8'hfe) out_state[process*8 +: 8] <= 8'h0c;
    else if(in_state[process*8 +: 8] == 8'hff) out_state[process*8 +: 8] <= 8'h7d;

						
						process = process + 5'd1;
					end //if(process<5'd16)
					
					else begin //process>5'd16
						round_process = 4'd5;
						process = 0;
						in_state <= out_state;
					end
				end // else if round_process == 4'd4 // 1. INV Sub Bytes END
				
				else begin  // round_process == 4'd5
					/* 0. next round */
					round_process = 4'd0;
					round = round + 4'd1;
				end // else round_process ==4'd5
			end // if(round<=9) 
			
			else if(round == 4'd10) begin
				/* ROUND 10 => Add Cipher Key */
				out_state <= in_state ^ initial_cipher_key;
				round = round + 4'd1;
			end //else if(round == 4'd10)
			
			else begin // if round > 10 -> return output . reset variables
				/* Return Output, Reset Variables */
				final_state <= out_state;
			end // else (round>10) 
		end //if(!encrypt)
		
	
	end 

	
endmodule



