#include "REL_Macros.h"

REL_AssignEngineerDuplicateFix =
{
  FUN_ARGS_2(_player,_gear_class);
  if ((_gear_class == "ENG") && !([_player] call REL_CheckEngineerGroupForDuplicates)) then
  {
    [_player] call REL_EngineerDuplicateFix;
  };
};

REL_EngineerDuplicateFix =
{
  FUN_ARGS_1(_player);
  DECLARE(_group) = group _player;
  // Hacky workaround for ENG teams all taking gear from ENG template, thus being all engineers
  [_player,true] call REL_SetDeployAssigned;
  [["WARNING: ENGINEER DUPLICATE FIX DEPLOYED FOR: %1 IN GROUP %2",_player,_group]] call REL_Debug_RPT;
  [["WARNING: ENGINEER DUPLICATE FIX DEPLOYED FOR: %1 IN GROUP %2",_player,_group]] call REL_Debug_Hint;
  [["WARNING: ENGINEER DUPLICATE FIX DEPLOYED FOR: %1 IN GROUP %2",_player,_group]] call REL_Server_Log;
};

REL_CheckEngineerGroupForDuplicates =
{
  FUN_ARGS_1(_player);
  DECLARE(_group) = group _player;
  DECLARE(_already_has_deploy) = [_group] call REL_GroupHasDeploy;
  if (_already_has_deploy) then
  {
    [["WARNING: GROUP %1 ALREADY HAS DEPLOY!",_group]] call REL_Debug_RPT;
    [["WARNING: GROUP %1 ALREADY HAS DEPLOY!",_group]] call REL_Debug_Hint;
  };
  _already_has_deploy;
};