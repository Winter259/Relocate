#include "REL_Macros.h"

/*
// PLACEHOLDERS
REL_WEST_AllowDeploy 	= true;
REL_EAST_AllowDeploy 	= true;
REL_IND_AllowDeploy 	= false;
REL_CIV_AllowDeploy 	= true;

*/

REL_HullPresent = true;

REL_UseAGMInteract = false;

REL_AlternativeDeployAvailable = false;

REL_AlternativeDeploy = 
{
	FUN_ARGS_2(_group,_position);
	// Add any custom deploy code that will be executed instead of the usual deploy, can be anything from starting AI camps to a HALO drop.
  // EXAMPLE:
  [_group,_position] call REL_HaloDeploy;
};

REL_Debug = true;