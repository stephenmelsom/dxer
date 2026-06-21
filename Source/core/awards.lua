-- Award / achievement detection.
-- Each award has an id, name, description, and a check function.
-- Awards are stored in save.story.awards = { id → true }.

Awards = {}

local AWARDS = {
    {
        id   = "first_qso",
        name = "First QSO",
        desc = "Log your first contact.",
        check = function(data)
            return #data.story.logbook >= 1
        end,
    },
    {
        id   = "dx_hunter",
        name = "DX Hunter",
        desc = "Work 10 DXCC entities.",
        check = function(data)
            local count = 0
            for _ in pairs(data.story.dxccWorked or {}) do count = count + 1 end
            return count >= 10
        end,
    },
    {
        id   = "dxcc_50",
        name = "Half Century",
        desc = "Work 50 DXCC entities.",
        check = function(data)
            local count = 0
            for _ in pairs(data.story.dxccWorked or {}) do count = count + 1 end
            return count >= 50
        end,
    },
    {
        id   = "dxcc_100",
        name = "Century Club",
        desc = "Work 100 DXCC entities.",
        check = function(data)
            local count = 0
            for _ in pairs(data.story.dxccWorked or {}) do count = count + 1 end
            return count >= 100
        end,
    },
    {
        id   = "dxcc_200",
        name = "DXCC",
        desc = "Work 200+ DXCC entities!",
        check = function(data)
            local count = 0
            for _ in pairs(data.story.dxccWorked or {}) do count = count + 1 end
            return count >= 200
        end,
    },
    {
        id   = "pts_1000",
        name = "1000 Points",
        desc = "Earn 1,000 total points.",
        check = function(data)
            return (data.story.totalPoints or 0) >= 1000
        end,
    },
    {
        id   = "pts_10000",
        name = "10K Club",
        desc = "Earn 10,000 total points.",
        check = function(data)
            return (data.story.totalPoints or 0) >= 10000
        end,
    },
    {
        id   = "day_7",
        name = "Week One",
        desc = "Survive 7 days on the air.",
        check = function(data)
            return (data.story.day or 1) >= 7
        end,
    },
    {
        id   = "day_30",
        name = "Marathon Operator",
        desc = "30 days of operation.",
        check = function(data)
            return (data.story.day or 1) >= 30
        end,
    },
}

-- Returns list of newly earned award ids (not previously in data.story.awards)
function Awards.check(data)
    data.story.awards = data.story.awards or {}
    local newAwards = {}
    for _, award in ipairs(AWARDS) do
        if not data.story.awards[award.id] and award.check(data) then
            data.story.awards[award.id] = true
            newAwards[#newAwards + 1] = award
        end
    end
    return newAwards
end

function Awards.all()
    return AWARDS
end

function Awards.get(id)
    for _, a in ipairs(AWARDS) do
        if a.id == id then return a end
    end
    return nil
end

return Awards
