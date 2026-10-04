//==============================================================================
// parade.xs
//==============================================================================

//==============================================================================
//Globals.





void spawnUnit()
{
   int myID=hcGetMyUnitID();

   int i = 0;
   int numberOfWaypoints = hcGetNumberMaskWaypoints(cWaypointMaskParadeNext);
   //hcEcho("spawnUnit() numberOfWaypoints "+numberOfWaypoints);
   for(i=0; <numberOfWaypoints)  
   {   
      int paradeID = hcGetMaskWaypoint(cWaypointMaskParadeNext,i);
      //hcEcho("spawnUnit() waypointID "+paradeID);
      hcUnitMoveToWPID(myID, -1, paradeID,  1.8, 3.0, true);
   }
   hcUnitExit(myID, true);

}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{   
 
   // Set up the handlers
   int unitID = hcGetMyUnitID();

   //hcEcho("parade : main() Unit ID "+unitID);

   
   //Start.
   spawnUnit();
}
