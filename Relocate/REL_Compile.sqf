#include "REL_Macros.h"

// Add:
// null = [] execVM "Relocate\REL_Compile.sqf";
// to your init.sqf

// IF USING AGM:
// Add:
// #include "Relocate\Compat\AGM\REL_AGM_Interact.h";
// to your description.ext

REL_Group_Deployment = []; // used for logging
REL_Presafety_Activation = false; // used to activate before Hull safety is turned off.

PRECOMPILE("Relocate\REL_Settings.sqf"); // Used for custom deploy functions and for limiting deployment
PRECOMPILE("Relocate\REL_Common_Functions.sqf"); // Used by both server and client

// Server Init
if (isServer) then
{
	PRECOMPILE("Relocate\REL_Server_Init.sqf");
	[] call REL_Server_Init;
};

// Client Init + SP Init
if (!isServer || !isMultiplayer) then
{
	PRECOMPILE("Relocate\REL_Client_Functions.sqf");
	PRECOMPILE("Relocate\REL_Addactions.sqf");
	PRECOMPILE("Relocate\REL_Debug.sqf");
  [player] call REL_EH_AssignPreSafetyActivation;
};