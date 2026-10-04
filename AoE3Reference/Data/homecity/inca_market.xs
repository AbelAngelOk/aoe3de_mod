//==============================================================================
// inca_market.xs
//==============================================================================

int arrayID = -1;
int numberOfCustomers = 4;


void enableUnitHandler(int param = -1) // Event handler
{
   int i = 0;
   // With the inca market there are 7 available customer slots, so create 4 customers to allow enough space and variation
   for(i=0; < numberOfCustomers)    
   {
      int customerWPID = hcGetRandomWPID(cWaypointMaskCustomer);
      int unitID = hcUnitCreate(-1, "homecity\homecity_units\incan_woman\incan_woman.xml", "customer", customerWPID);
      hcUnitSetAIAutoIdle(unitID,false);
      xsArraySetInt(arrayID,i,unitID);
   }

}

void disableUnitHandler(int param = -1) // Event handler
{
   
   int i = 0;
   int unitID = -1;

   for(i=0; < numberOfCustomers) 
   {
      unitID = xsArrayGetInt(arrayID,i);
      xsArraySetInt(arrayID,i,-1);
      hcUnitExit(unitID,false);
   }
}



//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
  
   int unitID = hcGetMyUnitID();

   arrayID = xsArrayCreateInt(numberOfCustomers,-1,"unitIDs");

   hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
   hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler);
   
}
