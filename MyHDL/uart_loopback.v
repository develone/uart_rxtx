module uart_loopback
  (input  i_Clk,       
   input  i_uart_rx,   
   output o_uart_tx   
   
   ); 
// Main Clock  
// UART RX Data
// UART TX Data
 
  wire w_RX_DV;
  wire [7:0] w_RX_Byte;
  wire w_TX_Active, w_TX_Serial;
   
   uart_rx uart_rx_inst(
    .i_Clock(i_Clk),
    .i_RX_Serial(i_uart_rx),
    .o_RX_DV(w_RX_DV),
    .o_RX_Byte(w_RX_Byte)

    
  );
   uart_tx uart_tx_inst(
   .i_Clock(i_Clk),
    .i_TX_DV(w_RX_DV),
    .i_TX_Byte(w_RX_Byte),
    .o_TX_Active(w_TX_Active),
	.o_TX_Serial(w_TX_Serial),
    .o_TX_Done()

  );


 
 
   
  // 25,000,000 / 115,200 = 217
 
   
  // Drive UART line high when transmitter is not active
  assign o_uart_tx = w_TX_Active ? w_TX_Serial : 1'b1; 
   
   
   
endmodule
 
