/*
 * sseg.c
 *
 *  Created on: Nov 28, 2018
 *      Author: bolinej
 */

#include "chu_io_map.h"
#include "chu_io_rw.h"
#include <stdint.h>
#include "sseg.h"

void setSSEG(uint32_t dispData)
{
	uint32_t addr;
	addr = get_slot_addr(BRIDGE_BASE, S8_SSEG);

	io_write(addr, dispDataReg, dispData);
}

uint32_t getSSEG(void)
{
	uint32_t addr;
	addr = get_slot_addr(BRIDGE_BASE, S8_SSEG);

	return io_read(addr, dispDataReg);
}

void setRefresh(uint16_t refreshRate)
{
	uint32_t addr;
	addr = get_slot_addr(BRIDGE_BASE, S8_SSEG);

	io_write(addr, refreshDataReg, (uint32_t) refreshRate);
}

uint16_t getRefresh(void)
{
	uint32_t addr;
	addr = get_slot_addr(BRIDGE_BASE, S8_SSEG);

	return io_read(addr, refreshDataReg);
}
