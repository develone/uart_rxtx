#include <wiringPi.h>
#include <stdio.h>
#include <unistd.h>

//gcc -Wall -o rd_byte rd_byte.c -lwiringPi
//sudo ./rd_byte

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
  //char	datab = 0;
  wiringPiSetup () ;
  pinMode (RASPI_D0, INPUT) ;
  pinMode (RASPI_D1, INPUT) ;
  pinMode (RASPI_D2, INPUT) ;
  pinMode (RASPI_D3, INPUT) ;  
  pinMode (RASPI_D4, INPUT) ;
  pinMode (RASPI_D5, INPUT) ;
  pinMode (RASPI_D6, INPUT) ;
  pinMode (RASPI_D7, INPUT) ;  
  for (;;)
  {
	/*		
    if (digitalRead(RASPI_D7))	datab |= 0x80;
	if (digitalRead(RASPI_D6))	datab |= 0x40;
	if (digitalRead(RASPI_D5))	datab |= 0x20;
	if (digitalRead(RASPI_D4))	datab |= 0x10;
	if (digitalRead(RASPI_D3))	datab |= 0x08;
	if (digitalRead(RASPI_D2))	datab |= 0x04;
	if (digitalRead(RASPI_D1))	datab |= 0x02;
	if (digitalRead(RASPI_D0))	datab |= 0x01;
    printf("pin being rd 0x%x \n", datab);
    */
    printf("%d%d%d%d", digitalRead(RASPI_D7),digitalRead(RASPI_D6),digitalRead(RASPI_D5),digitalRead(RASPI_D6));
    printf("%d%d%d%d\n", digitalRead(RASPI_D3),digitalRead(RASPI_D2),digitalRead(RASPI_D1),digitalRead(RASPI_D0));
    //sleep(1);
  }
  return 0 ;
}
