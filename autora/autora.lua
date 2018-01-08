--[[
* Ashita - Copyright (c) 2014 - 2017 atom0s [atom0s@live.com]
*
* This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
* To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to
* Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*
* By using Ashita, you agree to the above license and its terms.
*
*      Attribution - You must give appropriate credit, provide a link to the license and indicate if changes were
*                    made. You must do so in any reasonable manner, but not in any way that suggests the licensor
*                    endorses you or your use.
*
*   Non-Commercial - You may not use the material (Ashita) for commercial purposes.
*
*   No-Derivatives - If you remix, transform, or build upon the material (Ashita), you may not distribute the
*                    modified material. You are, however, allowed to submit the modified works back to the original
*                    Ashita project in attempt to have it added to the original project.
*
* You may not apply legal terms or technological measures that legally restrict others
* from doing anything the license permits.
*
* No warranties are given.
]]--

_addon.author   = 'Shinzaru';
_addon.name     = 'AutoRA';
_addon.version  = '1.0.0';

require 'common'

local haltontp = true;
local tphaltval = 900;
local currentTP = 0;

ashita.register_event('incoming_packet', function(id, size, data)
    if (id == 0x028) then
		local cat = ashita.bits.unpack_be(data, 0x0A, 2, 4);
		if (cat == 2) then
			if (currentTP < tphaltval) then
				ashita.timer.once(1.15, Fire);
			end;
		end;
	end;
	
    return false;
end);

function Fire()
	AshitaCore:GetChatManager():QueueCommand('/ra', 1);
end;
	
ashita.register_event('command', function(cmd, nType)
	
    return false;
end);

ashita.register_event('render', function()
	currentTP = AshitaCore:GetDataManager():GetParty():GetMemberCurrentTP(0);
end);