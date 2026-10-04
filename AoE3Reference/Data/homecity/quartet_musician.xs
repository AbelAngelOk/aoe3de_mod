//==============================================================================
// musician.xs
//==============================================================================

//==============================================================================
//Globals.

//==============================================================================
// walkToPerformanceArea
//==============================================================================
bool walkToPerformanceArea(void)
{
   int myID=hcGetMyUnitID();
   int myGroupID = hcUnitGetGroupID(myID);

   // Get performance position and orientation
   vector performPos = hcUnitGetPerformPosFromGroup(myGroupID, myID);
   vector performForward = hcUnitGetPerformForwardFromGroup(myGroupID, myID);
   
   // Exit building
   int buildingID = hcGetBuildingIDByName("Academy");
   float pauseTime = hcUnitGetInitialPauseTime(myID);
   hcUnitExitBuilding(myID, buildingID, pauseTime, 2.0, false);

   // Move to goal   
   hcUnitMoveToPos(myID, -1, performPos, 2.0, 0.0, true);
   hcUnitTurn(myID, performForward, 90.0, true);
   
   hcUnitSetFlag(myID, cWaitingToPerform, true, true);
   hcUnitSetFlag(myID, cPerforming, false, true);

   hcUnitPlayAnim(myID, "State_In", 0, false, true);
   hcUnitPlayAnim(myID, "State_Idle", 0, true, true);
   
   // Done
   return(true);
}


//==============================================================================
// perform
//==============================================================================
void perform(int param = -1) // Event handler
{
   int myID=hcGetMyUnitID();
   
   // Perform
   hcUnitSetFlag(myID, cWaitingToPerform, false, false);
   hcUnitSetFlag(myID, cPerforming, true, true);
   
   hcUnitPlayAnim(myID, "State_Action", 60.0, true, true);
   hcUnitPlayAnim(myID, "State_Bow", 0, false, true);
   
   hcUnitSetFlag(myID, cPerforming, false, true);
   
   // Enter building
   float pauseTime = hcUnitGetInitialPauseTime(myID);
   if (pauseTime > 0)
   {
      hcUnitPlayAnim(myID, "State_Idle", pauseTime, true, true);
   }
   hcUnitPlayAnim(myID, "State_Out", 0, false, true);
   
   int buildingID = hcGetBuildingIDByName("Academy");
   hcUnitEnterBuilding(myID, buildingID, 2.0, true);
   
   // Go away
   hcUnitExit(myID, true);
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   // Set up the handlers
   int unitID = hcGetMyUnitID();
   hcSetUnitXSHandler(unitID, "perform", cPerformHandler);
   
   //Start.
   walkToPerformanceArea();
}
