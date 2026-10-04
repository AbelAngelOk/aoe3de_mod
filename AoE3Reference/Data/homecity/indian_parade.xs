//==============================================================================
// indian_parade.xs
//==============================================================================

//==============================================================================
//Globals.

rule spawnParade
   active
   minInterval 4
   maxInterval 4
{
 	
   int unitID = -1;  
   int startWPID = hcGetRandomWPID(cWaypointMaskParadeStart);

   int randomUnit = hcRandInt(3);
   //hcEcho("indian_parade : spawnParade() Unit "+randomUnit);
   switch (randomUnit)
   {
    
      case 0:
      {
         unitID = hcUnitCreate(-1, "homecity\homecity_units\indian_elephants\hc_indian_elephant_age1.xml", "parade", startWPID);
         hcUnitSetVariation(unitID,0,false);
      }
      case 1:
      {
         unitID = hcUnitCreate(-1, "homecity\homecity_units\indian_elephants\hc_indian_elephant_age2.xml", "parade", startWPID);      
         hcUnitSetVariation(unitID,0,false);
      }
      case 2:
      {      
         unitID = hcUnitCreate(-1, "homecity\homecity_units\indian_elephants\hc_indian_elephant_mansabdar.xml", "parade", startWPID);  
         hcUnitSetVariation(unitID,0,false);
      }
   }
}

void enableUnitHandler(int param = -1) // Event handler
{
   hcEnableUnitsByScriptname("parade");
}

void disableUnitHandler(int param = -1) // Event handler
{
   hcDisableUnitsByScriptname("parade");
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{   
  
   int unitID = hcGetMyUnitID();
   //hcEcho("indian_parade : main() "+unitID);
   hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
   hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler); 
   
}
