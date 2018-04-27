
`include "uart_txrx.v" 
module tb_uart_txrx;

 
  parameter c_CLOCK_PERIOD_NS = 10;
  parameter c_CLKS_PER_BIT    = 217;
  //parameter c_BIT_PERIOD      = 8600;
  //r_loop used to increment the r_Clock
  reg [11:0] r_loop;
  
  //used to drive the i_clk
  reg r_Clock = 0;
  
  //used to connect the i_uart_rx
  wire w_UART_Line; 
  
  //used to connect the w_TX_Serial
  wire w_RX_Serial;
  
  //used to connect the i_TX_DV
  reg r_TX_DV = 0;
  
  uart_txrx dut(
    .i_clk(r_Clock),
    .i_uart_rx(w_UART_Line),
    .o_uart_tx(w_TX_Serial)
  );
 
  //wire i_TX_DV;
  //wire [7:0] i_TX_Byte; 
  
  //wire i_TX_DV;
  wire [7:0] i_TX_Byte;   
  
  //reg r_TX_DV = 0;
  reg [7:0] r_TX_Byte = 0;
  //wire [7:0] w_RX_Byte;

  //assign w_RX_DV = 1'b0;
  assign w_TX_Active = 1'b1;
  assign i_TX_DV = r_TX_DV;
  //assign i_TX_DV = r_TX_DV ? r_TX_DV : 1'b0;
  // Keeps the UART Receive input high (default) when
  // UART transmitter is not active
  assign w_UART_Line = w_TX_Active ? w_TX_Serial : 1'b1;
  always
    #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;
  // Main Testing:
  initial
    begin
      // Tell UART to send a command (exercise TX)
      @(posedge r_Clock);
      @(posedge r_Clock);
      r_TX_DV   <= 1'b1;
      r_TX_Byte <= 8'h3F;
      @(posedge r_Clock);
      r_TX_DV <= 1'b0;
      for (r_loop = 0; r_loop <= 1736 ; r_loop =r_loop + 1) begin
       @(posedge r_Clock);
 
      end  
      // Check that the correct command was received
      //@(posedge w_RX_DV);
      //if (w_RX_Byte == 8'h3F)
        //$display("Test Passed - Correct Byte Received");
      //else
        //$display("Test Failed - Incorrect Byte Received");
  
      $finish();
    end


  initial 
  begin
    // Required to dump signals to EPWave
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
endmodule
