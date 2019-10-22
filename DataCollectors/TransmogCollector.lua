local TransmogCollector = {}
TransmogCollector.name = "transmog"

local categories = {
	[1] = "head",
	[2] = "shoulder",
	[3] = "back",
	[4] = "chest",
	[5] = "shirt",
	[6] = "tabard",
	[7] = "wrist",
	[8] = "hands",
	[9] = "waist",
	[10] = "legs",
	[11] = "feet",
	[12] = "wands",
	[13] = "oneHandedAxes",
	[14] = "oneHandedSwords",
	[15] = "oneHandedMaces",
	[16] = "daggers",
	[17] = "fistWeapons",
	[18] = "shields",
	[19] = "heldInOffHand",
	[20] = "twoHandedAxes",
	[21] = "twoHandedSwords",
	[22] = "twoHandedMaces",
	[23] = "staves",
	[24] = "polearms",
	[25] = "bows",
	[26] = "guns",
	[27] = "crossbows",
	[28] = "warglaives",
	[29] = "legionArtifacts",
}

local function Filter(t, func)
	local ret = {}
	for _, value in ipairs(t) do
		if func(value) then
			ret[#ret+1] = value
		end
	end
	return ret
end

do
	local function isCollected(transmog)
		return transmog.isCollected
	end

	function TransmogCollector:Collect()
		local collection = {
			illusions = {},
			gear = {},
		}
		----------------------------------------------------------------------------
		-- Illusions
		--
		local illusions = collection.illusions
		for _, illusion in ipairs(C_TransmogCollection.GetIllusions()) do
			if illusion.isCollected then
				local _, name = C_TransmogCollection.GetIllusionSourceInfo(illusion.sourceID)
				illusions[#illusions+1] = {
					visualID = illusion.visualID,
					sourceID = illusion.sourceID,
					name = name,
				}
			end
		end
		----------------------------------------------------------------------------
		-- Gear
		--
		for categoryID, categoryName in next, categories do
			local transmog = {}
			collection.gear[categoryName] = transmog
			local visuals = C_TransmogCollection.GetCategoryAppearances(categoryID)
			for _, visual in ipairs(visuals) do
				if visual.isCollected then
					local sources = C_TransmogCollection.GetAppearanceSources(visual.visualID)
					Filter(sources, isCollected)
					for _, source in next, sources do -- remove useless fields
						source.categoryID = nil
						source.invType = nil
						source.isCollected = nil
						source.visualID = nil
						source.name = nil -- only sometimes present so remove for consistency
						source.quality = nil
					end
					transmog[#transmog+1] = {
						visualID = visual.visualID,
						collectedSources = sources,
					}
				end
			end
		end
		return collection
	end
end

CollectionExporter:RegisterDataCollector(TransmogCollector)
