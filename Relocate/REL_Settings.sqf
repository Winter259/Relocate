#include "REL_Macros.h"

// If true, it will assign deploy to a whole faction.
// Example: defending team is already in the position it will defend, only attackers deploy.
REL_AllowDeploy_BLU 	= true;
REL_AllowDeploy_OPF 	= true;
REL_AllowDeploy_IND 	= true;
REL_AllowDeploy_CIV 	= false;

// If true, a logged in host will have an addaction to enable pre safety off deploy.
REL_AllowPreSafetyDeploy = false;

// If true, it will allow a whole faction to deploy BEFORE hull safety is turned off.
// Example: one team has to choose a place to defend, other team then plans and deploys.
// Note: Currently only ONE team can have pre-safety-off deploy enabled!
REL_AllowPresafetyDeploy_BLU = false;
REL_AllowPresafetyDeploy_OPF = false;
REL_AllowPresafetyDeploy_IND = false;
REL_AllowPresafetyDeploy_CIV = false;

// Alternative deploy allows for the addition of any custom deploy code that will be executed instead of the usual deploy, can be anything from starting AI camps to a HALO drop.
REL_AlternativeDeployAvailable = false;

REL_AlternativeDeploy = 
{
	FUN_ARGS_2(_group,_position);
  // Example: HALO deployment script, makes the player's group do a HALO jump instead of a magic teleport
  [_group,_position] call REL_HaloDeploy;
};

REL_UseAGMInteract = false;

REL_Debug = true;