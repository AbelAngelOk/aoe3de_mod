//==============================================================================
// aztec_parade.xs
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
  
  int randomUnit = hcRandInt(7);
  //hcEcho("aztec_parade : spawnParade() Unit "+randomUnit);
  switch (randomUnit)
  {
    case 0:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\aztec_parade\hc_coyote_man_age2.xml", "parade", startWPID);
    }
    case 1:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\aztec_parade\hc_coyote_man_age3.xml", "parade", startWPID); 
    }
    case 2:
    {      
      unitID = hcUnitCreate(-1, "homecity\homecity_units\aztec_parade\hc_skull_knight.xml", "parade", startWPID);
    }
    case 3:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\aztec_parade\hc_Az_war_chief.xml", "parade", startWPID);
    }
    case 4:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\aztec_parade\hc_eagle_knight.xml", "parade", startWPID);    
    }
    case 5:
    {      
      unitID = hcUnitCreate(-1, "homecity\homecity_units\aztec_parade\hc_macehuatlin.xml", "parade", startWPID);
    }
    case 6:
    {      
      unitID = hcUnitCreate(-1, "homecity\homecity_units\aztec_parade\hc_puma_lord.xml", "parade", startWPID); 
    }
  }
  
  hcUnitSetVariation(unitID,0,false);	
  //hcUnitWait(unitID,0,false); // Used to clear out the action queue.
}

void enableUnitHandler(int param = -1) // Event handler
{
  //hcEcho("Enable script");
  hcDisableUnitsByScriptname("citizen");
  hcEnableUnitsByScriptname("parade");
}

void disableUnitHandler(int param = -1) // Event handler
{
  //hcEcho("Disable script");
  hcDisableUnitsByScriptname("parade");
  hcEnableUnitsByScriptname("citizen");
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{   
  int unitID = hcGetMyUnitID();
  //hcEcho("aztec_parade : main() "+unitID);
  hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
  hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler);
}
