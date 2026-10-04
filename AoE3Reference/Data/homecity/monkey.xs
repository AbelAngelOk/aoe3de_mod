//==============================================================================
// citizen.xs
//
// Basic script to just wander the town.
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
      int foo=hcRandInt(3);
      if (foo == 0)
         hcUnitMoveToWPID(myID, -1, wpid, 5, 6, false);
      if (foo == 1)
         hcUnitMoveToWPID(myID, -1, wpid, 5, 6, false);
      if (foo == 2)
         hcUnitMoveToWPID(myID, -1, wpid, 5, 6, false);
   }

   //Randomly plan a bored anim half of the time.
   int playAnim=hcRandInt(2);
   if (playAnim == 1)
      hcUnitPlayAnim(myID, "bored", 0, false, true);
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

int gPerformerID=-1;
//==============================================================================
// watchPerformer
//==============================================================================
rule watchPerformer
   active
   minInterval 2
   maxInterval 6
{  
   int myID=hcGetMyUnitID();
   //Get the first performer.
   //gPerformerID=hcGetUnitWithAI("torchy", 0);
   gPerformerID=hcGetPerformerInProximity(myID);
   if (gPerformerID < 0)
      return;

   //Skip a performer moving or idling.
   int performerActionType=hcUnitGetActionType(gPerformerID);
   if (performerActionType != cActionAnim)
      return;
   //hcEcho("UnitID="+myID+": Found a performer, ID="+gPerformerID+".");
   
   //Get the performer's position.
   vector performerPosition=hcUnitGetPosition(gPerformerID);
   int performerWPID=hcGetNearestWPID(performerPosition);
   if (performerWPID < 0)
      return;

   //If we have a performer, go watch him.
   //hcEcho("UnitID="+myID+": Going to watch performer, ID="+gPerformerID+".");
   if (hcUnitMoveToWPID(myID, -1, performerWPID, 4.0, 2.5+hcRandInt(3), false) == false)
      return;
   //Play a long animation (to clearly watch Torchy the whole time).
   if (hcUnitPlayAnim(myID, "bored", 100, true, true) == false)
      hcUnitPlayAnim(myID, "idle", 100, true, true);

   //Activate our unwatch rule and disable us.
   xsEnableRule("unWatchPerformer");
   xsSetRuleMinInterval("unWatchPerformer", 3+hcRandInt(6));
   xsDisableSelf();
}

//==============================================================================
// unWatchPerformer
//==============================================================================
rule unWatchPerformer
   inactive
   minInterval 5
   maxInterval 10
{
   int myID=hcGetMyUnitID();
   //Once he starts moving or idling, we're done.
   int performerActionType=hcUnitGetActionType(gPerformerID);
   if (performerActionType == cActionAnim)
      return;

   //hcEcho("UnitID="+myID+": Going to STOP watching performer, ID="+gPerformerID+".");
   //Unset our performer ID.
   gPerformerID=-1;

   //Clap.  Wander if that fails.
   int randClap=hcRandInt(5);
   bool clapSuccess=false;
   switch (randClap)
   {
      case 0:
      {
         clapSuccess=hcUnitPlayAnim(myID, "Applause_A", 0, false, false);
      }
      case 1:
      {
         clapSuccess=hcUnitPlayAnim(myID, "Applause_B", 0, false, false);
      }
      case 2:
      {
         clapSuccess=hcUnitPlayAnim(myID, "Applause_C", 0, false, false);
      }
      case 3:
      {
         clapSuccess=hcUnitPlayAnim(myID, "Applause_D", 0, false, false);
      }
      case 4:
      {
         clapSuccess=hcUnitPlayAnim(myID, "Applause_E", 0, false, false);
      }
   }
   if (clapSuccess == false)
      wander();

   //Activate our watch rule and disable us.
   xsEnableRule("watchPerformer");
   xsDisableSelf();
}

//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   //Start.
   wander();
}
