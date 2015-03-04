#include "REL_Macros.h"

REL_DeployGroup =
{
	FUN_ARGS_3(_player,_position,_actionID);
	DECLARE(_group) = group _player;
	[_player,_actionID] call REL_RemoveDeploy;
	REL_Group_Deployment = [_player,_position];
	publicVariableServer "REL_Group_Deployment";
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

REL_AssignDeployClick =
{
	FUN_ARGS_2(_player,_actionID);
	DECLARE(_group) = group _player;
	[_player,_actionID] onMapSingleClick {[(_this select 0),_pos,(_this select 1)] call REL_DeployGroup;};
};

REL_RemoveDeploy =
{
	FUN_ARGS_2(_player,_actionID);
	_player removeAction _actionID;
	onMapSingleClick "";
};