//==============================================================================
// Italy_Carnevale.xs
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
  
  int randomUnit = hcRandInt(8);
  //hcEcho("italy_parade : spawnParade() Unit "+ randomUnit +" | Waypoint: "+ startWPID);
  switch (randomUnit)
  {
    case 0:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\italy_carnevale_dancers\italy_carnevale_dancers_01.xml", "parade", startWPID);
    }
    case 1:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\italy_carnevale_dancers\italy_carnevale_dancers_02.xml", "parade", startWPID); 
    }
    case 2:
    {      
      unitID = hcUnitCreate(-1, "homecity\homecity_units\italy_carnevale_dancers\italy_carnevale_dancers_03.xml", "parade", startWPID);
    }
    case 3:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\italy_carnevale_dancers\italy_carnevale_dancers_04.xml", "parade", startWPID);
    }
    case 4:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\italy_carnevale_dancers\italy_carnevale_dancers_05.xml", "parade", startWPID);    
    }
	case 5:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\italy_carnevale_dancers\italy_carnevale_dancers_06.xml", "parade", startWPID);    
    }
	case 6:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\italy_carnevale_dancers\italy_carnevale_dancers_07.xml", "parade", startWPID);    
    }
	case 7:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\italy_carnevale_dancers\italy_carnevale_dancers_08.xml", "parade", startWPID);    
    }
  }
  
  hcUnitSetVariation(unitID,0,false);	
  //hcUnitWait(unitID,0,false); // Used to clear out the action queue.
}

void enableUnitHandler(int param = -1) // Event handler
{
  //hcEcho("Italy parade Script: Enabled");
  hcOnStartupDisableUnitsByScriptname("citizen");
  hcOnStartupDisableUnitsByScriptname("citizenbusy");
  hcOnStartupDisableUnitsByScriptname("sweeper");
  hcOnStartupDisableUnitsByScriptname("drunk");
  hcOnStartupDisableUnitsByScriptname("fisherman");
  hcOnStartupDisableUnitsByScriptname("nicelady");
    
  hcOnStartupEnableUnitsByScriptname("parade");
}

void disableUnitHandler(int param = -1) // Event handler
{
  //hcEcho("Italy parade Script: Disabled");
  hcOnExitDisableUnitsByScriptname("parade");
 
  hcOnExitEnableUnitsByScriptname("citizen");
  hcOnExitEnableUnitsByScriptname("citizenbusy");
  hcOnExitEnableUnitsByScriptname("sweeper");
  hcOnExitEnableUnitsByScriptname("drunk");
  hcOnExitEnableUnitsByScriptname("fisherman");
  hcOnExitEnableUnitsByScriptname("nicelady");
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{   
  int unitID = hcGetMyUnitID();
  //hcEcho("italy_parade : main() "+unitID);
  hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
  hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler);
}
