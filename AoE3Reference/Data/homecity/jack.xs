//==============================================================================
// jack.xs
//
// Script for Jack the Ripper
//==============================================================================


bool firstTime = true;

//==============================================================================
// wander
//==============================================================================
void wander( void )
{
   // Get unit ID
   int myID=hcGetMyUnitID();

   // Set visible
   hcUnitSetVisible(myID, true, false);
   
   
   int numPlaces=hcRandInt(2) + 2;      
   for(i=0; <numPlaces)      
   {
      int wpid=hcGetRandomWPID(cWaypointMaskSweeper);
      hcUnitMoveToWPID(myID, -1, wpid, 1.9, 0.1, true);

      // Play anim               
      hcUnitPlayAnim(myID, "bored", 0, false, true);
   }
      
   // Move to a random exit waypoint.
   int exitwpid=hcGetRandomWPID(cWaypointMaskExit);
   hcUnitMoveToWPID(myID, -1, exitwpid, 1.9, 3.0, true);  
   
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
   float seconds = 30 + hcRandInt(90);
     
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
