#!/bin/bash
rm -f catboard.blif
yosys -q -p "synth_ice40 -blif catboard.blif"  speechfifo.v txuart.v rxuart.v ufifo.v wbuart.v 


