//==============================================================================
// inca_llamas.xs
//==============================================================================

int arrayID = -1;
int numberOfLlamas = 6;


void enableUnitHandler(int param = -1) // Event handler
{
   int i = 0;
   // There are 3 different type of llamas
   for(i=0; < numberOfLlamas)    
   {
      int startWPID = hcGetRandomWPID(cWaypointMaskCitizen);
      int unitID = -1;    
      int randomUnit = hcRandInt(3);

      switch (randomUnit)
      {
    
         case 0:
         {
            unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_llama\inca_llama_01.xml", "citizen", startWPID);  
         }
         case 1:
         {
            unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_llama\inca_llama_02.xml", "citizen", startWPID);   
         }
         case 2:
         {      
            unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_llama\inca_llama_03.xml", "citizen", startWPID);
         }
      }

      xsArraySetInt(arrayID,i,unitID);
   }

}

void disableUnitHandler(int param = -1) // Event handler
{
   
   int i = 0;
   int unitID = -1;

   for(i=0; < numberOfLlamas) 
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

   arrayID = xsArrayCreateInt(numberOfLlamas,-1,"unitIDs");

   hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
   hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler);
   
}
