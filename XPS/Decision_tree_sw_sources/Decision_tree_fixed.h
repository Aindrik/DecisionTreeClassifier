/*****************************************************************************
* Filename:          C:\projects\project\hw_peripheral_optimized/drivers/DECISIONTREECLEAN_v1_00_a/src/xyz_peripheral_basic.h
* Version:           1.00.a
* Description:       xyz_peripheral_basic Driver Header File
* Date:              Mon Dec 12 13:54:48 2011 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef DECISIONTREECLEAN_H
#define DECISIONTREECLEAN_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 * -- SLV_REG4 : user logic slave module register 4
 * -- SLV_REG5 : user logic slave module register 5
 * -- SLV_REG6 : user logic slave module register 6
 * -- SLV_REG7 : user logic slave module register 7
 */
#define DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET (0x00000000)
#define DECISIONTREECLEAN_SLV_REG0_OFFSET (DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET + 0x00000000)
#define DECISIONTREECLEAN_SLV_REG1_OFFSET (DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET + 0x00000004)
#define DECISIONTREECLEAN_SLV_REG2_OFFSET (DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET + 0x00000008)
#define DECISIONTREECLEAN_SLV_REG3_OFFSET (DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define DECISIONTREECLEAN_SLV_REG4_OFFSET (DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET + 0x00000010)
#define DECISIONTREECLEAN_SLV_REG5_OFFSET (DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET + 0x00000014)
#define DECISIONTREECLEAN_SLV_REG6_OFFSET (DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET + 0x00000018)
#define DECISIONTREECLEAN_SLV_REG7_OFFSET (DECISIONTREECLEAN_USER_SLV_SPACE_OFFSET + 0x0000001C)

/**
 * Interrupt Controller Space Offsets
 * -- INTR_DGIER : device (peripheral) global interrupt enable register
 * -- INTR_ISR   : ip (user logic) interrupt status register
 * -- INTR_IER   : ip (user logic) interrupt enable register
 */
#define DECISIONTREECLEAN_INTR_CNTRL_SPACE_OFFSET (0x00000100)
#define DECISIONTREECLEAN_INTR_DGIER_OFFSET (DECISIONTREECLEAN_INTR_CNTRL_SPACE_OFFSET + 0x0000001C)
#define DECISIONTREECLEAN_INTR_IPISR_OFFSET (DECISIONTREECLEAN_INTR_CNTRL_SPACE_OFFSET + 0x00000020)
#define DECISIONTREECLEAN_INTR_IPIER_OFFSET (DECISIONTREECLEAN_INTR_CNTRL_SPACE_OFFSET + 0x00000028)

/**
 * Interrupt Controller Masks
 * -- INTR_TERR_MASK : transaction error
 * -- INTR_DPTO_MASK : data phase time-out
 * -- INTR_IPIR_MASK : ip interrupt requeset
 * -- INTR_RFDL_MASK : read packet fifo deadlock interrupt request
 * -- INTR_WFDL_MASK : write packet fifo deadlock interrupt request
 * -- INTR_IID_MASK  : interrupt id
 * -- INTR_GIE_MASK  : global interrupt enable
 * -- INTR_NOPEND    : the DIPR has no pending interrupts
 */
#define INTR_TERR_MASK (0x00000001UL)
#define INTR_DPTO_MASK (0x00000002UL)
#define INTR_IPIR_MASK (0x00000004UL)
#define INTR_RFDL_MASK (0x00000020UL)
#define INTR_WFDL_MASK (0x00000040UL)
#define INTR_IID_MASK (0x000000FFUL)
#define INTR_GIE_MASK (0x80000000UL)
#define INTR_NOPEND (0x80)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a XYZ_PERIPHERAL_BASIC register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the XYZ_PERIPHERAL_BASIC device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DECISIONTREECLEAN_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define DECISIONTREECLEAN_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a XYZ_PERIPHERAL_BASIC register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the XYZ_PERIPHERAL_BASIC device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 DECISIONTREECLEAN_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define DECISIONTREECLEAN_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from XYZ_PERIPHERAL_BASIC user logic slave registers.
 *
 * @param   BaseAddress is the base address of the XYZ_PERIPHERAL_BASIC device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void DECISIONTREECLEAN_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 DECISIONTREECLEAN_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define DECISIONTREECLEAN_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DECISIONTREECLEAN_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DECISIONTREECLEAN_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DECISIONTREECLEAN_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DECISIONTREECLEAN_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DECISIONTREECLEAN_mWriteSlaveReg5(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG5_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DECISIONTREECLEAN_mWriteSlaveReg6(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG6_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DECISIONTREECLEAN_mWriteSlaveReg7(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG7_OFFSET) + (RegOffset), (Xuint32)(Value))

#define DECISIONTREECLEAN_mReadSlaveReg0(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG0_OFFSET) + (RegOffset))
#define DECISIONTREECLEAN_mReadSlaveReg1(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG1_OFFSET) + (RegOffset))
#define DECISIONTREECLEAN_mReadSlaveReg2(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG2_OFFSET) + (RegOffset))
#define DECISIONTREECLEAN_mReadSlaveReg3(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG3_OFFSET) + (RegOffset))
#define DECISIONTREECLEAN_mReadSlaveReg4(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG4_OFFSET) + (RegOffset))
#define DECISIONTREECLEAN_mReadSlaveReg5(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG5_OFFSET) + (RegOffset))
#define DECISIONTREECLEAN_mReadSlaveReg6(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG6_OFFSET) + (RegOffset))
#define DECISIONTREECLEAN_mReadSlaveReg7(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (DECISIONTREECLEAN_SLV_REG7_OFFSET) + (RegOffset))

/**
 *
 * Write/Read 32 bit value to/from XYZ_PERIPHERAL_BASIC user logic memory (BRAM).
 *
 * @param   Address is the memory address of the XYZ_PERIPHERAL_BASIC device.
 * @param   Data is the value written to user logic memory.
 *
 * @return  The data from the user logic memory.
 *
 * @note
 * C-style signature:
 * 	void DECISIONTREECLEAN_mWriteMemory(Xuint32 Address, Xuint32 Data)
 * 	Xuint32 DECISIONTREECLEAN_mReadMemory(Xuint32 Address)
 *
 */
#define DECISIONTREECLEAN_mWriteMemory(Address, Data) \
 	Xil_Out32(Address, (Xuint32)(Data))
#define DECISIONTREECLEAN_mReadMemory(Address) \
 	Xil_In32(Address)

/************************** Function Prototypes ****************************/


/**
 *
 * Enable all possible interrupts from XYZ_PERIPHERAL_BASIC device.
 *
 * @param   baseaddr_p is the base address of the XYZ_PERIPHERAL_BASIC device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void DECISIONTREECLEAN_EnableInterrupt(void * baseaddr_p);


#endif /** DECISIONTREECLEAN_H */
