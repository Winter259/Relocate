#include "REL_Macros.h"

REL_CheckPlayerValidity =
{
	FUN_ARGS_1(_player);
	DECLARE(_valid) = true;
	if (!(isPlayer _player) or !(alive _player)) then
	{
		// unit is either AI or dead
		_valid = false;
	};
	_valid;
};

REL_CheckLeader =
{
	FUN_ARGS_1(_group);
	DECLARE(_leader) = leader _group;
	DECLARE(_valid) = [_leader] call REL_CheckPlayerValidity;
	_valid;
};

REL_PassOnAction =
{
	
};