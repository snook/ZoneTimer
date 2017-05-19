--------------------------------------------------------------------------
-- ZoneTimer.lua
--------------------------------------------------------------------------
--[[

  -- Author
  Ryan "Gryphon" Snook (rsnook@gmail.com)
	"Allied Tribal Forces" of "US - Mal'Ganis - Alliance".
	www.AlliedTribalForces.com

	-- Request
	Please do not re-release this AddOn as "Continued", "Resurrected", etc...
	if you have updates/fixes/additions for it, please contact me. If I am
	no longer	active in WoW I will gladly pass on the maintenance	to someone
	else, however until then please assume I am still active in WoW.

	-- AddOn Description
	Displays how long it takes to zone in seconds.

	-- Dependencies
	None

	-- Changes
	1.23	- Updated TOC for 2.4
	1.22	- Updated TOC for 2.1
	1.21	- Updated TOC for 2.0
	1.20	- Dropped .xml for CreateFrame()
	1.13	- Updated TOC for 1.12
	1.12	- Fixed syntax errors
	1.11	- Updated TOC for 1.11
	1.10	- Cleaning house, general maintenance and reorganization.
	1.00	- Initial Release

  -- SVN info
	$Id: ZoneTimer.lua 2 2008-05-19 16:50:35Z Gryphon-19211 $
	$Rev: 2 $
	$LastChangedBy: Gryphon-19211 $
	$Date: 2008-05-19 11:50:35 -0500 (Mon, 19 May 2008) $

]]--

local ZT = {
	Version = GetAddOnMetadata("ZoneTimer", "Version");
	Revision = tonumber(strsub("$Rev: 2 $", 7, strlen("$Rev: 2 $") - 2));
	Time = 0.01;
}

function ZoneTimer_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
	  local t = GetTime() - ZT.Time
	  local c = "00cc00"

	  if ( t > 10 ) then
	    c = "ff0000"
	  elseif ( t > 5 ) then
	    c = "ffff00"
	  end

	  if ( t > .01 ) then
	    DEFAULT_CHAT_FRAME:AddMessage(string.format("|cffffd100ZoneTimer:|r |cff"..c.."%.3f Seconds|r", t))
	  end
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		ZT.Time = GetTime()
		this:RegisterEvent("PLAYER_ENTERING_WORLD")
	end
end

--Event Driver
if (not ZoneTimerFrame) then
	CreateFrame("Frame", "ZoneTimerFrame")
end
ZoneTimerFrame:Hide()
--Frame Scripts
ZoneTimerFrame:SetScript("OnEvent", ZoneTimer_OnEvent)
ZoneTimerFrame:RegisterEvent("PLAYER_LEAVING_WORLD")