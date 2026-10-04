

void shutdownMarketBrowsers(void)
{

}

void startupMarketBrowsers(void)
{


}


void disableMarket(int param = -1) // Event handler
{
//   hcEcho("indian_market - disableMarket");
   hcSetDefaultPatherID(0);
   shutdownMarketBrowsers();
   hcResetUnitsByScriptname("citizen");
   hcResetUnitsByScriptname("monkey");
}

void enableMarket(int param = -1) // Event handler
{
 //  hcEcho("indian_market - enableMarket");
   hcSetDefaultPatherID(1);
   startupMarketBrowsers();
   hcResetUnitsByScriptname("citizen");
   hcResetUnitsByScriptname("monkey");  
}


//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   int unitID = hcGetMyUnitID();
   hcSetUnitXSHandler(unitID, "disableMarket", cDisableUnitHandler);
   hcSetUnitXSHandler(unitID, "enableMarket", cEnableUnitHandler);

   // Enable the new pather
   hcSetDefaultPatherID(1);
   startupMarketBrowsers();
   hcResetUnitsByScriptname("citizen");
   hcResetUnitsByScriptname("monkey"); 
  
}