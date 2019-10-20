CollectionExporter = {}
local addon = CollectionExporter

local dataCollectors = {}
function addon:RegisterDataCollector(collector)
	assert(type(collector.name) == "string", "DataCollectors must have a name.")
	assert(type(collector.Collect) == "function", "DataCollectors must have a Collect function.")
	dataCollectors[#dataCollectors+1] = collector
end

function addon:Collect()
	local collection = {}
	for _, collector in next, dataCollectors do
		collection[collector.name] = collector:Collect()
	end
	return collection
end
