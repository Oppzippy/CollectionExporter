local addon = CollectionExporter
local L = addon.L

local AceDB = LibStub("AceDB-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local options = {
	name = "CollectionExporter",
	type = "group",
	args = {
		general = {
			name = L.general,
			type = "group",
			args = {
				export = {
					order = 1,
					name = L.export,
					type = "execute",
					func = function()
						local json = addon:CollectJSON()
						addon:Copy(json)
					end,
				},
				collectors = {
					order = 2,
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
			name = dataCollector.displayName or L[dataCollector.name],
			type = "toggle",
		}
	end
	options.args.general.args.collectors.args = args
end
