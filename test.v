module test;
	reg clock;
	reg [127:0] in_state;
	wire [127:0] final_state;
	
	
	//aes_algorithm(clock,in_state,final_state);;
	aes_algorithm_one AES(clock,in_state,final_state);
	
	always #20 clock =~clock;
	
	
	
	initial begin
		clock = 0;

		
	
		
	end
		
	
endmodule
