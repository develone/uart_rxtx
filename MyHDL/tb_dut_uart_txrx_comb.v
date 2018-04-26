
`include "uart_txrx.v" 
module tb_uart_txrx;

 
  parameter c_CLOCK_PERIOD_NS = 10;
  parameter c_CLKS_PER_BIT    = 217;
  //parameter c_BIT_PERIOD      = 8600;
  reg r_Clock = 0;
  reg r_TX_DV = 0;
  wire w_TX_Active, w_UART_Line;
  wire w_RX_Serial;
  reg [7:0] r_TX_Byte = 0;
  wire [7:0] w_RX_Byte;
  wire w_RX_DV;
  uart_txrx dut(
    .i_clk(r_Clock),
    .i_uart_rx(w_UART_Line),
    .o_uart_tx(w_TX_Serial)
  );
  assign w_TX_Serial = 1'b1;
  assign w_TX_Active = 1'b1;
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
      
      // Check that the correct command was received
      @(posedge w_RX_DV);
      if (w_RX_Byte == 8'h3F)
        $display("Test Passed - Correct Byte Received");
      else
        $display("Test Failed - Incorrect Byte Received");
  
      $finish();
    end


  initial 
  begin
    // Required to dump signals to EPWave
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
endmodule
