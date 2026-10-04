//==============================================================================
// inca_parade.xs
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

   int randomUnit = hcRandInt(6);
   //hcEcho("hausa_parade : spawnParade() Unit "+randomUnit);

   switch (randomUnit)
   {
    
      case 0:
      {
         unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_parade\hc_inca_dancer_01.xml", "parade", startWPID);            
      }
      case 1:
      {
         unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_parade\hc_inca_dancer_02.xml", "parade", startWPID);     
      }
      case 2:
      {      
         unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_parade\hc_inca_dancer_03.xml", "parade", startWPID);    
      }
      case 3:
      {      
         unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_parade\hc_inca_dancer_04.xml", "parade", startWPID);       
      }
      case 4:
      {      
         unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_parade\hc_priestess.xml", "parade", startWPID);     
      }
      case 5:
      {      
         unitID = hcUnitCreate(-1, "homecity\homecity_units\inca_parade\hc_inca_war_chief.xml", "parade", startWPID);      
      }
   }
   hcUnitWait(unitID,0,false); // Used to clear out the action queue.
}

void enableUnitHandler(int param = -1) // Event handler
{
 
   hcEnableUnitsByScriptname("parade");
   hcDisableUnitsByScriptname("citizen");

}

void disableUnitHandler(int param = -1) // Event handler
{
 
   hcDisableUnitsByScriptname("parade");
   hcEnableUnitsByScriptname("citizen");

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
   
   
}
