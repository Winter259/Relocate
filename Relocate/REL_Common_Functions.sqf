#include "REL_Macros.h"

REL_IsAdmin =
{
  FUN_ARGS_1(_player);
  DECLARE(_isAdmin) = false;
  if (serverCommandAvailable "#logout") then
  {
    _isAdmin = true;
    [["Player: %1 is logged in as Admin",_player]] call REL_Debug_RPT;
    [["Player: %1 is logged in as Admin",_player]] call REL_Debug_Hint;
    [["Player: %1 is logged in as Admin",_player]] call REL_Server_Log;
  };
  _isAdmin;
};

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

REL_SetDeployAssigned =
{
  FUN_ARGS_2(_player,_status);
  _player setVariable ["REL_PlayerAssignedDeploy",_status,true];
};

REL_GetDeployAssigned =
{
  FUN_ARGS_1(_player);
  PVT_1(_status);
	_status = _player getVariable ["REL_PlayerAssignedDeploy",false];
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

REL_ReturnGearClass =
{
  FUN_ARGS_1(_player);
  PVT_1(_gearClass);
  if (IS_ARMA2) then
	{
		_gearClass = _player getVariable "hull_gear_class";
	}
	else
	{
		_gearClass = _player getVariable "hull3_gear_class";
	};
  _gearClass;
};

REL_ReturnFactionString =
{
  FUN_ARGS_1(_side);
  DECLARE(_string) = "";
  //if (_side != "") then
  if (!isNil "_side") then
  {
    switch (_side) do
    {
      case blufor:      {_string = "BLUFOR";  };
      case opfor:       {_string = "OPFOR";   };
      case resistance:  {_string = "INDFOR";  };
      case civilian:    {_string = "CIVILIAN";};
    };
  }
  else
  {
    [["WARNING! No valid faction passed, no string returned."]] call REL_Debug_RPT;
    [["WARNING! No valid faction passed, no string returned."]] call REL_Debug_Hint;
  };
  _string;
};

REL_ReturnFactionHTMLColour =
{
  FUN_ARGS_1(_side);
  DECLARE(_string) = "";
  switch (_side) do
  {
    case blufor:      {_string = BLUFOR_COLOUR_HTML;  };
    case opfor:       {_string = OPFOR_COLOUR_HTML;   };
    case resistance:  {_string = INDFOR_COLOUR_HTML;  };
    case civilian:    {_string = CIV_COLOUR_HTML;     };
  };
  _string;
};

REL_ReturnHTMLColouredText =
{
  FUN_ARGS_2(_text,_html_colour);
  DECLARE(_first_colour_tag) = format ["<t color = '%1'>",_html_colour];
  DECLARE(_coloured_text) = format ["%1%2%3",_first_colour_tag,_text,"</t>"];
  _coloured_text;
};