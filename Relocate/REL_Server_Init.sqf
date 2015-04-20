#include "REL_Macros.h"

REL_Server_Init =
{
	REL_Initialised = false;
	[] call REL_InitVariables;
	[] call REL_DetermineVersion;
	[] call REL_Precompile_Functions;
	[["Relocate version %1 has successfully initialised for ArmA %2. Hull is present: %3",REL_VERSION_STR,REL_ArmaVersion,REL_HullPresent]] call REL_Debug_RPT;
	[] call REL_EH_AssignDeployLogging;
  [] call REL_EH_BouncePreSafetyDeployActivation;
	REL_Initialised = true;
	publicVariable "REL_Initialised";
	[["Completed server init"]] call REL_Debug_RPT;
  [["Completed server init"]] call REL_Debug_Hint;
	[] call REL_GlobalAssignDeploy;
	[] spawn REL_WaitForRelocateActive;
};

REL_InitVariables =
{
	REL_ArmaVersion = 0;
	REL_DeployAllowed = false;
  REL_HullPresent = false;
  REL_Presafety_Activation_Server = false;
};

REL_Precompile_Functions =
{
	PRECOMPILE("Relocate\REL_Debug.sqf");
  [["Performing server init"]] call REL_Debug_RPT;
  [["Performing server init"]] call REL_Debug_Hint;
	PRECOMPILE("Relocate\REL_EngineerFix.sqf");
	PRECOMPILE("Relocate\REL_Server_Functions.sqf");
	PRECOMPILE("Relocate\REL_Addactions.sqf");
	if (REL_UseAGMInteract) then
	{
		PRECOMPILE("Relocate\Compat\AGM\REL_AGM_Functions.sqf");
	};
};

REL_DetermineVersion =
{
	if (isNil {call compile "blufor"}) then
	{
		REL_ArmaVersion = 2;
    waitUntil
    {
      sleep 1;
      !isNil "hull_isInitialized";
    };
    WAIT_DELAY(1,hull_isInitialized;);
    REL_HullPresent = true;
    publicVariable "REL_HullPresent";
	}
	else
	{
		REL_ArmaVersion = 3;
		waitUntil
    {
      sleep 1;
      !isNil "hull3_isInitialized";
    };
    WAIT_DELAY(1,hull3_isInitialized;);
    REL_HullPresent = true;
    publicVariable "REL_HullPresent";
	};
};
