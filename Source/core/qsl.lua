-- QSL card system.
-- QSL cards are awarded for notable contacts; tracked in save data.
-- Rarity → probability of receiving a QSL card.

QSL = {}

local QSL_PROB = {
    common      = 0.3,
    uncommon    = 0.5,
    rare        = 0.8,
    dxpedition  = 1.0,
}

-- Roll whether a contact earns a QSL card; returns true/false
function QSL.roll(rarity)
    local prob = QSL_PROB[rarity] or 0.3
    return math.random() < prob
end

-- Add a QSL card to save data
-- card = { call, entity, band, mode, date, rarity }
function QSL.addCard(data, card)
    data.story.qslCards = data.story.qslCards or {}
    table.insert(data.story.qslCards, card)
end

function QSL.getCards(data)
    return data.story.qslCards or {}
end

function QSL.count(data)
    return #QSL.getCards(data)
end

return QSL
