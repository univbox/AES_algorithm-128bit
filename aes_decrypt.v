reg [127:0] initial_cipher_key=128'h2b28ab097eaef7cf15d2154f16a6883c;

reg [3:0] key_round = 4'd0;

always @(posedge clock)
	begin
		if(!encrypt) begin // If Decrypt mode
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
							
							
							process1 = 5'd7;
						end // (process1 == 5'd6) END 
						
						else begin // process1 = 5'd7 
							round_process = round_process + 4'd1;
							key_round = key_round +4'd1;
						end  //// process1 = 5'd7 
						
						
						
					end //if(key_round <= 4'd10-round)
					
					else if(key_round == 4'd10-round) begin // if key_round > 10-round go to next stage
						/* 4.4 Add Round Key to dec_in_state */
						out_state <= in_state ^ round_key;// Add Round Key
						key_round = key_round +4'd1;
						
					end // else if (key_round == 4'd10)
					
					else begin // key_round > 10-round
						/* out_state -> in_state, reset variables , 
						go next stage 3.INV MIX COLUMN */
						key_round >= 0;
						in_state <= out_state;
						cipher_key <= initial_cipher_key;
						round_process = round_process + 4'd1;
					end  //key_round > 10-round
				
				end //else if(round_process==1) 4. Add Round KEY END 
				
				else if(round_process == 4'd2) begin // 3. INV Mix Column
					if(round != 4'd0) begin // If round is 1 to 9
						/* 3. INV Mix Column */
					end // if(round != 4'd0)
					
					else begin// if(round == 0) 
						/* SKIP INV MIX COULMN */
						
						round_process <= round_process +1; // go to next round process (2.INV Shift rows)
					end // else begin (if(round==0))
				end // else if(round_process == 4'd2) // 3. INV MIX COLUMN END
				
				else if(round_process == 4'd3) begin //2. INV Shift rows
					/* 2. INV Shift Rows */
				end // else if(round_process == 4'd4) // 2. INV SHIFT Rows END
				
				else if(round_process == 4'd4) begin // 1. Inv Sub Bytes
					/* 1. INV Sub Bytes */
				end // else if round_process == 4'd4 // 1. INV Sub Bytes END
				
				else begin  // round_process == 4'd5
					/* 0. next round */
					round_process = 4'd0;
					round = round + 4'd1;
				end // else round_process ==4'd5
			end // if(round<=9) 
			
			else if(round == 4'd10) begin
				/* ROUND 10 => Add Cipher Key */
				out_state <= dec_in_state ^ initial_cipher_key
			end //else if(round == 4'd10)
			
			else begin // if round > 10 -> return output . reset variables
				/* Return Output, Reset Variables */
			end // else (round>10) 
		end //if(!encrypt)
		
	
	end 
