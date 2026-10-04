//==============================================================================
// stagecoach.xs
//
//==============================================================================



void stagecoachDo( void )
{
   // Get unit ID
   int myID=hcGetMyUnitID(); 

   hcUnitPlayAnim(myID, "Idle", 0, -1, false);


   int i = 0;
   
   for(i = 0; < 15)
   {
      hcUnitPlayAnim(myID, "Idle", 0, -1, true);
   }
   
   hcUnitGoIdle(myID, true);    
}


//==============================================================================
// stagecoachRestart
//==============================================================================
rule stagecoachRestart
   active
   minInterval 60
   maxInterval 60
{
   int myID=hcGetMyUnitID();
   if (hcUnitGetActionType(myID) == cActionIdle)
   {
      stagecoachDo();
   }
}



//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   stagecoachDo();
}
