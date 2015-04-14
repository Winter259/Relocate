#include "REL_Macros.h"

REL_AllowDeploy_BLU 	= true;
REL_AllowDeploy_OPF 	= true;
REL_AllowDeploy_IND 	= true;
REL_AllowDeploy_CIV 	= false;

REL_AlternativeDeployAvailable = false;

REL_AlternativeDeploy = 
{
	FUN_ARGS_2(_group,_position);
	// Add any custom deploy code that will be executed instead of the usual deploy, can be anything from starting AI camps to a HALO drop.
  // EXAMPLE: HALO deployment script, makes the player's group do a HALO jump intead of a magic teleport
  [_group,_position] call REL_HaloDeploy;
};

REL_UseAGMInteract = false;

REL_Debug = true;