#include "REL_Macros.h"

REL_DeployGroup =
{
	FUN_ARGS_3(_player,_position,_actionID);
	DECLARE(_group) = group _player;
	if (!isNil "_actionID") then
	{
		[_player,_actionID] call REL_RemoveDeploy;
	}
	else
	{
		[_player,nil] call REL_RemoveDeploy; // AGM Interact does not have an actionID
	};
	REL_Group_Deployment = [_player,_position];
	publicVariableServer "REL_Group_Deployment";
	if (!REL_AlternativeDeployAvailable) then
	{
		DECLARE(_side) = side _group; // not used yet.
		DECLARE(_position_x) = _position select 0;
		DECLARE(_position_y) = _position select 1;
		DECLARE(_position_z) = _position select 2;
		{
			_x setposATL [_position_x,_position_y,_position_z];
			// Co-ordinates are incremented slightly to avoid stacking all the units on top of each other
			INC(_position_x);
			INC(_position_y);
		} forEach units _group;
		[_player,true] call REL_SetPlayerDeployedStatus;
		hint "Deploy successful";
	}
  else
  {
    [_group,_position] spawn REL_AlternativeDeploy;
  };
};

REL_AssignDeployClick =
{
	FUN_ARGS_2(_player,_actionID);
	[_player,_actionID] onMapSingleClick {[(_this select 0),_pos,(_this select 1)] call REL_DeployGroup;};
};

REL_RemoveDeploy =
{
	FUN_ARGS_2(_player,_actionID);
	if (!isNil "_actionID") then
	{
		_player removeAction _actionID;
	};
	onMapSingleClick "";
};

REL_HaloDeploy = 
{
  FUN_ARGS_1(_group,_position);
  DECLARE(_position_x) = (_position select 0) + random HALO_DROP_RADIUS;
  DECLARE(_position_y) = (_position select 1) + random HALO_DROP_RADIUS;
  DECLARE(_position_z) = HALO_DROP_HEIGHT;
	{
		_x setposATL [_position_x,_position_y,_position_z];
    //[_x] spawn REL_HaloDeploy_PlaceInParachute; // has to be run where the player is local ONLY
    [-1, {[_this] spawn REL_HaloDeploy_PlaceInParachute;}, _x] call CBA_fnc_globalExecute;
    sleep HALO_DROP_DELAY;
	} forEach units _group;
};

REL_HaloDeploy_PlaceInParachute =
{
  FUN_ARGS_1(_player);
  if (local _player) then
  {
    PVT_1(_parachute);
    waitUntil
    {
      sleep 1;
      ((getposATL _player) select 2) < HALO_PARACHUTE_OPEN_ALTITUDE;
    };
    100 cutText ["","BLACK",1,false];
    sleep 1;
    _parachute = createVehicle ["Steerable_Parachute_F",(getPosATL _player), [], 2, "FLY"];
    _parachute setVelocity [0,0,-10];
    _player moveInDriver _parachute;
    sleep 1;
    100 cutFadeOut 3;
  };
};