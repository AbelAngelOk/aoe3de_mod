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
  
  int randomUnit = hcRandInt(5);
  //hcEcho("mexico_parade : spawnParade() Unit "+ randomUnit +" | Waypoint: "+ startWPID);
  switch (randomUnit)
  {
    case 0:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_military\mexican_parade_infantry.xml", "parade", startWPID);
    }
    case 1:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_military\mexican_parade_cavalry.xml", "parade", startWPID); 
    }
    case 2:
    {      
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_military\mexican_parade_redolero.xml", "parade", startWPID);
    }
    case 3:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_military\mexican_parade_chinaco_horse_age4.xml", "parade", startWPID);
    }
    case 4:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_military\mexican_parade_chinaco_horse_age5.xml", "parade", startWPID);    
    }
  }
  
  hcUnitSetVariation(unitID,0,false);	
  //hcUnitWait(unitID,0,false); // Used to clear out the action queue.
}

void enableUnitHandler(int param = -1) // Event handler
{
  //hcEcho("Mexico Parade Script: Enabled");
  hcOnStartupDisableUnitsByScriptname("citizen");
  hcOnStartupDisableUnitsByScriptname("citizenbusy");
  hcOnStartupDisableUnitsByScriptname("sweeper");
    
  hcOnStartupEnableUnitsByScriptname("parade");
}

void disableUnitHandler(int param = -1) // Event handler
{
  //hcEcho("Mexico Parade Script: Disabled");
  hcOnExitDisableUnitsByScriptname("parade");
 
  hcOnExitEnableUnitsByScriptname("citizen");
  hcOnExitEnableUnitsByScriptname("citizenbusy");
  hcOnExitEnableUnitsByScriptname("sweeper");
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{ 
  int unitID = hcGetMyUnitID();
  //hcEcho("mexico_parade : main() "+unitID);
  hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
  hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler);
}
