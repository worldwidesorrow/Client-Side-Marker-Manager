/*
	DayZ Epoch Client-Side Marker Manager
	Author: JasonTM
	* Manages map markers locally on each client
	* Markers are updated on demand instead of on a server side loop
	* Localizes marker text
	* JIP: request and create all server side markers
	* Mission Start: create the markers for the mission
	* Mission Update: update the single marker with text. ex. A.I. counter.
	* Mission End: remove all markers
	
	[
		position, - 2D or 3D array
		createMarker, - String
		setMarkerColor, - String
		setMarkerType, - String
		setMarkerShape, - String
		setMarkerBrush, - String
		setMarkerSize, - 2D array
		setMarkerText, - Array of Strings and Scalar - can be localized.
		setMarkerAlpha - Scalar
	]
*/

fnc_localizeMarkerText = {
	local _text = _this;
		{
			if (typeName _x == "STRING") then { 
				if (["STR_",_x] call fnc_inString) then {
					_text set [_forEachIndex, localize _x];
				};
			};
		} forEach _text;
		_text = format _text;
	_text
};

fnc_markerManager = {
	local _option = _this select 0;
	local _args = _this select 1; // Always an array except for remove single marker option.
	
	if (_option == "textSingle") exitWith {
		(_args select 0) setMarkerTextLocal ((_args select 1) call fnc_localizeMarkerText);
	};
	
	if (_option == "removeSingle") exitWith {
		deleteMarkerLocal _args;
	};
	
	if (_option == "createSingle") exitWith {
		deleteMarkerLocal (_args select 1); // delete marker if it exits.
		local _marker = createMarkerLocal [(_args select 1),(_args select 0)];
		if ((_args select 2) != "") then {_marker setMarkerColorLocal (_args select 2);};
		if ((_args select 3) != "") then {_marker setMarkerTypeLocal (_args select 3);};
		if ((_args select 4) != "") then {_marker setMarkerShapeLocal (_args select 4);};
		if ((_args select 5) != "") then {_marker setMarkerBrushLocal (_args select 5);};
		if ( count (_args select 6) > 0) then {_marker setMarkerSizeLocal (_args select 6);};
		if ( count (_args select 7) > 0) then {_marker setMarkerTextLocal ((_args select 7) call fnc_localizeMarkerText);};
		if ((_args select 8) > 0) then {_marker setMarkerAlphaLocal (_args select 8);};
	};
	
	if (_option == "start") exitWith {
		{
			if (typeName _x == "ARRAY") then {
				local _marker = createMarkerLocal [(_x select 1),(_x select 0)];
				if ((_x select 2) != "") then {_marker setMarkerColorLocal (_x select 2);};
				if ((_x select 3) != "") then {_marker setMarkerTypeLocal (_x select 3);};
				if ((_x select 4) != "") then {_marker setMarkerShapeLocal (_x select 4);};
				if ((_x select 5) != "") then {_marker setMarkerBrushLocal (_x select 5);};
				if (count (_x select 6) > 0) then {_marker setMarkerSizeLocal (_x select 6);};
				if ( count (_x select 7) > 0) then {_marker setMarkerTextLocal ((_x select 7) call fnc_localizeMarkerText);};
				if ((_x select 8) > 0) then {_marker setMarkerAlphaLocal (_x select 8);};
			};
		} count _args;
	};
	
	if (_option == "end") exitWith {
		{
			deleteMarkerLocal _x;
		} count _args;
	};
	
	if (_option == "JIP") exitWith {
		for "_i" from 0 to ((count _args) - 1) do {
			local _current = _args select _i;
			if (typeName _current == "ARRAY") then {
				{
					if (typeName _x == "ARRAY") then {
						local _marker = createMarkerLocal [(_x select 1),(_x select 0)];
						if ((_x select 2) != "") then {_marker setMarkerColorLocal (_x select 2);};
						if ((_x select 3) != "") then {_marker setMarkerTypeLocal (_x select 3);};
						if ((_x select 4) != "") then {_marker setMarkerShapeLocal (_x select 4);};
						if ((_x select 5) != "") then {_marker setMarkerBrushLocal (_x select 5);};
						if (count (_x select 6) > 0) then {_marker setMarkerSizeLocal (_x select 6);};
						if ( count (_x select 7) > 0) then {_marker setMarkerTextLocal ((_x select 7) call fnc_localizeMarkerText);};
						if ((_x select 8) > 0) then {_marker setMarkerAlphaLocal (_x select 8);};
					};
				} count _current;
			};
		};
	};
};

"PVDZ_ServerMarkerSend" addPublicVariableEventHandler {(_this select 1) call fnc_markerManager;};