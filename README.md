# CollectionExporter
Slash command: /collectionexporter or /cexp

Example data:

```json
{
    "characterInfo": {
        "level": 120,
        "name": "Charactername",
        "realm": "Realmname"
    },
    "inventory": [
        {
            "itemID": 168313,
            "count": 65
        }
    ],
    "mounts": [
        {
            "name": "Brown Horse",
            "spellID": 458
        }
    ],
    "toys": [
        {
            "itemID": 127670,
            "name": "Accursed Tome of the Sargerei"
        }
    ],
    "transmog": {
        "illusions": [
            {
                "sourceID": 1898,
                "name": "Lifestealing",
                "visualID": 107,
            }
        ],
        "gear": {
            "waist": [
                {
                    "visualID": 527,
                    "collectedSources": [
                        {
                            "sourceType": 2,
                            "sourceID": 26165,
                            "itemID": 53409,
                            "itemModID": 0
                        }
                    ]
                }
            ]
        }
    }
}
```

Full list of transmog gear types:
- head
- shoulder
- back
- chest
- shirt
- tabard
- wrist
- hands
- waist
- legs
- feet
- wands
- oneHandedAxes
- oneHandedSwords
- oneHandedMaces
- daggers
- fistWeapons
- shields
- heldInOffHand
- twoHandedAxes
- twoHandedSwords
- twoHandedMaces
- staves
- polearms
- bows
- guns
- crossbows
- warglaives
- legionArtifacts
