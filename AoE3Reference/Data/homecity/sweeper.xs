//==============================================================================
// sweeper.xs
//
// Basic script to just wander the town.
//==============================================================================


//==============================================================================
// sweep
//==============================================================================
void sweep( void )
{
   int myID=hcGetMyUnitID();
   
   int i = 0;
   int numSweeps=hcRandInt(5) + 5;
   int lastPlayedSweepAnimation = hcRandInt(3);   


   for(i=0; <numSweeps)      
   {
      // Never repeat the same animation back to back
      int playSweepAnim = lastPlayedSweepAnimation + 1 + hcRandInt(2);
   
      if( playSweepAnim >= 3 )
         playSweepAnim = playSweepAnim - 3;
   
      if (playSweepAnim == 0)
         hcUnitPlayAnim(myID, "taskA", 0, false, true);
      if (playSweepAnim == 1)
         hcUnitPlayAnim(myID, "taskB", 0, false, true);
      if (playSweepAnim == 2)
         hcUnitPlayAnim(myID, "taskC", 0, false, true);
         
         
      lastPlayedSweepAnimation = playSweepAnim;
   }


   // Play "wipe swet off my face" animation 50% every
   // other time.
   int playTiredAnim=hcRandInt(2);
   if (playTiredAnim == 0)      
      hcUnitPlayAnim(myID, "Bored", 0, false, true);    
}      


//==============================================================================
// wander
//==============================================================================
void wander( void )
{
   //Move to a random waypoint.
   int myID=hcGetMyUnitID();
   int wpid=hcGetRandomWPID(cWaypointMaskSweeper);
   if (wpid >= 0)
   {
      hcUnitMoveToWPID(myID, -1, wpid, 2.2, 3.0, false);
   }

   // Randomly plan a bored anim half of the time.
   int playAnim=hcRandInt(4);
   if (playAnim == 0)
   {
      hcUnitPlayAnim(myID, "Idle", 0, false, true);
   }
   else
   {
      sweep();
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
