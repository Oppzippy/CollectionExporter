# CollectionExporter
Slash command: /collectionexporter or /cexp

Example data:

```js
{
    "characterInfo": {
        "level": 120,
        "name": "Charactername",
        "realm": "Realmname"
    },
    "inventory": [
        "id": 12345, // item id
        "count": 1 // total number in bags
    ],
    "mounts": [
        {
            "name": "Brown Horse",
            "spellID": 458
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
                "visualID": 527,
                "collectedSources": [
                    {
                        "sourceType": 2,
                        "sourceID": 26165,
                        "itemID": 53409,
                        "itemModID": 0
                    }
                ]
            ]
        }
    }
}
```
