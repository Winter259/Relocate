#include "REL_Macros.h"

REL_Init =
{
	REL_Initialised = false;
	[] call REL_Precompile_Functions;
	REL_Initialised = true;
	publicVariable "REL_Initialised";
};

REL_Precompile_Functions =
{
	PRECOMPILE("REL/REL_Settings.sqf");
	DEBUG
	{
		PRECOMPILE("REL/REL_Debug.sqf");
	};
	PRECOMPILE("REL/REL_Functions.sqf");
};