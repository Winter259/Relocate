#include "REL_Macros.h"

// Might have to be avoided
/*
REL_FindEmptyPosition =
{
	FUN_ARGS_(_position_centre);
	DECLARE(_empty_position) = _position findEmptyPosition
};
*/

REL_GroupDeployLogEH =
{
	"REL_Group_Deployment" addPublicVariableEventHandler
	{
		[["%1 attempted to deploy at %2",((_this select 1) select 0),((_this select 1) select 1)]] call REL_Debug_RPT;
	};
};

REL_PlayerIsValid =
{
	FUN_ARGS_1(_player);
	DECLARE(_valid) = true;
	if (!(isPlayer _player) or !(alive _player)) then
	{
		// unit is either AI or dead
		_valid = false;
	};
	_valid;
};

REL_LeaderIsValid =
{
	FUN_ARGS_1(_group);
	DECLARE(_leader) = leader _group;
	DECLARE(_valid) = [_leader] call REL_PlayerIsValid;
	_valid;
};

REL_PassOnAction =
{
	FUN_ARGS_1(_player);
	DECLARE(_group) = group _player;
	[["The leader %1 was not valid, passing on the action!",_player]] call REL_Debug_RPT;
	{
		if ([_x] call REL_PlayerIsValid) exitWith
		{
			[["Action has been passed on to: %1",_x]] call REL_Debug_Hint;
			[_x] call REL_GiveDeployAction;
		};
	} forEach units _group;
};