#include "REL_Macros.h"

REL_EngineerDuplicateFix =
{
  FUN_ARGS_1(_player);
  // Hacky workaround for ENG teams all taking gear from ENG template
  _player setVariable ["REL_EngineerDuplicateCheck",true,true];
};

REL_EngineerAssignCheck =
{
  FUN_ARGS_1(_group);
  DECLARE(_already_has_deploy) = false;
  PVT_1(_deploy_check);
  // Hacky workaround for ENG teams all taking gear from ENG template
  {
    _deploy_check = _x getVariable ["REL_EngineerDuplicateCheck",false];
    if (_deploy_check) then
    {
      _already_has_deploy = true;
      [["WARNING: PLAYER %1 IN GROUP %2 ALREADY HAS DEPLOY!",_x,_group]] call REL_Debug_RPT;
    };
  } forEach units _group;
  _already_has_deploy;
};