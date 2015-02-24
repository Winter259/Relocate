#include "REL_Macros.h"

REL_Init =
{
	REL_Initialised = false;
	[] call REL_InitVariables;
	[] call REL_Precompile_Functions;
	REL_Initialised = true;
	publicVariable "REL_Initialised";
};

REL_InitVariables =
{
	REL_Version = 0;]
	REL_DeployAllowed = false;
};

REL_Precompile_Functions =
{
	PRECOMPILE("REL/REL_Settings.sqf");
	DEBUG
	{
		// Compiling Debug functions only if debug is enabled.
		PRECOMPILE("REL/REL_Debug.sqf");
	};
	PRECOMPILE("REL/REL_Functions.sqf");
};

REL_DetermineVersion =
{
	DECLARE(_version) = (productVersion select 1);
	if ("2" in _version) then
	{
		REL_Version = 2;
	}
	else
	{
		REL_Version = 3;
	};
};
