#!/bin/bash
rm -f catboard.blif
yosys -q -p "synth_ice40 -blif catboard.blif" UART_Loopback_Top.v \
UART_RX.v UART_TX.v 



