/*****************************************************************************
* Filename:          C:\projects\project\hw_peripheral_basic/drivers/xyz_peripheral_basic_v1_00_a/src/xyz_peripheral_basic.c
* Version:           1.00.a
* Description:       xyz_peripheral_basic Driver Source File
* Date:              Sat Nov 26 20:23:38 2011 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "Decision_tree_fixed.h"

/************************** Function Definitions ***************************/

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
void DECISIONTREECLEAN_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  DECISIONTREECLEAN_mWriteReg(baseaddr, DECISIONTREECLEAN_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Set global interrupt enable.
   */
  DECISIONTREECLEAN_mWriteReg(baseaddr, DECISIONTREECLEAN_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}
