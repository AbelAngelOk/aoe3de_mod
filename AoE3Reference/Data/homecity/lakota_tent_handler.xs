//==============================================================================
// Lakota_tent_handler.xs
//==============================================================================

//==============================================================================
//Globals.
int tentsUnitID = -1;
int originalTentID = -1;
int newTentID = -1;
bool init = false;
int previousCase = -1;


// We are running this rule once per frame
rule handleTents
  active
  minInterval 0
  maxInterval 0
{
int tentSwitch = 0;




	if (hcIsPropEnabledByName( "Lakota_Night" ) == true || hcIsPropEnabledByName( "Lakota_NightFF" ) == true)
	{
		if (hcIsPropEnabledByName( "Lakota_Tipi_Original" ) == true)
		{
			tentSwitch = 1;	
			
			
		}
		else
		{
			tentSwitch = 3;
			
		}
	}
	else
	{

		if (hcIsPropEnabledByName( "Lakota_Tipi_Original" ) == true)
		{
			tentSwitch = 0;
			
		}
		else
		{
			tentSwitch = 2;
			
		}
		
	}
	
	if (previousCase != tentSwitch)
	{
		originalTentID = hcGetBuildingIDByName("Cathedral");
		hcBuildingSetVariation(originalTentID,tentSwitch);
		hcUnitSetVariation(tentsUnitID,tentSwitch, false);
		hcSetCustomData("tents", tentSwitch);
	}
	previousCase = tentSwitch;


}

void enableTentHandler(int param = -1) // Event handler
{

   hcEnableUnitsByScriptname("tents");
	if( init == false)
	{	

   		tentsUnitID = hcUnitCreateAtBone(-1, "homecity\home_city_props\lakota_tents\lakota_tents.xml", "tents", "bone_centered");
		
		init = true;
	}
		
}

void disableTentHandler(int param = -1) // Event handler
{

   hcDisableUnitsByScriptname("tents");
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{    
   int tentscript = hcGetMyUnitID();
   hcSetUnitXSHandler(tentscript, "enableTentHandler", cEnableUnitHandler);
   hcSetUnitXSHandler(tentscript, "disableTentHandler", cDisableUnitHandler);
}