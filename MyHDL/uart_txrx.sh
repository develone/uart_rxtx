#!/bin/bash
rm -f uart_txrx.blif
yosys -q -p "synth_ice40 -blif uart_txrx.blif" uart_txrx.v 



