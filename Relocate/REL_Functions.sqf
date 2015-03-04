#include "REL_Macros.h"

REL_DeployGroup =
{
	FUN_ARGS_2(_group,_position);
	DECLARE(_side) = side _group;
	DECLARE(_position_x) = _position select 0;
	DECLARE(_position_y) = _position select 1;
	DECLARE(_position_z) = _position select 2;
	{
		_x setposATL [_position_x,_position_y,_position_z];
		// Co-ordinates are incremented slightly to avoid stacking all the units on top of each other
		INC(_position_x);
		INC(_position_y);
	} forEach units _group;
};

// Might have to be avoided
/*
REL_FindEmptyPosition =
{
	FUN_ARGS_(_position_centre);
	DECLARE(_empty_position) = _position findEmptyPosition
};
*/
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