#include "REL_Macros.h"

REL_Init =
{
	REL_Initialised = false;
	[] call REL_InitVariables;
	[] call REL_DetermineVersion;
	[] call REL_Precompile_Functions;
	[["Relocate version %1 has successfully initialised for ArmA %2.",REL_VERSION_STR,REL_ArmaVersion]] call REL_Debug_RPT;
	[] call REL_GroupDeployLogEH;
	REL_Initialised = true;
	publicVariable "REL_Initialised";
	sleep 2; // to remove
	[] call REL_AssignDeploy;
	[] spawn REL_WaitForHullSafetyOff;
};

REL_InitVariables =
{
	REL_ArmaVersion = 0;
	REL_DeployAllowed = false;
};

REL_Precompile_Functions =
{
	PRECOMPILE("Relocate\REL_Debug.sqf");
	PRECOMPILE("Relocate\REL_Settings.sqf");
	PRECOMPILE("Relocate\REL_Server_Functions.sqf");
	PRECOMPILE("Relocate\REL_Addactions.sqf");
};

REL_DetermineVersion =
{
	if (isNil {call compile "blufor"}) then
	{
		REL_ArmaVersion = 2;
		WAIT_DELAY(1,hull_isInitialized;);
	}
	else
	{
		REL_ArmaVersion = 3;
		WAIT_DELAY(1,hull3_isInitialized;);
	};
};
