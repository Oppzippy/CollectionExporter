local MountCollector = {}
MountCollector.name = "mounts"

function MountCollector:Collect()
	local collection = {}
	local mounts = C_MountJournal.GetMountIDs()
	for _, mount in next, mounts do
		local name, spellId, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mount)
		if isCollected then
			collection[#collection+1] = {
				name = name,
				spellId = spellId,
			}
		end
	end
	return collection
end

CollectionExporter:RegisterDataCollector(MountCollector)
