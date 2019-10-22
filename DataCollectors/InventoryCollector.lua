local InventoryCollector = {}
InventoryCollector.name = "inventory"

local function IterateBags()
	local bag = 0
	local slots = GetContainerNumSlots(bag)
	local slot = 1
	return function()
		while bag < 5 do
			local item = Item:CreateFromBagAndSlot(bag, slot)
			slot = slot + 1
			if slot > slots then
				bag = bag + 1
				slot = 1
				slots = GetContainerNumSlots(bag)
			end
			if not item:IsItemEmpty() then
				return item
			end
		end
	end
end

function InventoryCollector:Collect()
	local collection = {}
	local collectedItems = {}
	for item in IterateBags() do
		local id = item:GetItemID()
		if not collectedItems[id] then -- Avoid duplicates since we're counting all occurrences at once
			collectedItems[id] = true
			collection[#collection+1] = {
				id = id,
				count = GetItemCount(id, false, false), -- exclude bank and charges
			}
		end
	end
	return collection
end

CollectionExporter:RegisterDataCollector(InventoryCollector)
