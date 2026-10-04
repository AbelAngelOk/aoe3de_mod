//==============================================================================
// porter.xs
//
// Basic script to just wander the town, like the citizen but won't look
// at performers. Uses shipment carrier animation references.
//==============================================================================

//==============================================================================
// wander
//==============================================================================
void wander( void )
{
   //Move to a random waypoint.
   int myID=hcGetMyUnitID();
   int wpid=hcGetRandomWPID(cWaypointMaskCitizen);
   if (wpid >= 0)
   {
      hcUnitMoveToWPID(myID, -1, wpid, 2.0, 3.0, false);
   }

   //Randomly plan a bored anim half of the time.
   int playAnim=hcRandInt(2);
   if (playAnim == 1)
      hcUnitPlayAnim(myID, "Idle", 0, false, true);
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
   //Start.
   wander();
}
