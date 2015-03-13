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

REL_WaitForHullSafetyOff =
{
	/*
	if (IS_ARMA2) then
	{
		waitUntil
		{
			sleep 1;
			[] call hull_mission_fnc_hasSafetyTimerEnded;
		};
	}
	else
	{
		waitUntil
		{
			sleep 1;
			[] call hull3_mission_fnc_hasSafetyTimerEnded;
		};
	};
	*/
	sleep 5;
	hint "RELOCATE IS ON";
	[["Relocate has been activated."]] call REL_Debug_RPT;
	REL_DeployAllowed = true;
	publicVariable "REL_DeployAllowed";
};

REL_IsPlayerAGMInteractValid =
{
	FUN_ARGS_1(_player);
	DECLARE(_valid) = _player getVariable ["REL_AGM_INTERACT_VALID",false];
	_valid;
};