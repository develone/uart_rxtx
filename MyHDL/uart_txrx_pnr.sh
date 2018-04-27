#!/bin/bash
rm -f uart_loopback.txt
arachne-pnr  -d 8k -p uart_loopback.pcf -o uart_loopback.txt uart_loopback.blif

