local TransmogCollector = {}
TransmogCollector.name = "transmog"

function TransmogCollector:Collect()
	local collection = {
		illusions = {},
		gear = {},
	}
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
	-- TODO: Gear
	-- Set filters
	-- Find list at WardrobeCollectionFrame.ItemsCollectionFrame.visualsList
end

CollectionExporter:RegisterDataCollector(TransmogCollector)
