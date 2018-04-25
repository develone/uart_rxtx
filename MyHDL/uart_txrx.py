from myhdl import block, always, Signal, instance, delay, Simulation, intbv

from uart_tx import *
from uart_rx import *




	
@block
def uart_txrx(i_clk,i_uart_rx,o_uart_tx):
 
	i_TX_DV = Signal(bool(0))
	o_TX_Done = Signal(bool(0))
	#o_TX_Serial = Signal(bool(0))
	o_TX_Active = Signal(bool(0))
	#i_Clock  = Signal(bool(0))
	i_TX_Byte = Signal(intbv(0)[8:])
	i_Clock = Signal(bool(0))
	o_RX_DV = Signal(bool(0))
	#i_RX_Serial = Signal(bool(0))
	#i_Clock  = Signal(bool(0))
	o_RX_Byte = Signal(intbv(0)[8:])

	
 
	uart_tx_inst = uart_tx(i_clk,i_TX_DV,i_TX_Byte,o_TX_Active,o_uart_tx,o_TX_Done,CLKS_PER_BIT=217)
	uart_rx_inst = uart_rx(i_clk,i_uart_rx,o_RX_DV,o_RX_Byte,CLKS_PER_BIT=217)
	
	return uart_tx_inst, uart_rx_inst

def convert_uart(hdl):
	"""Convert inc block to Verilog or VHDL."""
	i_clk = Signal(bool(0))
	o_uart_tx = Signal(bool(0))
	i_uart_rx = Signal(bool(0))
	
	uart_txrx_inst = uart_txrx(i_clk,i_uart_rx,o_uart_tx)
	uart_txrx_inst.convert(hdl=hdl)
convert_uart(hdl='Verilog')
