##############################################################################
## Filename:          C:\research\DecisionTreeClean\XPS/drivers/decisiontreeclean_v1_00_a/data/decisiontreeclean_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sun Apr 15 17:08:57 2012 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "decisiontreeclean" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" "C_MEM0_BASEADDR" "C_MEM0_HIGHADDR" "C_MEM1_BASEADDR" "C_MEM1_HIGHADDR" "C_MEM2_BASEADDR" "C_MEM2_HIGHADDR" 
}
