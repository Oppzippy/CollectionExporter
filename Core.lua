CollectionExporter = LibStub("AceAddon-3.0"):NewAddon("CollectionExporter", "AceConsole-3.0")
local addon = CollectionExporter
addon.L = LibStub("AceLocale-3.0"):GetLocale("CollectionExporter")

local json = LibStub("json.lua")
local LibCopyPaste = LibStub("LibCopyPaste-1.0")

addon.dataCollectors = {}
function addon:RegisterDataCollector(collector)
	assert(type(collector.name) == "string", "DataCollectors must have a name.")
	assert(type(collector.Collect) == "function", "DataCollectors must have a Collect function.")
	self.dataCollectors[#self.dataCollectors+1] = collector
	self:UpdateOptions()
end

function addon:Collect()
	local collection = {}
	local blacklist = self.db.profile.blacklist
	for _, collector in next, self.dataCollectors do
		if not blacklist[collector.name] then
			collection[collector.name] = collector:Collect()
		end
	end
	return collection
end

function addon:CollectJSON()
	return json.encode(self:Collect())
end

function addon:Copy(text)
	LibCopyPaste:Copy("CollectionExporter", text)
end
