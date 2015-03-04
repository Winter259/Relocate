#include "REL_Macros.h"

// Add:
// null = [] execVM "REL/REL_Compile.sqf";
// to your init.sqf

REL_Group_Deployment = [];

if (isServer) then
{
	PRECOMPILE("Relocate\REL_Init.sqf");
	[] call REL_Init;
}
else
{
	PRECOMPILE("Relocate\REL_Client_Functions.sqf");
};

if (!isMultiplayer) then
{
	PRECOMPILE("Relocate\REL_Client_Functions.sqf");
};