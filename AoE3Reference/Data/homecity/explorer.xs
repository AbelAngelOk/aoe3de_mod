//==============================================================================
// explorer.xs
//
//==============================================================================

bool gPanelOn = false;

void signalHandler(int param = -1) // Event handler
{
   if(param == eUnitSelectionStatus && gPanelOn == false)
   {
    
      gPanelOn = true;
      hcMakeCustomisationPanelReal();
      hcFadeOutUnitsByScriptname("citizen",2);
   }
   else if(param == eUnitSelectionStatus && gPanelOn == true)
   {
      gPanelOn = false;
      hcMakeCustomisationPanelUnreal();
      hcFadeInUnitsByScriptname("citizen",2);
   }
}

//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   // Get unit ID
   int unitID = hcGetMyUnitID(); 
  
   if(hcIsHistoricalCampaign() == false || hcIsGameTypeCampaign() == false)
   {
      hcSetParticleEffect(unitID,"explorer_aura","objects/hero_unit_glow.pkfx");
      hcStartParticleEffect(unitID,"explorer_aura");
      hcSetUnitXSHandler(unitID, "signalHandler", cSignalUnitHandler);
   }
   else 
   {
      hcUnitExit(unitID,false);
   }

}
