//==============================================================================
// gondola.xs
//
// Basic script to just wander the town.
//==============================================================================

//==============================================================================
// wander
//==============================================================================
void wander( void )
{
   hcSetDefaultPatherID(1);
   //Move to a random waypoint.
   int myID=hcGetMyUnitID();
   int wpid=hcGetRandomFreeWPID(cWaypointMaskGondola);
   //hcEcho("Gondola waypoint: " + wpid);
   if (wpid >= 0)
   {
      int foo=hcRandInt(3);
      if (foo == 0)
         hcUnitMoveToWPID(myID, -1, wpid, 1.8, 3.0, false);
      if (foo == 1)
         hcUnitMoveToWPID(myID, -1, wpid, 2.0, 3.0, false);
      if (foo == 2)
         hcUnitMoveToWPID(myID, -1, wpid, 2.2, 3.0, false);
   }
   hcSetDefaultPatherID(2);
}

//==============================================================================
// wanderRestart
//==============================================================================
rule wanderRestart
   active
   minInterval 3
   maxInterval 6
{
   int myID=hcGetMyUnitID();
   if (hcUnitGetActionType(myID) == cActionIdle)
   {
      wander();
      int newRuleInterval=hcRandInt(6);
      xsSetRuleMinIntervalSelf(newRuleInterval);
   }
}

//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   wander();
}
