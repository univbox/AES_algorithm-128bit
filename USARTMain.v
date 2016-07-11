module USARTMain(
     input RESET,
    input CLK,
    input RXD,
    output TXD
    );
     
    parameter CLOCKS_PER_BIT = 2604;        // baud rate : 19200, Clock : 50MHz, 20ns 19200:  2604.16 -> 2604  9600: 5208.33 -> 5208
    parameter CLOCKS_WAIT_FOR_RECEIVE = 1302;
    parameter MAX_TX_BIT_COUNT = 9;
    parameter MAX_DATA_BUFFER_INDEX = 15;
     
    reg [11:0] tx_clk_count;        // clock count
    reg [3:0]  tx_bit_count;        // bit count [start bit | d0 | d1 | d2 | d3 | d4 | d5 | d6 | d7 | stop bit]
    reg [3:0]  data_buffer_index;
    reg [3:0]  data_buffer_base;
     
    reg [7:0] data_buffer [0:MAX_DATA_BUFFER_INDEX];        // data buffer
    reg [7:0] data_tx;          // data to transmit
     
    reg [7:0] rx_data;
    reg [3:0] rx_bit_count;
    reg [11:0] rx_clk_count;
 
    reg state_rx;
    reg tx_bit;
     
    aes_algorithm_one(CLK,initial_state,final_state);
    
    
    // Transmitter Process
    // at every rising edge of the clock
    always @ (posedge CLK)
    begin
        if(RESET == 1)begin
            tx_clk_count = 0;
            tx_bit_count = 0;
            tx_bit = 1;                     // set idle
            data_buffer_index = 0;          // data index
        end
        else begin
            // transmit data until the index became the same with the base index
            if ( data_buffer_index != data_buffer_base ) begin
                if (tx_clk_count == CLOCKS_PER_BIT) begin
                    if (tx_bit_count == 0) begin
                        tx_bit = 1;     // idle bit
                        tx_bit_count = 1;
                        data_tx = data_buffer[data_buffer_index];
                    end
                    else if (tx_bit_count == 1) begin
                        tx_bit = 0;     // start bit
                        tx_bit_count = 2;
                    end
                    else if (tx_bit_count <= MAX_TX_BIT_COUNT) begin
                        tx_bit = data_tx[tx_bit_count-2];   // data bits
                        tx_bit_count = tx_bit_count + 1;
                    end
                    else begin
                        tx_bit = 1;     // stop bit
                        data_buffer_index = data_buffer_index + 1;  // if the index exceeds its maximum, it becomes 0.
                        tx_bit_count = 0;
                    end
                    tx_clk_count = 0;   // reset clock count
                end
                 
                tx_clk_count = tx_clk_count + 1;        // increase clock count
            end
        end
    end
     
    // Receiver Processs
    // at every rising edge of the clock
    always @ (posedge CLK)
    begin
        if (RESET == 1) begin
            rx_clk_count = 0;
            rx_bit_count = 0;
            data_buffer_base = 0;               // base index
         
            state_rx = 0;
        end
        else begin
            // if not receive mode and start bit is detected
            if (state_rx == 0 && RXD == 0) begin
                state_rx = 1;       // enter receive mode
                rx_bit_count = 0;
                rx_clk_count = 0;
            end
            // if receive mode
            else if (state_rx == 1) begin
                 
                if(rx_bit_count == 0 && rx_clk_count == CLOCKS_WAIT_FOR_RECEIVE) begin
                    rx_bit_count = 1;
                    rx_clk_count = 0;
                end
                else if(rx_bit_count < 9 && rx_clk_count == CLOCKS_PER_BIT) begin

                    rx_data[rx_bit_count-1] = RXD;
                    rx_bit_count = rx_bit_count + 1;
                    rx_clk_count = 0;

                end
                // stop receiving
                else if(rx_bit_count == 9 && rx_clk_count == CLOCKS_PER_BIT && RXD == 1) begin
                    state_rx = 0;
                    rx_clk_count = 0;
                    rx_bit_count = 0;
                     
                    // transmit the received data back to the host PC.
                 
						if(rx_data >= 8'b1100001 && rx_data <= 8'b1111010) begin  // if the data is a to z convert to A to Z
							rx_data = rx_data & 7'b1011111;
						end
						
						
						if(rx_data == 8'b0001101) begin // if the data is CR transmit CR and LF
							data_buffer[data_buffer_base] = rx_data;
							data_buffer[data_buffer_base+1] = 8'b0001010;
							data_buffer_base = data_buffer_base + 2; 
						end                     
					
					else begin 
                    data_buffer[data_buffer_base] = rx_data;
                    data_buffer_base = data_buffer_base + 1;        // if the index exceeds its maximum, it becomes 0.
					end
                end
                // if stop bit is not received, clear the received data
                else if(rx_bit_count == 9 && rx_clk_count == CLOCKS_PER_BIT && RXD != 1) begin
                    state_rx = 0;
                    rx_clk_count = 0;
                    rx_bit_count = 0;
                    rx_data = 8'b00000000;      // invalidate
                end
                rx_clk_count = rx_clk_count + 1;
            end
        end
         
    end
     
    assign TXD = tx_bit;
     
endmodule

