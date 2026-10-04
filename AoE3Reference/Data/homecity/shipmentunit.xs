//==============================================================================
// shipmentUnit.xs
//==============================================================================

//==============================================================================
//Globals.

//==============================================================================
// walkToLoadingArea
//==============================================================================
bool walkToLoadingArea(void)
{
   int myID=hcGetMyUnitID();

   // Wait for some time to space out the shipped units
   float pauseTime = hcUnitGetInitialPauseTime(myID);
   hcUnitWait(myID, pauseTime, false);
   
   // Move to goal   
   int endWPID = hcGetRandomWPID(cWaypointMaskShipmentEnd);
   hcUnitMoveToWPID(myID, -1, endWPID, 0.0, 0.2, true);
   hcUnitExit(myID, true);

   return(true);
}

//==============================================================================
// cancelShipment()
// This handler is called when the shipment this unit is in is canceled.
//==============================================================================
void cancelShipment(int param = -1) // Event handler
{
   int unitID = hcGetMyUnitID();

   // Get random exit WPID
   int exitWPID=hcGetRandomWPID(cWaypointMaskExit);
   if (exitWPID < 0)
      return;
      
   // Move to exit
   hcUnitMoveToWPID(unitID, 0, exitWPID, 2.0, 1.0, false);

   // Go away
   hcUnitExit(unitID, true);
}

//==============================================================================
// restartShipment()
// This handler is called when the shipment this unit was in is restarted.
//==============================================================================
void restartShipment(int param = -1) // Event handler
{
   walkToLoadingArea();
}

//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   // Set up the handlers
   int unitID = hcGetMyUnitID();
   hcSetUnitXSHandler(unitID, "cancelShipment", cCancelShipmentHandler);
   hcSetUnitXSHandler(unitID, "restartShipment", cRestartShipmentHandler);
   
   // Start.
   walkToLoadingArea();
}
