/*
 * verifyCode.c
 *
 * Created: 2/25/2018 11:41:54 PM
 * Author : Oji
 */ 

#include <avr/io.h>
#include <stdint.h>


int main(void)
{
	uint16_t Ysum = 0, Zsum = 0;
	uint8_t array0[300];	//X
	uint8_t array1[300];	//Y
	uint8_t array2[300];	//Z
	
	//Checking Task 1
	for(uint8_t i =1; i<300; i++){
		array0[i] =i;
    }
	//Checking Task 2
	for(uint16_t i = 0; i < 300; i++){
		if(array0[i] %5 == 0){
			array1[i] = i;
		}
		else{
			array2[i] = i;
		}
	}
	//Checking Task 3
	int array1size = sizeof(array1);
	for(uint8_t i = 0; i < array1size; i++){
		Ysum = Ysum + array1[i];		
	}
	int array2size = sizeof(array2);
	for(uint8_t i = 0; i < array2size; i++){
		Zsum = Zsum + array2[i];
	}
	
}

