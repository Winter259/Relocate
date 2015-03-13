#include "REL_Macros.h"

// Add:
// null = [] execVM "Relocate\REL_Compile.sqf";
// to your init.sqf

// Add:
// #include "Relocate\REL_AGM_Interact.h";
// to your description.ext

REL_Group_Deployment = [];

if (isServer) then
{
	PRECOMPILE("Relocate\REL_Init.sqf");
	[] call REL_Init;
}
else
{
	PRECOMPILE("Relocate\REL_Init.sqf");
	PRECOMPILE("Relocate\REL_Settings.sqf");
	PRECOMPILE("Relocate\REL_Client_Functions.sqf");
	PRECOMPILE("Relocate\REL_Addactions.sqf");
	PRECOMPILE("Relocate\REL_Debug.sqf");
	PRECOMPILE("Relocate\REL_Common_Functions.sqf");
};

if (!isMultiplayer) then
{
	PRECOMPILE("Relocate\REL_Settings.sqf");
	PRECOMPILE("Relocate\REL_Client_Functions.sqf");
	PRECOMPILE("Relocate\REL_Addactions.sqf");
	PRECOMPILE("Relocate\REL_Debug.sqf");
	PRECOMPILE("Relocate\REL_Common_Functions.sqf");
};