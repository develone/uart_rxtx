module uart_loopback
  (input  i_clk,       // Main Clock
   input  i_uart_rx,   // UART RX Data
   output o_uart_tx   // UART TX Data
   
   ); 
   uart_tx dut_tx(
    .i_Clock(i_clk),
    .i_TX_DV(r_TX_DV),
    .i_TX_Byte(r_TX_Byte),
    .o_TX_Active(w_TX_Active),
	.o_uart_tx(w_TX_Serial),
    .o_TX_Done()
  );
  uart_rx dut_rx(
    .i_Clock(i_clk),
    .i_uart_rx(w_UART_Line),
    .o_RX_DV(w_RX_DV),
    .o_RX_Byte(w_RX_Byte)
  );
  wire w_RX_DV;
  wire [7:0] w_RX_Byte;
  wire w_TX_Active, w_TX_Serial;
 
 
   
  // 25,000,000 / 115,200 = 217
 
   
  // Drive UART line high when transmitter is not active
  assign o_UART_TX = w_TX_Active ? w_TX_Serial : 1'b1; 
   
   
   
endmodule
// File: uart_tx.v
// Generated by MyHDL 1.0dev
// Date: Thu Apr 26 23:58:17 2018


`timescale 1ns/10ps

module uart_tx (
    i_Clock,
    i_TX_DV,
    i_TX_Byte,
    o_TX_Active,
    o_uart_tx,
    o_TX_Done
);


input i_Clock;
input i_TX_DV;
input [7:0] i_TX_Byte;
output o_TX_Active;
reg o_TX_Active;
output o_uart_tx;
reg o_uart_tx;
output o_TX_Done;
reg o_TX_Done;

reg [7:0] r_Clock_Count;
reg [2:0] r_Bit_Index;
reg [7:0] r_TX_data;
reg r_TX_Active;
reg [2:0] r_SM_Main;
reg r_TX_Done;



always @(posedge i_Clock) begin: UART_TX_SEND
    case (r_SM_Main)
        'h0: begin
            // Drive Line High for IDLE
            o_uart_tx <= 1;
            r_TX_Done <= 0;
            r_Bit_Index <= 0;
            r_Clock_Count <= 0;
            if ((i_TX_DV == 1)) begin
                r_TX_Active <= 1;
                r_TX_data <= i_TX_Byte;
                r_SM_Main <= 1;
            end
            else begin
                r_SM_Main <= 0;
                // End of IDLE
            end
        end
        'h1: begin
            o_uart_tx <= 0;
            if (($signed({1'b0, r_Clock_Count}) < (217 - 1))) begin
                r_Clock_Count <= (r_Clock_Count + 1);
                r_SM_Main <= 1;
            end
            else begin
                r_Clock_Count <= 0;
                r_SM_Main <= 2;
            end
        end
        'h2: begin
            o_uart_tx <= r_TX_data[r_Bit_Index];
            if (($signed({1'b0, r_Clock_Count}) < (217 - 1))) begin
                r_Clock_Count <= (r_Clock_Count + 1);
                r_SM_Main <= 2;
            end
            else begin
                r_Clock_Count <= 0;
                if ((r_Bit_Index < 7)) begin
                    r_Bit_Index <= (r_Bit_Index + 1);
                    r_SM_Main <= 2;
                end
                else begin
                    r_Bit_Index <= 0;
                    r_SM_Main <= 3;
                end
            end
        end
        'h3: begin
            o_uart_tx <= 1;
            if (($signed({1'b0, r_Clock_Count}) < (217 - 1))) begin
                r_Clock_Count <= (r_Clock_Count + 1);
                r_SM_Main <= 3;
            end
            else begin
                r_TX_Done <= 1;
                r_Clock_Count <= 0;
                r_SM_Main <= 4;
                r_TX_Active <= 0;
            end
        end
        'h4: begin
            r_TX_Done <= 1;
            r_SM_Main <= 0;
        end
        default: begin
            r_SM_Main <= 0;
        end
    endcase
    o_TX_Active <= r_TX_Active;
    o_TX_Done <= r_TX_Done;
end

endmodule
// File: uart_rx.v
// Generated by MyHDL 1.0dev
// Date: Thu Apr 26 23:58:09 2018


`timescale 1ns/10ps

module uart_rx (
    i_Clock,
    i_uart_rx,
    o_RX_DV,
    o_RX_Byte
);


input i_Clock;
input i_uart_rx;
output o_RX_DV;
reg o_RX_DV;
output [7:0] o_RX_Byte;
reg [7:0] o_RX_Byte;

reg r_RX_DV;
reg [2:0] r_SM_Main;
reg [7:0] r_Clock_Count;
reg [2:0] r_Bit_Index;
reg [7:0] r_RX_Byte;



always @(posedge i_Clock) begin: UART_RX_RECV
    case (r_SM_Main)
        'h0: begin
            // Drive Line High for IDLE
            r_RX_DV <= 0;
            r_Bit_Index <= 0;
            r_Clock_Count <= 0;
            if ((i_uart_rx == 0)) begin
                r_SM_Main <= 1;
            end
            else begin
                r_SM_Main <= 0;
            end
        end
        'h1: begin
            if (($signed({1'b0, r_Clock_Count}) == ((217 - 1) / 2))) begin
                if ((i_uart_rx == 0)) begin
                    r_Clock_Count <= 0;
                    r_SM_Main <= 2;
                end
                else begin
                    r_SM_Main <= 0;
                end
            end
            else begin
                r_Clock_Count <= (r_Clock_Count + 1);
                r_SM_Main <= 1;
            end
        end
        'h2: begin
            if (($signed({1'b0, r_Clock_Count}) < (217 - 1))) begin
                r_Clock_Count <= (r_Clock_Count + 1);
                r_SM_Main <= 2;
            end
            else begin
                r_Clock_Count <= 0;
                r_RX_Byte[r_Bit_Index] <= i_uart_rx;
                if ((r_Bit_Index < 7)) begin
                    r_Bit_Index <= (r_Bit_Index + 1);
                    r_SM_Main <= 2;
                end
                else begin
                    r_Bit_Index <= 0;
                    r_SM_Main <= 3;
                end
            end
        end
        'h3: begin
            if (($signed({1'b0, r_Clock_Count}) < (217 - 1))) begin
                r_Clock_Count <= (r_Clock_Count + 1);
                r_SM_Main <= 3;
            end
            else begin
                r_RX_DV <= 1;
                r_Clock_Count <= 0;
                r_SM_Main <= 4;
            end
        end
        'h4: begin
            r_SM_Main <= 0;
            r_RX_DV <= 0;
        end
        default: begin
            r_SM_Main <= 0;
        end
    endcase
    o_RX_DV <= r_RX_DV;
    o_RX_Byte <= r_RX_Byte;
end

endmodule
