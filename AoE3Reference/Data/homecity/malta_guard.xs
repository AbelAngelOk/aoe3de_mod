//==============================================================================
// malta_guard.xs
//==============================================================================

int arrayID = -1;
int numberOfSoldiers = 6;

void enableUnitHandler(int param = -1) // Event handler
{
   int unitID = -1;
   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\malta_Guards\\sentinel.xml", "", "bone_soldier_01_special");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,0,unitID);

   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\malta_Guards\\sentinel.xml", "", "bone_soldier_02_special");
   //hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,1,unitID);

   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\malta_Guards\\sentinel.xml", "", "bone_soldier_03_special");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,2,unitID);

   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\malta_Guards\\sentinel.xml", "", "bone_soldier_04_special");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,3,unitID);

   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\malta_Guards\\sentinel.xml", "", "bone_soldier_05_special");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,4,unitID);
   
   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\malta_Guards\\sentinel.xml", "", "bone_soldier_06_special");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,5,unitID);
}

void disableUnitHandler(int param = -1) // Event handler
{
   
   int i = 0;
   int unitID = -1;

   for(i=0; < numberOfSoldiers) 
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

   hcSetUnitXSHandler(unitID, "enableUnitHandler", cEnableUnitHandler);
   hcSetUnitXSHandler(unitID, "disableUnitHandler", cDisableUnitHandler); 

   arrayID = xsArrayCreateInt(numberOfSoldiers,-1,"unitIDs");
}