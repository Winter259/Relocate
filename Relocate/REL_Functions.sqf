#include "REL_Macros.h"

REL_DeployGroup =
{
	FUN_ARGS_2(_group,_position);
	DECLARE(_side) = side _group;
	DECLARE(_position_x) = _position select 0;
	DECLARE(_position_y) = _position select 1;
	DECLARE(_position_z) = _position select 2;
	{
		_x setposATL [_position_x,_position_y,_position_z];
		// Co-ordinates are incremented slightly to avoid stacking all the units on top of each other
		INC(_position_x);
		INC(_position_y);
	} forEach units _group;
};

REL_FindEmptyPosition =
{
	FUN_ARGS_(_position_centre);
	DECLARE(_empty_position) = _position findEmptyPosition
};