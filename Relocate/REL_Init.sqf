#include "REL_Macros.h"

REL_Init =
{
	REL_Initialised = false;
	[] call REL_InitVariables;
	[] call REL_DetermineVersion;
	[] call REL_Precompile_Functions;
	[["Relocate version %1 has successfully initialised for ArmA %2.",REL_ArmaVersion_STR,REL_ArmaVersion]] call REL_Debug_RPT;
	REL_Initialised = true;
	publicVariable "REL_Initialised";
};

REL_InitVariables =
{
	REL_ArmaVersion = 0;
	REL_DeployAllowed = false;
};

REL_Precompile_Functions =
{
	PRECOMPILE("REL/REL_Debug.sqf");
	PRECOMPILE("REL/REL_Settings.sqf");
	PRECOMPILE("REL/REL_Functions.sqf");
};

REL_DetermineVersion =
{
	DECLARE(_version) = (productVersion select 1);
	if ("2" in _version) then
	{
		REL_ArmaVersion = 2;
	}
	else
	{
		REL_ArmaVersion = 3;
	};
};
