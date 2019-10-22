local addon = CollectionExporter
local L = addon.L

local AceDB = LibStub("AceDB-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigCmd = LibStub("AceConfigCmd-3.0")

local options = {
	name = "CollectionExporter",
	type = "group",
	set = function(info, value)
		addon.db.profile[info[#info]] = value
	end,
	get = function(info)
		return addon.db.profile[info[#info]]
	end,
	args = {
		general = {
			name = L.general,
			type = "group",
			args = {
				exportToClipboard = {
					order = 1,
					name = L.exportToClipboard,
					type = "execute",
					func = function()
						local collection = addon:Collect()
						if addon.db.profile.compression == "none" then
							-- Frequently causes game to crash without compression
							collection.transmog = nil
						end
						local json = addon:ToJSON(collection)
						addon:Copy(json)
					end,
				},
				exportToSavedVariables = {
					order = 2,
					name = L.exportToSavedVariables,
					type = "execute",
					func = function()
						local collection = addon:Collect()
						local json = addon:ToJSON(collection)
						CollectionExporterData = {
							compression = addon.db.profile.compression,
							json = json,
						}
					end,
				},
				compression = {
					order = 3,
					type = "select",
					name = L.compression,
					values = {
						none = L.none,
						deflate = L.deflate,
						zlib = L.zlib,
					},
				},
				collectors = {
					order = 4,
					name = L.enabledCollectors,
					type = "group",
					inline = true,
					set = function(info, value)
						addon.db.profile.blacklist[info[#info]] = not value
					end,
					get = function(info)
						return not addon.db.profile.blacklist[info[#info]]
					end,
					args = {},
				},
			},
		},
	},
}

local defaultDB = {
	profile = {
		compression = "none",
		blacklist = {},
	},
}

function addon:OnInitialize()
	self.db = AceDB:New("CollectionExporterDB", defaultDB, true)
	AceConfig:RegisterOptionsTable("CollectionExporter", options)
	options.args.profiles = AceDBOptions:GetOptionsTable(self.db)
	AceConfigDialog:AddToBlizOptions("CollectionExporter", "CollectionExporter", nil, "general")
	AceConfigDialog:AddToBlizOptions("CollectionExporter", "Profiles", "CollectionExporter", "profiles")
end

function addon:UpdateOptions()
	local args = {}
	for i, dataCollector in ipairs(self.dataCollectors) do
		args[dataCollector.name] = {
			order = i,
			width = "full",
			name = dataCollector.displayName or L[dataCollector.name],
			type = "toggle",
		}
	end
	options.args.general.args.collectors.args = args
end
