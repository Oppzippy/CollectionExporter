CollectionExporter = LibStub("AceAddon-3.0"):NewAddon("CollectionExporter", "AceConsole-3.0")
local addon = CollectionExporter
addon.L = LibStub("AceLocale-3.0"):GetLocale("CollectionExporter")

local json = LibStub("json.lua")
local LibCopyPaste = LibStub("LibCopyPaste-1.0")
local LibDeflate = LibStub("LibDeflate")

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

function addon:ToJSON(collection)
	local data = json.encode(collection)
	local compression = addon.db.profile.compression
	if compression == "deflate" then
		data = LibDeflate:CompressDeflate(data)
		data = LibDeflate:EncodeForPrint(data)
	elseif compression == "zlib" then
		data = LibDeflate:CompressZlib(data, {level = 9})
		data = LibDeflate:EncodeForPrint(data)
	end
	return data
end

function addon:Copy(text)
	LibCopyPaste:Copy("CollectionExporter", text)
end

function addon:SlashCommand(msg)
	InterfaceOptionsFrame_OpenToCategory("CollectionExporter")
	InterfaceOptionsFrame_OpenToCategory("CollectionExporter")
end

addon:RegisterChatCommand("collectionexporter", "SlashCommand")
addon:RegisterChatCommand("cexp", "SlashCommand")
