local L = LibStub("AceLocale-3.0"):NewLocale("CollectionExporter", "enUS", true)

-- Options
L.general = GENERAL
L.exportToClipboard = "Export to Clipboard"
L.exportToSavedVariables = "Export to SavedVariables"
L.enabledCollectors = "Enabled Collectors"
L.compression = "Compression"
L.none = NONE
L.deflate = "Deflate"
L.zlib = "Zlib"

-- Data Collectors
L.inventory = INVENTORY_TOOLTIP
L.mounts = MOUNTS
L.characterInfo = "Character Info (name, etc.)"
L.toys = "Toys"
L.transmog = "Transmog (requires compression for copy)"
