#include "REL_Macros.h"

REL_Client_Init =
{
	[] call REL_Precompile_Client_Functions;
  [] call REL_EH_AssignPreSafetyActivation;
  [player] call REL_AssignPreSafetyAddaction;
};

REL_Precompile_Client_Functions =
{
  PRECOMPILE("Relocate\REL_Debug.sqf");
  [["Performing client init on player: %1",player]] call REL_Debug_RPT;
  [["Performing client init on player: %1",player]] call REL_Debug_Hint;
  PRECOMPILE("Relocate\REL_Client_Functions.sqf");
	PRECOMPILE("Relocate\REL_Addactions.sqf");
  [["Completed client init on player: %1",player]] call REL_Debug_RPT;
  [["Completed client init on player: %1",player]] call REL_Debug_Hint;
};