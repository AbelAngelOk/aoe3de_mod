//==============================================================================
// russian_wolves.xs
//
// Basic script to just wander the town, like the citizen but the wolf won't look
// at performers.
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
      hcUnitMoveToWPID(myID, -1, wpid, 1.0, 2.0, false);
   }

   //Randomly plan a bored anim one quarter of the time.
   int playAnim=hcRandInt(4);
   if (playAnim == 1)
      int i = 0;
   int numAnims=hcRandInt(4) + 2;

   for(i=0; <numAnims)      
   {
      int playAnimNum = hcRandInt(100);

      if((playAnimNum > 0) && (playAnimNum < 40))
         hcUnitPlayAnim(myID, "Idle", 0, false, true);
      if((playAnimNum > 40) && (playAnimNum < 70))
         hcUnitPlayAnim(myID, "Bored_A", 0, false, true);
      else if((playAnimNum > 70) && (playAnimNum < 100))
         hcUnitPlayAnim(myID, "Bored_B", 0, false, true);     
   }
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
