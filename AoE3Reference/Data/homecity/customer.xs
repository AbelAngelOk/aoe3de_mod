//==============================================================================
// customer.xs
//==============================================================================

//==============================================================================
//Globals.




rule customerWander
   active
   minInterval 0
   maxInterval 0
{

  
   int unitID = hcGetMyUnitID();
   if (hcUnitGetNumberOfActions(unitID) == 0)
   {
   
      // Get new waypoint
      int waypointID = hcGetRandomFreeWPID(cWaypointMaskCustomer);
      if (waypointID >= 0)
      {
         hcUnitMoveToWPID(unitID, -1, waypointID, 1.6, 0.1, true);
         hcUnitGoIdleForXSeconds(unitID,2.0,true);
                      
      }
    
   }
   
}

//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{   

}
