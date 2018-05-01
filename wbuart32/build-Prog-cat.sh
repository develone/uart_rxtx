#!/bin/bash
if [ $1 = "3" ]; then
	echo "creating the blif file"
	./helloworld.sh
	if [ -e catboard.blif ]; then
		echo "creating the txt file"
		./helloworld_pnr.sh
		if [ -e catboard.txt ]; then
			echo "creating the bin file"
			./helloworld_bin.sh
			if [ -e catboard.bin ]; then
				echo "bin file created"
				echo "programming the catboard"
				sudo ~/catboard_yosys/config_cat catboard.bin
				
			else
				echo "no catboard.bin file"
			fi
		else
			echo "no catboard.txt file"
		fi
	fi 
		 
else
	if [ $1 = "1" ]; then
		echo "creating the blif file"
		./helloworld.sh
		if [ -e catboard.blif ]; then
			echo "creating the txt file"
			./helloworld_pnr.sh
			if [ -e catboard.txt ]; then
				echo "creating the bin file"
				./helloworld_bin.sh
				if [ -e catboard.bin ]; then
					echo "bin file created"
				 
				
				else
					echo "no catboard.bin file"
				fi
			else
				echo "no catboard.txt file"
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
