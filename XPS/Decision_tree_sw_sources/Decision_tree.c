// Include all required header files

#include "xparameters.h"
#include "Decision_tree_fixed.h"
//#include "Decisiontreeclean_intr.c"

#include "stdio.h"
#include "math.h"

// Low-level driver to configure the Interrupt Controller
#include "xintc_l.h"

// Low-level driver to configure interrupt on PowerPC
#include "xil_exception.h"

// Declare global variable for interrupt flag

volatile int interrupt_flag;

// Interrupt handler for DECISIONTREECLEAN module

void DECISIONTREECLEAN_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IpStatus;
  
//  // Initialize base address of peripheral
  
  baseaddr = (Xuint32) baseaddr_p;
  
//  // Read status then clear the interrupt register

  IpStatus = DECISIONTREECLEAN_mReadReg(baseaddr, DECISIONTREECLEAN_INTR_IPISR_OFFSET);
  DECISIONTREECLEAN_mWriteReg(baseaddr, DECISIONTREECLEAN_INTR_IPISR_OFFSET, IpStatus);
  
//  // Set interrupt flag to 1 to allow main program to continue
  
  interrupt_flag = 1;
}

// Main loop

int main()
{
  // Declare local variables and initialize global interrupt flag
  
   
  
  Xuint32 i,j, numElements, numElementsParallel,temp1,temp2,slv_reg0;
  Xuint32 DT_PeriphAddr, DT_InputRAM_AddrBase, DT_OutputRAM_AddrBase,DT_CoeffRAM_AddrBase;
  
  DT_PeriphAddr = XPAR_DECISIONTREECLEAN_0_BASEADDR;
  DT_InputRAM_AddrBase = XPAR_DECISIONTREECLEAN_0_MEM0_BASEADDR;
  DT_OutputRAM_AddrBase = XPAR_DECISIONTREECLEAN_0_MEM1_BASEADDR;
  DT_CoeffRAM_AddrBase = XPAR_DECISIONTREECLEAN_0_MEM2_BASEADDR;
  volatile Xuint32 calcVal, temp, pseudo_intr;
  
 
  interrupt_flag = 0;
  
  ////////////////////////////
  // INTERRUPT INITIALIZATION
  ////////////////////////////
  
//  // Initialize Interrupts on Microblaze
 Xil_ExceptionInit();

//  // Register the interrupt handler of the XPS Interrupt Controller with the Microblaze external interrupt
  Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (XExceptionHandler)XIntc_DeviceInterruptHandler, 
   (void *)XPAR_INTC_0_DEVICE_ID);

//  // Register the DECISIONTREECLEAN interrupt handler in the vector table of the XPS Interrupt Controller
 XIntc_RegisterHandler(XPAR_INTC_0_BASEADDR, XPAR_XPS_INTC_0_DECISIONTREECLEAN_0_IP2INTC_IRPT_INTR, 
    (XInterruptHandler)DECISIONTREECLEAN_Intr_DefaultHandler, (void *)XPAR_DECISIONTREECLEAN_0_BASEADDR);

//  // Start the XPS Interrupt Controller
  XIntc_MasterEnable(XPAR_INTC_0_BASEADDR);

//  // Enable DECISIONTREECLEAN interrupt requests in the XPS Interrupt Controller
  XIntc_EnableIntr(XPAR_INTC_0_BASEADDR, XPAR_DECISIONTREECLEAN_0_IP2INTC_IRPT_MASK);

//  // Local and global interrupt enable for the DECISIONTREECLEAN peripheral
  DECISIONTREECLEAN_EnableInterrupt((Xuint32 *) XPAR_DECISIONTREECLEAN_0_BASEADDR);

//  // Enable Microblaze non-critical (external) interrupts
  Xil_ExceptionEnable();
  

  ////////////////////////////
  // MAIN PROGRAM FUNCTIONS
  ////////////////////////////
  
  // prepare the lookup table 
  
  
    DECISIONTREECLEAN_mWriteSlaveReg2(DT_PeriphAddr, 0, 0xffffffff); //for the RAM_ACCESS WE-- slv_reg2(31)
	 
//Write the LUK UP tables
 
    for (j=0; j< 8; j++)
        {

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4), 0x00010006 ); //00010000000000000110 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(16*4),0x00000C06); //00000000110000000110 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(16*4+4),0x00023411); //00100011010000010001 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(32*4),0x00000C06); //00000000110000000110 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(32*4+4), 0x00000C00); //00000000110000000000 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(32*4+8),0x50004131); //01010100000100110001 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(32*4+12),0x00033C11); //00110011110000010001 );
        
        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(48*4),0x00000C06); //00000000110000000110 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(48*4+4),0x00020C00); //00100000110000000000 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(48*4+8), 0x00000C00); //00000000110000000000 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(48*4+12), 0x00033C11); //00110011110000010001 );
        
        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(48*4+16), 0x40004D31); //01000100110100110001 );

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(48*4+20),0x000BA00F ); //10111010000000001111);

        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(48*4+24),0x00000000 ); //00000000000000000000 );
        
        DECISIONTREECLEAN_mWriteMemory(DT_CoeffRAM_AddrBase+(j*64*4)+(48*4+28), 0x00000000); //00000000000000000000 );

        }
//   for ( i =0 ; i<19; i++)
//	   {
//	 temp1 =DECISIONTREECLEAN_mReadMemory(DT_CoeffRAM_AddrBase+i*4);
//	  printf("coeff_mem %lu\n", temp1);
//	   }
	 DECISIONTREECLEAN_mWriteSlaveReg2(DT_PeriphAddr, 0, 0x00000000); //for the RAM_ACCESS WE-- slv_reg2(31)
	 

	 
  // Store the number of xyz samples we are going to process - do this for compatibility

	scanf("%lu", &numElements);
  
  // First loop stores all xyz samples into the source buffer

	for (i=0; i < numElements; i++)
  {
		scanf("%x", &temp);
    DECISIONTREECLEAN_mWriteMemory(DT_InputRAM_AddrBase + i*4, temp);// written to the memory controller
	}
	
//	temp2 =DECISIONTREECLEAN_mReadMemory(DT_InputRAM_AddrBase);
//	 printf("input_ram=%lu\n", temp2);
  
  // Wait for a bit for LabView to catch up
  
  //for (i=0; i < 10000; i++);
  
  // Set up the DECISIONTREECLEAN module
  
  
  numElementsParallel = ceil(numElements / 8) - 1;
  
  DECISIONTREECLEAN_mWriteSlaveReg1(DT_PeriphAddr, 0, numElementsParallel);
  
  // Start the DECISIONTREECLEAN module processing the samples
  
  DECISIONTREECLEAN_mWriteSlaveReg0(DT_PeriphAddr, 0, 0x1); // go bit
//  slv_reg0= DECISIONTREECLEAN_mReadSlaveReg0(DT_PeriphAddr, 0);
//  printf("slv_reg0 %lu\n", slv_reg0);  
   //printf("we reached before interrupt");
  
  // Wait for DECISIONTREECLEAN to finish
  
  while (interrupt_flag == 0);
  
//  pseudo_intr= DECISIONTREECLEAN_mReadSlaveReg5(DT_PeriphAddr, 0);
//  printf("psi-%lu\n",pseudo_intr);
    
  // After completion of operations, store the calculation time required and clear counter
  //if (pseudo_intr == 1 )
  //{
  //printf("we reached after interrupt\n");
  calcVal = DECISIONTREECLEAN_mReadSlaveReg7(DT_PeriphAddr, 0);
  DECISIONTREECLEAN_mWriteSlaveReg6(DT_PeriphAddr, 0, 0xffffffff);
  
  // Transmit results of calculation, plus the count value from the calculation timer
  
  temp = numElements + 1;
    
  printf("%u\n", temp);

	for (i=0; i < (numElementsParallel+1); i++) {
    temp = DECISIONTREECLEAN_mReadMemory(DT_OutputRAM_AddrBase + i*4);
		printf("%u\n", temp);
	}
  
  printf("%u\n", calcVal);
  //}
	return 0;
}
