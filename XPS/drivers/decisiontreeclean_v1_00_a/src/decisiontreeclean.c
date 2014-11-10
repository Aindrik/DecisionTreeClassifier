/*****************************************************************************
* Filename:          C:\research\DecisionTreeClean\XPS/drivers/decisiontreeclean_v1_00_a/src/decisiontreeclean.c
* Version:           1.00.a
* Description:       decisiontreeclean Driver Source File
* Date:              Sun Apr 15 17:08:57 2012 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "decisiontreeclean.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from DECISIONTREECLEAN device.
 *
 * @param   baseaddr_p is the base address of the DECISIONTREECLEAN device.
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

/**
 *
 * Example interrupt controller handler for DECISIONTREECLEAN device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the DECISIONTREECLEAN device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void DECISIONTREECLEAN_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = DECISIONTREECLEAN_mReadReg(baseaddr, DECISIONTREECLEAN_INTR_IPISR_OFFSET);
    DECISIONTREECLEAN_mWriteReg(baseaddr, DECISIONTREECLEAN_INTR_IPISR_OFFSET, IpStatus);
  }

}

