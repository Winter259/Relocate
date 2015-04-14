#include "REL_Macros.h"

// _this select 1 is the person activating the action, _this select 2 is the ID of the action

hint "Click anywhere on the map to deploy to that location.";
[_this select 1] call REL_AssignDeployClick;