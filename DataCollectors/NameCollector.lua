local NameCollector = {}
NameCollector.name = "characterInfo"

function NameCollector:Collect()
	return {
		name = UnitName("player"),
		realm = GetRealmName(),
		level = UnitLevel("player"),
	}
end

CollectionExporter:RegisterDataCollector(NameCollector)
