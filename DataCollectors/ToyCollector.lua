local ToyCollector = {}
ToyCollector.name = "toys"

local toyBoxSettings
do
	local trueTable = setmetatable({}, {
		__index = function()
			return true
		end
	})
	toyBoxSettings = {
		expansion = trueTable,
		source = trueTable,
		collected = true,
		uncollected = false,
		unusable = false,
	}
end

local function GetToyBoxSettings()
	local settings = {
		expansion = {},
		source = {},
	}
	for i = 1, GetNumExpansions() do
		settings.expansion[i] = not C_ToyBox.IsExpansionTypeFilterChecked(i) -- returns the opposite of what it should?
	end
	for i = 1, C_PetJournal.GetNumPetSources() do -- Blizzard uses the pet journal to get num sources in Blizzard_ToyBox.lua
		settings.source[i] = not C_ToyBox.IsSourceTypeFilterChecked(i) -- returns the opposite of what it should?
	end
	settings.collected = C_ToyBox.GetCollectedShown()
	settings.uncollected = C_ToyBox.GetUncollectedShown()
	settings.unusable = C_ToyBox.GetUnusableShown()
	return settings
end

local function SetToyBoxSettings(settings)
	for i = 1, GetNumExpansions() do
		C_ToyBox.SetExpansionTypeFilter(i, settings.expansion[i])
	end
	for i = 1, C_PetJournal.GetNumPetSources() do -- Blizzard uses the pet journal to get num sources in Blizzard_ToyBox.lua
		C_ToyBox.SetSourceTypeFilter(i, settings.source[i])
	end
	C_ToyBox.SetCollectedShown(settings.collected)
	C_ToyBox.SetUncollectedShown(settings.uncollected)
	C_ToyBox.SetUnusableShown(settings.unusable)
end

function ToyCollector:Collect()
	local collection = {}
	local prevSettings = GetToyBoxSettings()
	SetToyBoxSettings(toyBoxSettings)
	for i = 1, C_ToyBox.GetNumFilteredToys() do
		local itemID = C_ToyBox.GetToyFromIndex(i)
		collection[#collection+1] = {
			id = itemID,
			name = GetItemInfo(itemID),
		}
	end
	SetToyBoxSettings(prevSettings)
	return collection
end

CollectionExporter:RegisterDataCollector(ToyCollector)
