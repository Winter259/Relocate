#include "REL_Macros.h"

REL_DeployGroup =
{
	FUN_ARGS_2(_group,_position);
	DECLARE(_side) = side _group;
	{
		_x setposATL _position;
	} forEach units _group;
};

REL_FindEmptyPosition =
{
	FUN_ARGS_(_position_centre);
	DECLARE(_empty_position) = _position findEmptyPosition
};