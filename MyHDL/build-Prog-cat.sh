#!/bin/bash
if [ $1 = "3" ]; then
	echo "creating the blif file"
	./uart_txrx.sh
	if [ -e uart_loopback.blif ]; then
		echo "creating the txt file"
		./uart_txrx_pnr.sh
		if [ -e uart_loopback.txt ]; then
			echo "creating the bin file"
			./uart_txrx_bin.sh
			if [ -e uart_loopback.bin ]; then
				echo "bin file created"
				echo "programming the catboard"
				sudo ~/catboard_yosys/config_cat uart_loopback.bin
				
			else
				echo "no uart_loopback.bin file"
			fi
		else
			echo "no uart_loopback.txt file"
		fi
	fi 
		 
else
	if [ $1 = "1" ]; then
		echo "creating the blif file"
		./uart_txrx.sh
		if [ -e uart_loopback.blif ]; then
			echo "creating the txt file"
			./uart_txrx_pnr.sh
			if [ -e uart_loopback.txt ]; then
				echo "creating the bin file"
				./uart_txrx_bin.sh
				if [ -e uart_loopback.bin ]; then
					echo "bin file created"
				 
				
				else
					echo "no uart_loopback.bin file"
				fi
			else
				echo "no uart_loopback.txt file"
			fi
		fi
	
	else
		if [ $1 = "2" ]; then
			echo "programming the catboard"
			sudo ~/catboard_yosys/config_cat catboard.bin
		else
			echo "not a valid options"
		fi
	fi
fi
