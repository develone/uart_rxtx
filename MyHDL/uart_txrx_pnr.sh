#!/bin/bash
rm -f uart_txrx.txt
arachne-pnr  -d 8k -p uart_txrx.pcf -o uart_txrx.txt uart_txrx.blif

