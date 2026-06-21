-- QRM (interference) system.
-- Spawns noise blobs on the panadapter at random frequencies.
-- Each blob has a center frequency, width, strength, and lifetime.
-- QRM broadens the effective signal footprint, making tuning harder.

QRM = {}

local _blobs    = {}
local _timer    = 0
local _enabled  = true

local function newBlob(hzLow, hzHigh)
    local margin = 20000
    local freq   = hzLow + margin + math.random(hzHigh - hzLow - margin * 2)
    return {
        freq      = freq,
        widthHz   = 2000 + math.random(8000),    -- QRM bandwidth
        strength  = 0.2 + math.random() * 0.5,
        lifetime  = 10 + math.random(40),
        age       = 0,
    }
end

function QRM.init(hzLow, hzHigh)
    _blobs  = {}
    _timer  = 5 + math.random(15)
    _hzLow  = hzLow
    _hzHigh = hzHigh
end

function QRM.setEnabled(v) _enabled = v end

function QRM.update(dt)
    if not _enabled then return end

    -- Age and remove expired blobs
    for i = #_blobs, 1, -1 do
        _blobs[i].age = _blobs[i].age + dt
        if _blobs[i].age >= _blobs[i].lifetime then
            table.remove(_blobs, i)
        end
    end

    -- Spawn new blob
    _timer = _timer - dt
    if _timer <= 0 and #_blobs < 3 then
        if math.random() < 0.4 then  -- 40% chance to actually spawn on timer tick
            _blobs[#_blobs + 1] = newBlob(_hzLow or 7000000, _hzHigh or 7300000)
        end
        _timer = 8 + math.random(20)
    end
end

function QRM.getBlobs() return _blobs end

-- Returns strength of QRM at a given frequency (0 = clear, >0 = interference)
function QRM.strengthAt(freq)
    local total = 0
    for _, b in ipairs(_blobs) do
        local dist = math.abs(freq - b.freq)
        if dist < b.widthHz then
            local t = 1 - (dist / b.widthHz)
            total = total + b.strength * t
        end
    end
    return math.min(1.0, total)
end

return QRM
