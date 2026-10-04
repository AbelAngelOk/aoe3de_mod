//==============================================================================
// mexico_nightlight_handler.xs
//==============================================================================

//==============================================================================
//Globals.

// We are running this rule once per frame
rule handleNightLights
  active
  minInterval 0
  maxInterval 0
{
   if (hcIsPropEnabledByName( "Mexico_LightSetNight" ) == true)
   {
      if (hcIsPropEnabledByName( "Mexico_TemploMayorTexture0" ) == true)
      {
         // If its nighttime and the temple ruins are not active and the night lights are not currently on, then turn them on.
         if (hcIsPropEnabledByName("Mexico_Night_Lights_Without_Temple") == false)
         {
            hcDisablePropByName("Mexico_Night_Lights");
            hcEnablePropByName( "Mexico_Night_Lights_Without_Temple" );
         }
      }
      else
      {
         // If its nighttime and the temple ruins are active and the night light are not currently on, then turn on all the lights except the temple
         if (hcIsPropEnabledByName("Mexico_Night_Lights") == false)
         {
            hcDisablePropByName("Mexico_Night_Lights_Without_Temple");
            hcEnablePropByName( "Mexico_Night_Lights" );
         }
      }
   }
   else
   {
      // If its not night time ensure that all lights are turned off.
      hcDisablePropByName("Mexico_Night_Lights");
      hcDisablePropByName( "Mexico_Night_Lights_Without_Temple" );
   }

}



//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{   

}