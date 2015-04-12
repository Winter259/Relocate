#include "REL_Macros.h"

REL_AssignAGMDeployClick =
{
	FUN_ARGS_1(_player);
	hint "Click anywhere on the map to deploy to that location.";
	_player onMapSingleClick {[_this,_pos,nil] call REL_DeployGroup;};
};