//==============================================================================
// hunchback.xs
//
// Basic script to just move around Notre Dame
//==============================================================================


int lastPlayedBoredAnimation = 3;
bool firstTime = true;
      
void hunchbackDo( void )
{
   // Get unit ID
   int myID=hcGetMyUnitID(); 


   // Set visible
   hcUnitSetVisible(myID, true, false);

   // Never repeat the same animation back to back
   int playBoredAnim = lastPlayedBoredAnimation + 1 + hcRandInt(3);

   if( playBoredAnim >= 4 )
      playBoredAnim = playBoredAnim - 4;
   
   // Pass -1 to the loop parameter when playing all these anims since
   // we don't want these to interpolate.
   if (playBoredAnim == 0)
      hcUnitPlayAnim(myID, "Bored_A", 0, -2, true);
   if (playBoredAnim == 1)
      hcUnitPlayAnim(myID, "Bored_B", 0, -2, true);
   if (playBoredAnim == 2)
      hcUnitPlayAnim(myID, "Bored_C", 0, -2, true);
   if (playBoredAnim == 3)
      hcUnitPlayAnim(myID, "Bored_D", 0, -2, true);
      
   lastPlayedBoredAnimation = playBoredAnim;
   
   // Set invisible
   hcUnitSetVisible(myID, false, true);
}


//==============================================================================
// hunchbackRestart
//==============================================================================
rule hunchbackRestart
   active
   minInterval 0
   maxInterval 0
{
   if(firstTime != true)
      hunchbackDo();
      
   firstTime = false;      
   
   // Wait before showing up again
   float seconds = 15 + hcRandInt(45);
     
   xsSetRuleMinIntervalSelf(seconds);
   xsSetRuleMaxIntervalSelf(seconds);
}


//==============================================================================
// comeOut
//==============================================================================
void comeOut(int param = -1) // Event handler
{
   xsSetRuleMinInterval("hunchbackRestart", 0);
   xsSetRuleMaxInterval("hunchbackRestart", 0);
   xsEnableRule("hunchbackRestart");
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   // Set up the handlers
   int unitID = hcGetMyUnitID();
   hcSetUnitXSHandler(unitID, "comeOut", cComeOutHandler);
}
