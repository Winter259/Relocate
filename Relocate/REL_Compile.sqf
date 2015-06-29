#include "REL_Macros.h"

// Add:
// null = [] execVM "Relocate\REL_Compile.sqf";
// to your init.sqf

// If using ACE:
// Add:
// #include "Relocate\ace\REL_ACE_Deploy.hpp"
// to your description.ext

REL_Group_Deployment = []; // used for logging
REL_Presafety_Activation = false; // used to activate before Hull safety is turned off.

PRECOMPILE("Relocate\REL_Settings.sqf"); // Used for custom deploy functions and for limiting deployment
PRECOMPILE("Relocate\REL_Common_Functions.sqf"); // Used by both server and client

// Server Init
if (isServer) then {
    PRECOMPILE("Relocate\REL_Server_Init.sqf");
    [] call REL_Server_Init;
};

// Client Init + SP Init
if (!isServer || !isMultiplayer) then {
    PRECOMPILE("Relocate\REL_Client_Init.sqf");
    [] call REL_Client_Init;
};