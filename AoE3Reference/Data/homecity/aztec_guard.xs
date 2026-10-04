//==============================================================================
// aztecguard.xs
//
// Basic script to just wander the town.
//==============================================================================



//==============================================================================
// aztecGuard
//==============================================================================
void aztecGuard( void )
{
   int myID=hcGetMyUnitID();

   // Play start fishing animation
   hcUnitPlayAnim(myID, "TaskIn", 0, -1, true);
   
   int i=0;
   int numIdles=50;

   for(i=0; <numIdles)      
   {
      hcUnitPlayAnim(myID, "TaskIdle", 0, false, true);
   }
   
   hcUnitPlayAnim(myID, "TaskA", 0, false, true);
   
   for(i=0; <numIdles)      
   {
      hcUnitPlayAnim(myID, "TaskIdle", 0, false, true);
   }   

   hcUnitPlayAnim(myID, "TaskA", 0, false, true);
   

   // Play end fishing animation
   hcUnitPlayAnim(myID, "TaskIn", 0, -1, true);
}


//==============================================================================
// aztecMarch
//==============================================================================
void aztecMarch()
{
   // Find fishing spot
   int myID=hcGetMyUnitID(); 
   int guardwpid = hcGetRandomFreeWPID(cWaypointMaskGuardArea);
   int exitwpid=hcGetRandomWPID(cWaypointMaskExit);

   // Set visible
   hcUnitSetVisible(myID, true, false);   
   
   // March to guard spot
   if (guardwpid >= 0)
   {   
      // Occupy waypoint
      hcOccupyWPID(guardwpid);
         
      hcUnitMoveToWPID(myID, -1, guardwpid, 1.61, 0.0, true);
      
      // Turn   
      vector waypointForward = hcGetWaypointDir(guardwpid);
      hcUnitTurn(myID, waypointForward, 180.0, true);

      // Start guarding
      aztecGuard();
      
      // Free waypoint
      hcUnitFreeWPID(myID, guardwpid, true);

      // Move to a random exit waypoint.
      hcUnitMoveToWPID(myID, -1, exitwpid, 1.61, 3.0, true);
   }
   else
   {
      // Move to a random exit waypoint.
      hcUnitMoveToWPID(myID, -1, exitwpid, 1.61, 3.0, true);
   }
   
      
   // Set invisible
   hcUnitSetVisible(myID, false, true);   
   
   hcUnitGoIdle(myID, true);
}


//==============================================================================
// aztecRestart
//==============================================================================
rule aztecRestart
   active
   minInterval 60
   maxInterval 60
{
   int myID=hcGetMyUnitID();
   if (hcUnitGetActionType(myID) == cActionIdle)
   {
      aztecMarch();
   }
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   aztecMarch();
}
