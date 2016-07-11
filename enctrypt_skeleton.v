module aes_algorithm_one(clock,initial_state,final_state);
	input clock;
	input [127:0] initial_state;
	
	reg [127:0] cipher_key=128'h2b28ab097eaef7cf15d2154f16a6883c; //use
	reg [127:0] round_key; // use
	
	
	reg [127:0] in_state=128'h328831e0435a3137f6309807a88da234; //delete
	reg [127:0] out_state; // use (or delete)
	
	reg [7:0] two_A0,two_A1,two_A2,two_A3; //use
	reg [7:0] three_A0,three_A1,three_A2,three_A3; //use
	
	reg [31:0] temp_round; //use( or delete )
	
	reg [7:0] r_con; //use (or delete)


	output reg[127:0] final_state; //use

	reg [3:0] round=4'd0; //use(or reduce)
	reg [3:0] round_process=4'd0;  //use (or reduce)
	// 1. subBytes 2. shift Row 3. MixColumn 4. Add Round Key
	reg [4:0] process=5'd0; // box 1 to 16  //use (or reduce)
	reg [4:0] process1=5'd0; //use (or reduce
	reg [2:0] process2 = 3'd0; // for round_key
	reg encrypt=1'b1;
	
	reg [127:0] dec_in_state=128'h3902dc1925dc116a8409850b1dfb9732;
	
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
				
					 process = process + 5'd1;
				end 
				
				else begin process = 0; round_process=4'd3; in_state <= out_state; end 
				
			end //else if(round_process==4'd2)
			
			else if(round_process==4'd3) begin // 3. Mix Columns
				if(round != 10) begin 
					if(process < 5'd4) begin 
						if(process1 ==5'd0) begin 

						process1 = process1 + 5'd1;
						
						end // if(process1 <5'd1) begin 
						
						else if(process1 == 5'd1) begin 
						process1 = process1 + 5'd1;
						end 
						

						else begin  //process == 2
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
			
						process1 = 5'd1;
						//process2 = 0;
					end // if(process1 == 5'd0)
					
					else if(process1 == 5'd1) begin  // 4.2 sub Bytes
						if(process2 < 3'd4) begin 
	

							process2 = process2 + 3'd1;
							end // if(process2 <= 2'd3) begin 
						else begin // if(process2 <= 2'd3) begin 
							process1 = 5'd2;
						end 
						
					end 
					
					else if(process1 == 5'd2) begin // 4.3 add Rcon and make 1'
						
						process1 =5'd3;
					end
					
					else if(process1 == 5'd3) begin // 4.4 2' = 2+1'
		
						
						process1 = 5'd4;
					end 
					
					else if(process1 == 5'd4) begin // 4.5 3' = 3+2'
				
						process1 = 5'd5;
					end
					
					else if(process1 == 5'd5) begin // 4.6 4' = 4+3'
						
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
		
		else begin //round>10 -> reset variables
			final_state<=out_state;
		end 
		end

	end // always @(posedge clock)
	
	
endmodule



