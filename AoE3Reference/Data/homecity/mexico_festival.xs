//==============================================================================
// aztec_parade.xs
//==============================================================================

//==============================================================================
//Globals.

int lastRandomUnitId = -1;

rule spawnParade
  active
  minInterval 2
  maxInterval 4
{
  
  int unitID = -1;  
  int startWPID = hcGetRandomWPID(cWaypointMaskParadeStart);
  
  // Don't want the same units spawning over and over.
  int randomUnit = hcRandInt(8);
  if(lastRandomUnitId == randomUnit)
    randomUnit = (randomUnit + 1) % 8;
  
  //hcEcho("mexico_parade : spawnParade() Unit "+ randomUnit +" | Waypoint: "+ startWPID);
  switch (randomUnit)
  {
    case 0:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_dia_de_muertos\mexico_dia_de_muertos_dancer_01.xml", "festival", startWPID);
    }
    case 1:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_dia_de_muertos\mexico_dia_de_muertos_dancer_02.xml", "festival", startWPID); 
    }
    case 2:
    {      
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_dia_de_muertos\mexico_dia_de_muertos_dancer_03.xml", "festival", startWPID);
    }
    case 3:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexico_dia_de_muertos\mexico_dia_de_muertos_dancer_04.xml", "festival", startWPID);
    }
	case 4:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexican_villager\mexican_hc_villager_high_01_male.xml", "festival", startWPID);
    }
	case 5:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexican_villager\mexican_hc_villager_high_02_male.xml", "festival", startWPID);
    }
	case 6:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexican_villager\mexican_hc_villager_high_01_female.xml", "festival", startWPID);
    }
	case 7:
    {
      unitID = hcUnitCreate(-1, "homecity\homecity_units\mexican_villager\mexican_hc_villager_high_02_female.xml", "festival", startWPID);
    }
  }
  
  lastRandomUnitId = randomUnit;
  
  hcUnitSetVariation(unitID,0,false);	
  //hcUnitWait(unitID,0,false); // Used to clear out the action queue.
}

void enableUnitHandler(int param = -1) // Event handler
{
  //hcEcho("Mexico Festival Script: Enabled");
  hcOnStartupDisableUnitsByScriptname("citizen");
  hcOnStartupDisableUnitsByScriptname("citizenbusy");
  hcOnStartupDisableUnitsByScriptname("sweeper");
  
  hcOnStartupEnableUnitsByScriptname("festival");
}

void disableUnitHandler(int param = -1) // Event handler
{
  //hcEcho("Mexico Festival Script: Disabled");
  hcOnExitDisableUnitsByScriptname("festival");
  
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
