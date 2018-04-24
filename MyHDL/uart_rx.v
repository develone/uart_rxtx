// File: uart_rx.v
// Generated by MyHDL 1.0dev
// Date: Tue Apr 24 10:56:44 2018


`timescale 1ns/10ps

module uart_rx (
    i_Clock,
    i_RX_Serial,
    o_RX_DV,
    o_RX_Byte
);


input i_Clock;
input i_RX_Serial;
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
            if ((i_RX_Serial == 0)) begin
                r_SM_Main <= 1;
            end
            else begin
                r_SM_Main <= 0;
            end
        end
        'h1: begin
            if (($signed({1'b0, r_Clock_Count}) == ((217 - 1) / 2))) begin
                if ((i_RX_Serial == 0)) begin
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
                r_RX_Byte[r_Bit_Index] <= i_RX_Serial;
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
