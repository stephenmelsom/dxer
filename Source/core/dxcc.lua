-- DXCC entity table with prefix, rarity weight, and point values.
-- Rarity: "common" | "uncommon" | "rare" | "dxpedition"
-- Weight: relative spawn probability (higher = more frequent)

local entities = {
    -- ── Common ───────────────────────────────────────────────────────────────
    { entity="United States",  prefix="W",   rarity="common",      weight=20, pts=10  },
    { entity="United States",  prefix="K",   rarity="common",      weight=18, pts=10  },
    { entity="United States",  prefix="N",   rarity="common",      weight=15, pts=10  },
    { entity="Canada",         prefix="VE",  rarity="common",      weight=12, pts=15  },
    { entity="Germany",        prefix="DL",  rarity="common",      weight=10, pts=15  },
    { entity="Japan",          prefix="JA",  rarity="common",      weight=10, pts=20  },
    { entity="England",        prefix="G",   rarity="common",      weight=9,  pts=20  },
    { entity="Australia",      prefix="VK",  rarity="common",      weight=8,  pts=25  },
    { entity="France",         prefix="F",   rarity="common",      weight=8,  pts=20  },
    { entity="Italy",          prefix="I",   rarity="common",      weight=8,  pts=20  },
    { entity="Spain",          prefix="EA",  rarity="common",      weight=7,  pts=20  },
    { entity="Brazil",         prefix="PY",  rarity="common",      weight=7,  pts=25  },
    { entity="Netherlands",    prefix="PA",  rarity="common",      weight=6,  pts=20  },
    { entity="Sweden",         prefix="SM",  rarity="common",      weight=6,  pts=20  },
    { entity="Russia",         prefix="UA",  rarity="common",      weight=6,  pts=20  },
    { entity="Argentina",      prefix="LU",  rarity="common",      weight=5,  pts=25  },
    { entity="Poland",         prefix="SP",  rarity="common",      weight=5,  pts=20  },
    { entity="Mexico",         prefix="XE",  rarity="common",      weight=5,  pts=20  },

    -- ── Uncommon ─────────────────────────────────────────────────────────────
    { entity="South Africa",   prefix="ZS",  rarity="uncommon",    weight=4,  pts=35  },
    { entity="Indonesia",      prefix="YB",  rarity="uncommon",    weight=3,  pts=35  },
    { entity="Cuba",           prefix="CO",  rarity="uncommon",    weight=3,  pts=40  },
    { entity="Portugal",       prefix="CT",  rarity="uncommon",    weight=3,  pts=35  },
    { entity="New Zealand",    prefix="ZL",  rarity="uncommon",    weight=3,  pts=35  },
    { entity="India",          prefix="VU",  rarity="uncommon",    weight=3,  pts=35  },
    { entity="Ukraine",        prefix="UR",  rarity="uncommon",    weight=3,  pts=30  },
    { entity="Thailand",       prefix="HS",  rarity="uncommon",    weight=2,  pts=40  },
    { entity="Kenya",          prefix="5Z",  rarity="uncommon",    weight=2,  pts=40  },
    { entity="Chile",          prefix="CE",  rarity="uncommon",    weight=2,  pts=40  },
    { entity="Venezuela",      prefix="YV",  rarity="uncommon",    weight=2,  pts=40  },
    { entity="Philippines",    prefix="DU",  rarity="uncommon",    weight=2,  pts=40  },
    { entity="Nigeria",        prefix="5N",  rarity="uncommon",    weight=2,  pts=45  },
    { entity="Morocco",        prefix="CN",  rarity="uncommon",    weight=2,  pts=40  },

    -- ── Rare DX ──────────────────────────────────────────────────────────────
    { entity="Hawaii",         prefix="KH6", rarity="rare",        weight=2,  pts=75  },
    { entity="Alaska",         prefix="KL7", rarity="rare",        weight=2,  pts=75  },
    { entity="Canary Islands", prefix="EA8", rarity="rare",        weight=2,  pts=80  },
    { entity="Azores",         prefix="CU",  rarity="rare",        weight=1,  pts=90  },
    { entity="Iceland",        prefix="TF",  rarity="rare",        weight=1,  pts=90  },
    { entity="Faroe Islands",  prefix="OY",  rarity="rare",        weight=1,  pts=100 },
    { entity="Madeira",        prefix="CT3", rarity="rare",        weight=1,  pts=90  },
    { entity="Reunion",        prefix="FR",  rarity="rare",        weight=1,  pts=100 },
    { entity="Ascension Is.",  prefix="ZD8", rarity="rare",        weight=1,  pts=120 },
    { entity="Heard Is.",      prefix="VK0", rarity="rare",        weight=1,  pts=150 },
    { entity="Svalbard",       prefix="JW",  rarity="rare",        weight=1,  pts=130 },
    { entity="South Georgia",  prefix="VP8", rarity="rare",        weight=1,  pts=150 },
    { entity="Clipperton Is.", prefix="FO/c",rarity="rare",        weight=1,  pts=160 },
    { entity="Rodrigues",      prefix="3B9", rarity="rare",        weight=1,  pts=140 },

    -- ── DXpedition ───────────────────────────────────────────────────────────
    { entity="Bouvet Is.",     prefix="3Y",  rarity="dxpedition",  weight=1,  pts=500 },
    { entity="Peter I Is.",    prefix="3Y/p",rarity="dxpedition",  weight=1,  pts=750 },
    { entity="Navassa Is.",    prefix="KP1", rarity="dxpedition",  weight=1,  pts=600 },
    { entity="North Korea",    prefix="P5",  rarity="dxpedition",  weight=1,  pts=800 },
    { entity="Marion Is.",     prefix="ZS8", rarity="dxpedition",  weight=1,  pts=550 },
    { entity="Kingman Reef",   prefix="KH5K",rarity="dxpedition",  weight=1,  pts=700 },
    { entity="Desecheo Is.",   prefix="KP5", rarity="dxpedition",  weight=1,  pts=650 },
    { entity="Crozet Is.",     prefix="FT5W",rarity="dxpedition",  weight=1,  pts=600 },
}

-- Build weighted pool for random selection
local _pool = {}
for _, e in ipairs(entities) do
    for _ = 1, e.weight do
        _pool[#_pool + 1] = e
    end
end

-- A "local/common" pool for VHF bands (e.g. 2m), where worldwide DX is
-- physically implausible. Only common entities, weighted as usual.
local _localPool = {}
for _, e in ipairs(entities) do
    if e.rarity == "common" then
        for _ = 1, e.weight do
            _localPool[#_localPool + 1] = e
        end
    end
end

DXCC = {}

-- Bug #21 (light fix): optional bandId biases selection. On 2m (VHF), draw
-- from the local/common pool so DXpeditions/JA/etc don't appear. Any other
-- band (or no arg) uses the full weighted pool — signature stays compatible.
function DXCC.random(bandId)
    if bandId == "2m" and #_localPool > 0 then
        return _localPool[math.random(#_localPool)]
    end
    return _pool[math.random(#_pool)]
end

function DXCC.randomOfRarity(rarity)
    local pool = {}
    for _, e in ipairs(entities) do
        if e.rarity == rarity then pool[#pool + 1] = e end
    end
    if #pool == 0 then return DXCC.random() end
    return pool[math.random(#pool)]
end

function DXCC.all() return entities end

return DXCC
