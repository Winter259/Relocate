#include "REL_Macros.h"

// Might have to be avoided
/*
REL_FindEmptyPosition =
{
	FUN_ARGS_(_position_centre);
	DECLARE(_empty_position) = _position findEmptyPosition
};
*/

REL_EH_AssignDeployLogging =
{
	"REL_Group_Deployment" addPublicVariableEventHandler
	{
		//[["%1 attempted to deploy at %2",((_this select 1) select 0),((_this select 1) select 1)]] call REL_Debug_RPT; // Debug is turned off for live play.
    diag_log format ["%1 - RELOCATE LOGGING: %1 attempted to deploy at co-ordinates: %2",((_this select 1) select 0),((_this select 1) select 1)];
	};
};

REL_EH_BouncePreSafetyDeployActivation = 
{
  // Required due to host not being able to deploy since EH will not fire on host's PC
  "REL_Presafety_Activation_Server" addPublicVariableEventHandler
	{
		REL_Presafety_Activation = true;
    publicVariable "REL_Presafety_Activation";
    [["Server is bouncing the Pre-Safety-Off value to all clients."]] call REL_Debug_RPT;
	};
};

REL_PlayerIsValid =
{
	FUN_ARGS_1(_player);
	DECLARE(_valid) = true;
	if (!(isPlayer _player)) then
	{
		_valid = false;
		[["Player: %1 is an AI!",_player]] call REL_Debug_RPT;
	};
	if (!(alive _player)) then
	{
		_valid = false;
		[["Player: %1 is dead!",_player]] call REL_Debug_RPT;
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
	PVT_2(_i,_unit);
	[["The leader %1 of group %2 was not valid, passing on the action!",_player,(group _player)]] call REL_Debug_RPT;
	for "_i" from 0 to ((count (units _group)) - 1) do
	{
		_unit = (units _group) select _i;
		if ([_unit] call REL_PlayerIsValid) exitWith
		{
			[["Action has been passed on to: %1",_unit]] call REL_Debug_RPT;
			//[_unit] call REL_GiveDeployAction;
			// Has to be run semi-/globally
			[-1, {[_this] call REL_GiveDeployAction;}, _unit] call CBA_fnc_globalExecute;
		};
	};
	/*
	{
		if ([_x] call REL_PlayerIsValid) exitWith
		{
			[["Action has been passed on to: %1",_x]] call REL_Debug_Hint;
			//[_x] call REL_GiveDeployAction;
			// Has to be run semi-/globally
			[-1, {[_this] call REL_GiveDeployAction;}, _x] call CBA_fnc_globalExecute;
		};
	} forEach units _group;
	*/
};

REL_WaitForRelocateActive =
{
  if (!REL_AllowPreSafetyDeploy) then
  {
    REL_Presafety_Activation = true;
    publicVariable "REL_Presafety_Activation";
    [["Relocate has been activated (PRE SAFETY OFF!)"]] call REL_Debug_RPT;
    [["Relocate has been activated (PRE SAFETY OFF!)"]] call REL_Debug_Hint;
  };
  if (IS_ARMA2 && REL_HullPresent) then
	{
		waitUntil
		{
			sleep 1;
			[] call hull_mission_fnc_hasSafetyTimerEnded;
		};
	};
	if (IS_ARMA3 && REL_HullPresent) then
	{
		waitUntil
		{
			sleep 1;
			[] call hull3_mission_fnc_hasSafetyTimerEnded;
		};
	};
	if (!REL_HullPresent) then
	{
		// Add enable addaction to host, for a future version
	};
  if (isMultiplayer) then
  {
    sleep 3;
  };
	REL_DeployAllowed = true; // 
	publicVariable "REL_DeployAllowed";
  [["Relocate has been activated (POST SAFETY OFF!)"]] call REL_Debug_RPT;
	[["Relocate has been activated (POST SAFETY OFF!)"]] call REL_Debug_Hint;
};