#!/bin/bash
rm -f catboard.txt
arachne-pnr  -d 8k -p catboard.pcf -o catboard.txt catboard.blif

