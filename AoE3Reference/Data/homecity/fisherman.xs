//==============================================================================
// fisherman.xs
//
// Basic script to just wander the town.
//==============================================================================



//==============================================================================
// fish
//==============================================================================
void fish( void )
{
   int myID=hcGetMyUnitID();

   // Play start fishing animation
   hcUnitPlayAnim(myID, "TaskIn", 0, -1, true);
   

   // Figure out how many fish that he need for dinner.
   int numFishNeeded = 3 + hcRandInt(3);
   int numCaughtFish = 0;
   
  
   // Loop until he has all the fish he needs.
   while( numCaughtFish < numFishNeeded )
   {
      hcUnitPlayAnim(myID, "TaskIdle", 0, false, true);
      
      int foo1=hcRandInt(5);
      if (foo1 == 0)
      {      
         hcUnitPlayAnim(myID, "TaskTug", 0, false, true);
         
         int foo2=hcRandInt(3);
         if (foo2 == 0)
         {
            hcUnitPlayAnim(myID, "TaskCatch", 0, -1, true);
            numCaughtFish++;
         }
      }
   }

   
   // Play end fishing animation
   hcUnitPlayAnim(myID, "TaskOut", 0, -1, true);
}


//==============================================================================
// goingFishing
//==============================================================================
void goingFishing(void)
{
   // Find fishing spot
   int myID=hcGetMyUnitID(); 
   int fishingwpid=hcGetRandomFreeWPID(cWaypointMaskFishingArea);
   int exitwpid=hcGetRandomWPID(cWaypointMaskExit);

   // Set visible
   hcUnitSetVisible(myID, true, false);   
   
   // Walk to fishing spot
   if (fishingwpid >= 0)
   {
      // Occupy waypoint
      hcOccupyWPID(fishingwpid);
            
      hcUnitMoveToWPID(myID, -1, fishingwpid, 1.5, 0.0, true);
      
      // Turn   
      vector waypointForward = hcGetWaypointDir(fishingwpid);
      hcUnitTurn(myID, waypointForward, 180.0, true);

      // Start fishing
      fish();

      // Free waypoint
      hcUnitFreeWPID(myID, fishingwpid, true);

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
// fishermanRestart
//==============================================================================
rule fishermanRestart
   active
   minInterval 200
   maxInterval 200
{
   int myID=hcGetMyUnitID();
   if (hcUnitGetActionType(myID) == cActionIdle)
   {
      goingFishing();
   }
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   goingFishing();
}
