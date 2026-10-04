//==============================================================================
// sweeper.xs
//
// Basic script to just wander the town.
//==============================================================================


bool firstTime = true;

//==============================================================================
// doVendorAction
//==============================================================================
void doVendorAction( void )
{
   int myID=hcGetMyUnitID();
   
   
   hcUnitPlayAnim(myID, "TaskIn", 0, -1, true);

   
   int i = 0;
   int numSells=hcRandInt(5) + 5;

   for(i=0; <numSells)      
   {
      hcUnitPlayAnim(myID, "TaskIdle", 0, false, true);
   }

   hcUnitPlayAnim(myID, "TaskOut", 0, -1, true);
}      


//==============================================================================
// wander
//==============================================================================
void wander( void )
{
   //Move to a random waypoint.
   int myID=hcGetMyUnitID();
   int wpid=hcGetRandomFreeWPID(cWaypointMaskVendorArea);
      
   // Set visible
   hcUnitSetVisible(myID, true, false);
      
      
   if (wpid >= 0)
   {
      // Occupy waypoint
      hcOccupyWPID(wpid);
      
      hcUnitMoveToWPID(myID, -1, wpid, 1.6, 0.1, true);
               
      doVendorAction();
      
      // Free waypoint
      hcUnitFreeWPID(myID, wpid, true);
   }
   
   // Move to a random exit waypoint.
   int exitwpid=hcGetRandomWPID(cWaypointMaskVendorEntry);
   if (exitwpid == -1)
   {
      exitwpid=hcGetRandomWPID(cWaypointMaskExit);
   }
   hcUnitMoveToWPID(myID, -1, exitwpid, 1.6, 3.0, true);  
   
   // Set invisible
   hcUnitSetVisible(myID, false, true);
      
   hcUnitGoIdle(myID, true);      
}

//==============================================================================
// wanderRestart
//==============================================================================
rule wanderRestart
   active
   minInterval 0
   maxInterval 0
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
   float seconds = 90 + hcRandInt(30);
     
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
   // Set up the handlers
   int unitID = hcGetMyUnitID();
   hcSetUnitXSHandler(unitID, "comeOut", cComeOutHandler);
   
   
   // Teleport unit to entry point, regardless of where it was spawned
   int entrywpid=hcGetRandomWPID(cWaypointMaskVendorEntry);
   
   hcUnitTeleportToWPID(unitID, entrywpid);
}
