//==============================================================================
// aztec_blowgun_training.xs
//==============================================================================

int arrayID = -1;
int numberOfSoldiers = 5;

void enableUnitHandler(int param = -1) // Event handler
{
   int unitID = -1;
   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\aztec_soldiers\\blowgunner.xml", "", "bone_blowgunner1");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,0,unitID);

   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\aztec_soldiers\\blowgunner.xml", "", "bone_blowgunner2");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,1,unitID);

   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\aztec_soldiers\\blowgunner.xml", "", "bone_blowgunner3");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,2,unitID);

   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\aztec_soldiers\\blowgunner.xml", "", "bone_blowgunner4");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,3,unitID);

   unitID = hcUnitCreateAtBone(-1, "homecity\\home_city_props\\aztec_soldiers\\blowgunner.xml", "", "bone_blowgunner5");
   hcUnitCreateAnimStateMachine(unitID,"sm_az_hc_blowgunner");
   xsArraySetInt(arrayID,4,unitID);
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