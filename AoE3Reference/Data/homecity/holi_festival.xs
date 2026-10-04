

void enableUnitHandler(int param = -1) // Event handler
{
   hcDisableUnitsByScriptname("citizen");
}

void disableUnitHandler(int param = -1) // Event handler
{   
   // If either of these units are still active we don't want to disable the citizens
   if(hcAreUnitsActive("Indian_Holi_Festival_1")  == true || hcAreUnitsActive("Indian_Holi_Festival_2") == true)
   {
      return;
   }

   hcEnableUnitsByScriptname("citizen");
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   int unitID = hcGetMyUnitID();

   hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
   hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler); 
}