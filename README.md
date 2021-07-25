# Client Side Marker Manager for DayZ Epoch and DayZ Mod.
 
## Compatible with DayZ Epoch 1.0.7 and DayZ Mod 1.9.0

This system is to be used to manage markers generated server-side by mods such as WAI, DZMS, and events.
It is JIP compatible and supports localization.
It will greatly reduce the network traffic associated with map markers that traditionally refresh on a loop.

### Installation Instructions

1. ***[Download](https://github.com/worldwidesorrow/Client-Side-Marker-Manager/archive/main.zip)*** or click the green button on the right side of the Github page.

	> Recommended PBO tool for all "pack", "repack", or "unpack" steps: ***[PBO Manager](http://www.armaholic.com/page.php?id=16369)***

2. Extract the downloaded folder to your desktop and open it
3. Go to your server pbo and unpack it.
4. Navigate to directory ***dayz_server\compile*** and edit file <code>server_playerLogin.sqf</code>.

	Add the following block of code at the very bottom of the file.
	
	```sqf
	if ((count DZE_ServerMarkerArray) > 0) then {
		PVDZ_ServerMarkerSend = ["JIP",DZE_ServerMarkerArray];
		(owner _playerObj) publicVariableClient "PVDZ_ServerMarkerSend";
	};
	```
	
5. Save the file and repack your server PBO.

### Mission Folder

1. Go to your mission pbo and unpack it.
2. Edit file <code>init.sqf</code>

	Find this line near the top of the file:
	
	```sqf
	if (isServer) then {
	```
	
	Add the following lines ***below*** it:
	
	```sqf
	DZE_ServerMarkerArray = [];
	DZE_MissionPositions = [];
	```

	Find this line:
	
	```sqf
	execFSM "\z\addons\dayz_code\system\player_monitor.fsm";
	```
	
	Add the following line ***above*** it:
	
	```sqf
	call compile preprocessFileLineNumbers "scripts\marker_manager.sqf";
	```
	
3. Save and close the file.

4. Copy the scripts folder over to your mission file. It should contain the file ***marker_manager.sqf***.

5. Repack your mission PBO.

# Battleye

Open scripts.txt

 Add this to the end of line 26 or the one that starts with <code>5 createMarker</code>
 
 ```sqf
 !="th {\ndeleteMarkerLocal (_args select 1); \nlocal _marker = createMarkerLocal [(_args select 1),(_args select 0)];\nif ((_args sele"
 ```
 
 Add this to the end of line 32 or the one that starts with <code>5 deleteMarker</code>
 
 ```sqf
 !="arkerText);\n};\n\nif (_option == \"removeSingle\") exitWith {\ndeleteMarkerLocal _args;\n};\n\nif (_option == \"createSingle\") exitWith {"
 ```

 Add this to the end of line 68 or the one that starts with <code>5 setMarkerAlpha</code>
 
 ```sqf
 !="zeMarkerText);};\nif ((_args select 8) > 0) then {_marker setMarkerAlphaLocal (_args select 8);};\n};\n\nif (_option == \"start\") exi"
 ```
 
 Add this to the end of line 69 or the one that starts with <code>5 setMarkerBrush</code>
 
 ```sqf
 !="s select 4);};\nif ((_args select 5) != \"\") then {_marker setMarkerBrushLocal (_args select 5);};\nif ( count (_args select 6) > 0"
 ```
 
 Add this to the end of line 70 or the one that starts with <code>5 setMarkerColor</code>
 
 ```sqf
 !="gs select 0)];\nif ((_args select 2) != \"\") then {_marker setMarkerColorLocal (_args select 2);};\nif ((_args select 3) != \"\") the"
 ```
 
 Add this to the end of line 73 or the one that starts with <code>5 setMarkerShape</code>
 
 ```sqf
 !="s select 3);};\nif ((_args select 4) != \"\") then {_marker setMarkerShapeLocal (_args select 4);};\nif ((_args select 5) != \"\") the"
 ```
 
 Add this to the end of line 74 or the one that starts with <code>5 setMarkerSize</code>
 
 ```sqf
 !="ect 5);};\nif ( count (_args select 6) > 0) then {_marker setMarkerSizeLocal (_args select 6);};\nif ( count (_args select 7) > 0)"
 ```
 
 Add this to the end of line 75 or the one that starts with <code>5 setMarkerText</code>
 
 ```sqf
 !="if (_option == \"textSingle\") exitWith {\n(_args select 0) setMarkerTextLocal ((_args select 1) call fnc_localizeMarkerText);\n};\n\n"
 ```
 
  Add this to the end of line 76 or the one that starts with <code>5 setMarkerType</code>
 
 ```sqf
 !="s select 2);};\nif ((_args select 3) != \"\") then {_marker setMarkerTypeLocal (_args select 3);};\nif ((_args select 4) != \"\") then"
 ```
 
 
 Developed by JasonTM for the DayZ Epoch community.
