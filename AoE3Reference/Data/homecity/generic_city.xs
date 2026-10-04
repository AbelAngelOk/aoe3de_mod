//==============================================================================
// generic_city.xs
//==============================================================================


//==============================================================================
//Globals.


//==============================================================================
// spawnQuartetMusicians
//==============================================================================
void spawnQuartetMusicians()
{
   // Create a group to put all the units in
   int groupID = hcCreatePerformerGroup(4);
   if (groupID < 0)
      return;

   vector pos = cInvalidVector;
   vector forward = xsVectorSet(0.0, 0.0, 1.0);
   int unitID = -1;

   unitID = hcUnitCreateUsingPos(-1, "homecity\\homecity_units\\quartet\\quartet_bass.xml", "quartet_musician", pos, forward, false);
   hcUnitSetInitialPauseTime(unitID, 0.0);
   hcAddUnitToPerformerGroup(groupID, unitID);

   unitID = hcUnitCreateUsingPos(-1, "homecity\\homecity_units\\quartet\\quartet_cello.xml", "quartet_musician", pos, forward, false);
   hcUnitSetInitialPauseTime(unitID, 1.0);
   hcAddUnitToPerformerGroup(groupID, unitID);

   unitID = hcUnitCreateUsingPos(-1, "homecity\\homecity_units\\quartet\\quartet_viola.xml", "quartet_musician", pos, forward, false);
   hcUnitSetInitialPauseTime(unitID, 2.0);
   hcAddUnitToPerformerGroup(groupID, unitID);

   unitID = hcUnitCreateUsingPos(-1, "homecity\\homecity_units\\quartet\\quartet_violin.xml", "quartet_musician", pos, forward, false);
   hcUnitSetInitialPauseTime(unitID, 3.0);
   hcAddUnitToPerformerGroup(groupID, unitID);
}



//==============================================================================
// gameOver()
// This handler is called when the game ends to start a home city effect.
//==============================================================================
void gameOver(int gameOverState = -1) // Event handler
{
}

//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   // Set up the handlers
   hcSetXSHandler("gameOver", cXSHCGameOverHandler);
         
   // Populate the home city
   hcPopulateHomeCity();
}
