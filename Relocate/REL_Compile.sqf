#include "REL_Macros.h"

// Add:
// [] execVM "REL/REL_Compile.sqf"
// to your init.sqf

if (isServer) then
{
	PRECOMPILE("REL/REL_Init.sqf");
	[] call REL_Init;
};
