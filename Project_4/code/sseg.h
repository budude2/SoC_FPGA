/*
 * sseg.h
 *
 *  Created on: Nov 28, 2018
 *      Author: bolinej
 */

#ifndef SRC_SSEG_H_
#define SRC_SSEG_H_
#include <inttypes.h>    // to use unitN_t type

#define dispDataReg 0
#define refreshDataReg 1

void setSSEG(uint32_t dispData);
uint32_t getSSEG(void);
void setRefresh(uint16_t refreshRate);
uint16_t getRefresh(void);

#endif /* SRC_SSEG_H_ */
