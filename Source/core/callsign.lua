-- Callsign generator: builds realistic-looking callsigns from a DXCC prefix.

Callsign = {}

local LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local function randLetter()
    local i = math.random(#LETTERS)
    return LETTERS:sub(i, i)
end

-- Generate a callsign from a prefix string.
-- Format: prefix + digit + 2-3 letters  e.g. "W3" + "XYZ" → "W3XYZ"
function Callsign.generate(prefix)
    -- Determine if the prefix already contains a digit
    local hasDigit = prefix:match("%d")

    local suffix
    if not hasDigit then
        -- Add a district digit (0-9) then 2-3 letters
        local digit = tostring(math.random(0, 9))
        local len   = math.random(2, 3)
        suffix = digit
        for _ = 1, len do
            suffix = suffix .. randLetter()
        end
    else
        -- Prefix already has digit; just append 2-3 letters
        local len = math.random(2, 3)
        suffix = ""
        for _ = 1, len do
            suffix = suffix .. randLetter()
        end
    end

    return prefix .. suffix
end

return Callsign
