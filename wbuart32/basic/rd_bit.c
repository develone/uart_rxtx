#include <wiringPi.h>
#include <stdio.h>

//gcc -Wall -o rd_bit rd_bit.c -lwiringPi
//sudo ./blink

#  define RASPI_DIR 28 //BCM20 	PIN 38, GPIO.28 IOB_59  R3
#  define RASPI_CLK 10 //BCM8 	PIN 24, GPIO.10, IOB_75	T8

#  define RASPI_D0 27 //BCM16 	PIN 36, GPIO.27, IOB_63	R4
#  define RASPI_D1 24 //BCM19 	PIN 35, GPIO.24, IOB_61	T3
#  define RASPI_D2 0 //BCM17 	PIN 11, GPIO.0 ,IOB_94	T13
 
#  define RASPI_D3 21 //BCM5   PIN  29,GPIO.21 ,IOB_73	T6
 
#  define RASPI_D4 22 //BCM6    PIN 31,GPIO.22 ,IOB_69	T5
#  define RASPI_D5 4 //BCM23 	PIN 16,GPIO.4, IOB_83	P9
 
#  define RASPI_D6 5 //BCM24 	PIN 18, GPIO.5, IOB_79	T9
#  define RASPI_D7 1  //BCM18 	pin 12, GPIO.1, IOB_89	T11
#  define RASPI_D8 11 //BCM7 	PIN 26, GPIO.11, IOB_75	T7
int main (void)
{
  wiringPiSetup () ;
  pinMode (RASPI_CLK, INPUT) ;
  for (;;)
  {
 
    printf("pin being rd %d \n", digitalRead(RASPI_CLK));
  }
  return 0 ;
}
