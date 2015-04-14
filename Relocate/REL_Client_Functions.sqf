#include "REL_Macros.h"

REL_EH_AssignPreSafetyActivation =
{
  // This works in MP ONLY! #blameBI
  "REL_Presafety_Activation" addPublicVariableEventHandler
	{
		if ([player] call REL_IsSideAllowedPreDeploy) then
    {
      REL_DeployAllowed = true; // Turns on deploy action
      [["Player: %1 has been allowed to deploy before Hull safety was turned off",player]] call REL_Debug_RPT;
    };
	};
};

REL_IsSideAllowedPreDeploy =
{
  FUN_ARGS_1(_player);
  DECLARE(_allowed) = false;
  switch (side _player) do
  {
    case blufor:      {if (REL_AllowPresafetyDeploy_BLU) then {_allowed = true;}};
    case opfor:       {if (REL_AllowPresafetyDeploy_OPF) then {_allowed = true;}};
    case resistance:  {if (REL_AllowPresafetyDeploy_IND) then {_allowed = true;}};
    case civilian:    {if (REL_AllowPresafetyDeploy_CIV) then {_allowed = true;}};
  };
  [["PRE SAFETY OFF CHECK: Player: %1 Side: %2 Allowed: %3",_player,side _player,_allowed]] call REL_Debug_RPT;
  [["PRE SAFETY OFF CHECK: Player: %1 Side: %2 Allowed: %3",_player,side _player,_allowed]] call REL_Debug_Hint;
  _allowed;
};

REL_DeployGroup =
{
	FUN_ARGS_2(_player,_position);
	DECLARE(_group) = group _player;
  DECLARE(_actionID) = [_player] call REL_GetDeployActionID;
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
	FUN_ARGS_1(_player);
	[_player] onMapSingleClick {[(_this select 0),_pos] call REL_DeployGroup;};
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