//==============================================================================
// thug.xs
//
// Basic script to just wander the town.
//==============================================================================


bool firstTime = true;

//==============================================================================
// doThugAction
//==============================================================================
void doThugAction( void )
{
   int myID=hcGetMyUnitID();
   
   
   hcUnitPlayAnim(myID, "Into Idle", 0, -1, true);    


   int i = 0;
   int numIdles=hcRandInt(5) + 10;

   for(i=0; <numIdles)      
   {
      int foo=hcRandInt(5);
      
      if( foo == 0 )
      {
         hcUnitPlayAnim(myID, "Bored", 0, false, true);
      }
      else
      {
         hcUnitPlayAnim(myID, "Idle", 0, false, true);
      }
   }

   hcUnitPlayAnim(myID, "Out of Idle", 0, -1, true);    
}      



//==============================================================================
// wander
//==============================================================================
void wander( void )
{
   //Move to a random waypoint.
   int myID=hcGetMyUnitID();
   int wpid=hcGetRandomFreeWPID(cWaypointMaskIllReputeArea);
   int exitwpid=hcGetRandomWPID(cWaypointMaskExit);

   // Set visible
   hcUnitSetVisible(myID, true, false);   
         
   if (wpid >= 0)
   {
      // Occupy waypoint
      hcOccupyWPID(wpid);
      
      hcUnitMoveToWPID(myID, -1, wpid, 1.5, 0.1, true);
         
      // Turn   
      vector waypointForward = hcGetWaypointDir(wpid);
      hcUnitTurn(myID, waypointForward, 180.0, true);
               
      doThugAction();
      
      // Free waypoint
      hcUnitFreeWPID(myID, wpid, true);
      
      // Move to a random exit waypoint.
      hcUnitMoveToWPID(myID, -1, exitwpid, 1.5, 3.0, true);  
   }
   else
   {
      // Move to a random exit waypoint.
      hcUnitMoveToWPID(myID, -1, exitwpid, 1.5, 3.0, true);  
   }
   
   // Set invisible
   hcUnitSetVisible(myID, false, true);   
      
   hcUnitGoIdle(myID, true);      
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
   float seconds = 40 + hcRandInt(20);
     
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
}
