/*****************************************************************//**
 * @file main_vanilla_test.cpp
 *
 * @brief Basic test of 4 basic i/o cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

//#define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include "sseg.h"

// instantiate switch, led
GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));

int main()
{
	uint32_t sw_val;

	uart.disp("Hello world!\r\n");
	setRefresh(1000);

	for(;;)
	{
		sw_val = sw.read();
		setSSEG(sw_val);
	}
} //main

