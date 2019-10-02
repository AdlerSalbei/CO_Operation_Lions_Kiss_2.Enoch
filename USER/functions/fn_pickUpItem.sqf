params ["_item", "_hiddenItem"];

_item setVariable ["grad_user_notPickedUp", true];
_item setVariable ["grad_user_hiddenItem", _hiddenItem];

private _action = [
    "pickUpItem",
    "Pick Up",
    "",
    {
        ["grad_hideObjectServer", [_target, true]] call CBA_fnc_serverEvent;

        private _pickedUpItems = _player getVariable ["grad_user_pickedUpItems", []];
        _pickedUpItems pushBack (_target getVariable "grad_user_hiddenItem");
        _player setVariable ["grad_user_pickedUpItems", _pickedUpItems];

        private _intelFound = grad_user_intelFound;
        {
            if (_x select 0 isEqualTo _target) exitWith {
                _x set [4, (_x select 4) +1];
                _intelFound set [_forEachIndex, _x];
            };
        }forEach _intelFound;
    },
    {true},
    {},
    [],
    [0,0,0]
] call ace_interact_menu_fnc_createAction;

[_item, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;