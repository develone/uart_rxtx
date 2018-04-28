#!/bin/bash
rm -f uart_loopback.blif
yosys -q -p "synth_ice40 -blif uart_loopback.blif" uart_loopback.v \
uart_rx.v uart_tx.v
