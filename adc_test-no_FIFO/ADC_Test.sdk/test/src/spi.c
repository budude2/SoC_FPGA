/*
 * spi.c
 *
 *  Created on: Nov 26, 2018
 *      Author: Jacob
 */

#include <xparameters.h>
#include "xil_io.h"
#include "sleep.h"

#define BASE_ADDR 	XPAR_SPI_3_WIRE_0_S00_AXI_BASEADDR

// Setup register map
#define SPI_MODE 	 BASE_ADDR			// CPOL (bit 0), CPHA (bit 1)
#define SPI_CONTR 	(BASE_ADDR | 0x4)	// En (bit 0), RW (bit 1)
#define TX_CMD 		(BASE_ADDR | 0x8)
#define TX_DATA 	(BASE_ADDR | 0xC)
#define RX_DATA 	(BASE_ADDR | 0x10)

void spi_init()
{
	Xil_Out32(SPI_MODE,  0x03); // Set CPOL and CPHA to 1
}

void spi_write(uint32_t txAddr, uint32_t txData)
{
	Xil_Out32(TX_CMD, 	 txAddr);
	Xil_Out32(TX_DATA, 	 txData);
	Xil_Out32(SPI_CONTR, 0x03);   // Enable and set to write
	usleep(1);
	Xil_Out32(SPI_CONTR, 0x00);   // Disable
}

unsigned int spi_read(uint32_t rxAddr)
{
    unsigned int data;
	Xil_Out32(TX_CMD, 	 0x8000 | rxAddr); // Need to set the top bit to 1 to tell the ADC it's a read
    Xil_Out32(SPI_CONTR, 0x01);			   // Enable and set to read
    Xil_Out32(SPI_CONTR, 0x00);			   // Disable

    usleep(1000);	// Need to replace this with an interrupt at some point

    data = Xil_In32(RX_DATA);

    return data;
}
