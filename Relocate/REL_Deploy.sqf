#include "REL_Macros.h"

// _this select 1 is the person activating the action, _this select 2 is the ID of the action

private "_user";
_user = _this select 1;
hint "Click anywhere on the map to deploy to that location.";
if (!(isNull _user) && !(isNil "_user")) then
{
  [_user] call REL_AssignDeployClick;
}
else
{
  [["ERROR! User %1 was considered null/nil for some reason!",_user]] call REL_Debug_RPT;
  [["ERROR! User %1 was considered null/nil for some reason!",_user]] call REL_Debug_Hint;
};