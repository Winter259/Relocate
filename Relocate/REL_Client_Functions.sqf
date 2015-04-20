#include "REL_Macros.h"

REL_EH_PreSafetyActivation =
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

REL_DeterminePreSafetyFaction =
{
  DECLARE(_side) = ObjNull;
  if (REL_AllowPresafetyDeploy_BLU) then {_side = west;};
  if (REL_AllowPresafetyDeploy_OPF) then {_side = east;};
  if (REL_AllowPresafetyDeploy_IND) then {_side = resistance;};
  if (REL_AllowPresafetyDeploy_CIV) then {_side = civilian;};
  if (isNull _side) then
  {
    [["WARNING! No valid faction chosen for pre-safety-off deploy. Did you set it to true in settings?"]] call REL_Debug_RPT;
    [["WARNING! No valid faction chosen for pre-safety-off deploy. Did you set it to true in settings?"]] call REL_Debug_Hint;
    if (REL_AllowPreSafetyDeploy) then
    {
      [["WARNING! Pre-safety-off deploy is enabled but no faction will has been defined to receive it."]] call REL_Debug_RPT;
      [["WARNING! Pre-safety-off deploy is enabled but no faction will has been defined to receive it."]] call REL_Debug_Hint;
    };
  }
  else
  {
    [["Pre-Safety-Off faction is: %1.",_side]] call REL_Debug_Hint;
    [["Pre-Safety-Off faction is: %1.",_side]] call REL_Debug_RPT;
  };
  _side;
};

REL_AssignPreSafetyAddaction =
{
  FUN_ARGS_1(_player);
  DECLARE(_pre_safety_side) = [] call REL_DeterminePreSafetyFaction;
  DECLARE(_side_string) = [_pre_safety_side] call REL_ReturnFactionString;
  DECLARE(_faction_string) = [_side_string,([_pre_safety_side] call REL_ReturnFactionHTMLColour)] call REL_ReturnHTMLColouredText;
  DECLARE(_addaction_string) = format["<t color ='%1'>Group Deploy: Activate %2 Deploy</t>",REL_ACTION_COLOUR_HTML,_faction_string];
  if (([_player] call REL_IsAdmin || !isMultiplayer) && REL_AllowPreSafetyDeploy && (REL_AllowPresafetyDeploy_BLU || REL_AllowPresafetyDeploy_OPF || REL_AllowPresafetyDeploy_IND || REL_AllowPresafetyDeploy_CIV)) then
  {
     _player addaction [_addaction_string,"Relocate\REL_Pre_Safety_Deploy.sqf",nil,-100,true,true,"","(_target == _this)"];
     [["Player: %1 has been assigned the Pre-Safety-Off addaction",_player]] call REL_Debug_RPT;
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
		[_player,_actionID] call REL_RemoveDeployAction;
	}
	else
	{
		[_player,nil] call REL_RemoveDeployAction; // AGM Interact does not have an actionID
	};
  [["Player: %1 deployed at co-ordinates: %2",_player,_position]] call REL_Server_Log;
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
    openMap false;
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