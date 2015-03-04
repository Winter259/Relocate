#include "REL_Macros.h"

// Add:
// null = [] execVM "REL/REL_Compile.sqf";
// to your init.sqf

if (isServer) then
{
	PRECOMPILE("Relocate\REL_Init.sqf");
	[] call REL_Init;
};