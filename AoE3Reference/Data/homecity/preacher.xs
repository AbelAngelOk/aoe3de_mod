//==============================================================================
// preacher.xs
//==============================================================================

//==============================================================================
//Globals.

bool firstTime = true;


//==============================================================================
// perform
//==============================================================================
void perform(int param = -1) // Event handler
{
   int myID=hcGetMyUnitID();

   // Perform
   hcUnitSetFlag(myID, cWaitingToPerform, false, false);
      
      
      
   hcUnitPlayAnim(myID, "state_in", 0, -1, true);
   
   int numIterations = 5 + hcRandInt(6);
   int i = 0;
  
   // Loop a number of times.
   for(i = 0; <= numIterations)
   { 
      int foo=hcRandInt(6);
      if (foo == 0)
      {      
         hcUnitPlayAnim(myID, "state_actiona", 0, false, true);
      }
      else if (foo == 1)
      {
         hcUnitPlayAnim(myID, "state_actionb", 0, false, true);
      } 
      else if (foo == 2)
      {
         hcUnitPlayAnim(myID, "state_actionc", 0, false, true);
      }          
      else if (foo == 3)
      {
         hcUnitPlayAnim(myID, "state_actionc", 0, false, true);
      }          
      else if (foo == 4)
      {
         hcUnitPlayAnim(myID, "state_actione", 0, false, true);
      }          
      else if (foo == 5)
      {
         hcUnitPlayAnim(myID, "state_actionb", 0, false, true);
      }          
   }
   
   hcUnitPlayAnim(myID, "state_out", 0, -1, true);


   // Done Performing
   hcUnitSetFlag(myID, cDonePerforming, true, true);
   
   //Get our exit WPID.
   int exitWPID=hcGetRandomWPID(cWaypointMaskExit);
   if (exitWPID >= 0)
   {
      //Move to exit.
      hcUnitMoveToWPID(myID, -1, exitWPID, 2.0, 1.0, true);
      
      hcUnitSetFlag(myID, cWaitingToPerform, false, true);
      hcUnitSetFlag(myID, cDonePerforming, false, true);
   }

   // Set invisible
   hcUnitSetVisible(myID, false, true);   
   
   //Go idle.
   hcUnitGoIdle(myID, true);
}


//==============================================================================
// walkToPerformanceArea
//==============================================================================
void walkToPerformanceArea(void)
{
   int myID=hcGetMyUnitID();
   int groupID = hcUnitGetGroupID(myID);

   // Get our performance position
   vector performPos = hcUnitGetPerformPosFromGroup(groupID, myID);

   // Set visible
   hcUnitSetVisible(myID, true, false);   

   // Move to goal   
   hcUnitMoveToPos(myID, -1, performPos, 2.2, 0.0, true);

   hcUnitSetFlag(myID, cWaitingToPerform, true, true);
}


//==============================================================================
// wander
//==============================================================================
void wander( void )
{
   int unitID=hcGetMyUnitID();
   int groupID = hcUnitGetGroupID(unitID);
      
   // Get a new performace area for the performer group to
   // perform in.
   bool foundArea = hcReservePerformerArea(groupID);
   if (foundArea == true)
   {
      //Start.
      walkToPerformanceArea();
   }
   else
   {
      int exitWPID=hcGetRandomWPID(cWaypointMaskExit);

      // Set visible
      hcUnitSetVisible(unitID, true, false);   
      
      //Move to exit.
      hcUnitMoveToWPID(unitID, -1, exitWPID, 2.0, 1.0, true);

      // Set invisible
      hcUnitSetVisible(unitID, false, true);   

      //Go idle.
      hcUnitGoIdle(unitID, true);
   }
}   
   
//==============================================================================
// wanderRestart
//==============================================================================
rule wanderRestart
   active
   minInterval 50
   maxInterval 50
{
   if(firstTime != true)
   {
      int myID=hcGetMyUnitID();
      if (hcUnitGetActionType(myID) == cActionIdle)
      {
         wander();
      }
   }
   
   firstTime = false;
   
   // Wait before showing up again
   float seconds = 60 + hcRandInt(60);
     
   xsSetRuleMinIntervalSelf(seconds);
   xsSetRuleMaxIntervalSelf(seconds);         
}

//==============================================================================
// comeOut
//==============================================================================
void comeOut(int param = -1) // Event handler
{
   xsSetRuleMinInterval("wanderRestart", 0);
   xsSetRuleMaxInterval("wanderRestart", 0);
   xsEnableRule("wanderRestart");
}

//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   int unitID = hcGetMyUnitID();
   
   // Set up the handlers
   hcSetUnitXSHandler(unitID, "comeOut", cComeOutHandler);
   hcSetUnitXSHandler(unitID, "perform", cPerformHandler);
   
   
   // Create a performer group to coordinate with other groups
   int groupID = hcCreatePerformerGroup(1, 5.0);
   
   // Add unit to group
   hcAddUnitToPerformerGroup(groupID, unitID);   
}
