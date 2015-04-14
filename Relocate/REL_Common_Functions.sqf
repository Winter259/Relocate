#include "REL_Macros.h"

REL_SetPlayerDeployedStatus =
{
	FUN_ARGS_2(_player,_status);
	_player setVariable ["REL_PlayerDeployed",_status,true];
};

REL_GetPlayerDeployedStatus =
{
	FUN_ARGS_1(_player);
	PVT_1(_status);
	_status = _player getVariable ["REL_PlayerDeployed",false];
	_status;
};

REL_SetDeployActionID =
{
  FUN_ARGS_2(_player,_actionID);
  _player setVariable ["REL_CurrentActionID",_actionID,true];
};

REL_GetDeployActionID =
{
	FUN_ARGS_1(_player);
	PVT_1(_actionID);
	_actionID = _player getVariable ["REL_CurrentActionID",nil];
	_actionID;
};