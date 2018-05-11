#!/bin/bash
rm -f catboard.asc
arachne-pnr  -d 8k -p catboard.pcf -o catboard.asc catboard.blif

