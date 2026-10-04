//==============================================================================
// drunk.xs
//
// Basic script to just wander the town.
//==============================================================================


//==============================================================================
// doDrunkAction
//==============================================================================
void doDrunkAction( void )
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
   int wpid=hcGetRandomWPID(cWaypointMaskDrunk);
   if (wpid >= 0)
   {
      int foo=hcRandInt(3);
      if (foo == 0)
         hcUnitMoveToWPID(myID, -1, wpid, 1.0, 3.0, false);
      if (foo == 1)
         hcUnitMoveToWPID(myID, -1, wpid, 1.4, 3.0, false);
      if (foo == 2)
         hcUnitMoveToWPID(myID, -1, wpid, 1.8, 3.0, false);
   }

   doDrunkAction();
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
