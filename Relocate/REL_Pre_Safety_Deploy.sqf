#include "REL_Macros.h"

// _this select 1 is the person activating the action, _this select 2 is the ID of the action
//(_this select 1) removeAction (_this select 2);
DECLARE(_pre_safety_side) = [] call REL_DeterminePreSafetyFaction;
DECLARE(_side_string) = [_pre_safety_side] call REL_ReturnFactionString;
REL_Presafety_Activation_Server = true;
sleep 1; // possibly not needed
publicVariableServer "REL_Presafety_Activation_Server";
hint format ["Deploy for: %1 has been enabled",_side_string];