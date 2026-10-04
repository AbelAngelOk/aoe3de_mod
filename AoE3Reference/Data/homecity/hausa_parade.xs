//==============================================================================
// hausa_parade.xs
//==============================================================================

//==============================================================================
//Globals.

rule spawnParade
   active
   minInterval 3
   maxInterval 3
{
 	
   int unitID = -1;  
   int startWPID = hcGetRandomWPID(cWaypointMaskParadeStart);

   int randomUnit = hcRandInt(3);
   //hcEcho("hausa_parade : spawnParade() Unit "+randomUnit);

   switch (randomUnit)
   {
    
      case 0:
      {
         unitID = hcUnitCreate(-1, "homecity\homecity_units\african_military\fula_warrior_hc.xml", "parade", startWPID);
         hcUnitSetVariation(unitID,0,false);
      }
      case 1:
      {
         unitID = hcUnitCreate(-1, "homecity\homecity_units\african_military\griot_hc.xml", "parade", startWPID);
         hcUnitSetVariation(unitID,0,false);
      }
      case 2:
      {      
         unitID = hcUnitCreate(-1, "homecity\homecity_units\african_military\lifidi_knight_hc.xml", "parade", startWPID);
         int randomVariation = hcRandInt(3);
         hcUnitSetVariation(unitID,randomVariation,false);
      }
   }
}

void enableUnitHandler(int param = -1) // Event handler
{
   hcDisableUnitsByScriptname("citizen");
   hcEnableUnitsByScriptname("parade");
}

void disableUnitHandler(int param = -1) // Event handler
{
   hcEnableUnitsByScriptname("citizen");
   hcDisableUnitsByScriptname("parade");
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{   
  
   int unitID = hcGetMyUnitID();

   //hcEcho("hausa_parade : main() "+unitID);

   hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
   hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler); 
   hcDisableUnitsByScriptname("citizen");
   
}
