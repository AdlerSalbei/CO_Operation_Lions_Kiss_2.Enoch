["Initialize"] call BIS_fnc_dynamicGroups;

["grad_changeWeather", {_this call grad_user_fnc_setTimeAndWeather;}] call CBA_fnc_addEventHandler;
["grad_hideObjectServer", {(_this select 0) hideObjectGlobal (_this select 1);}] call CBA_fnc_addEventHandler;

private _nextWeatherSet = [date, overcast, rain, [wind select 0, wind select 1, true], fogParams];
[{
    !(isNil "GRAD_USER_introOver")
},{
    ["grad_changeWeather", _this] call CBA_fnc_serverEvent;
}, _nextWeatherSet] call CBA_fnc_waitUntilAndExecute;

grad_user_bigScreenOn = false;
publicVariable "grad_user_bigScreenOn";

WEST setFriend [EAST, 1];
EAST setFriend [WEST, 1];

/*
Adding zones must be done by server. If you add them via any other machine, it will simply not work!

Zones work as follows:
They are always circular!
You need to specify their center,their threat level (ranging between 0 and 5), their radius and fall off area!

The fall off area will add to the radius, but the threadlevel will not be in full effect. As example:
You want a threat area spanning 500 meters in radius, but you only want the full effect of threatlevel 3.5 withing 100 meters of the center, this would look like this:

[_pos, 3.5, 100, 400] call diwako_cbrn_fnc_createZone;

This will create a threat level 3.5 (Orange) zone around position _pos with total radius of 500 meters and full effect is 100 meter radius around the center!
*/

