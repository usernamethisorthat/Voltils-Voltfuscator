if not VLT_OBFUSCATED then
    print("Running the source preview")
end

--!vlt:vm
local function makeCounter(step)
    local total = 0
    return function()
        total = total + step
        return total
    end
end

--!vlt:cff
local function describe(value)
    if value < 0 then
        return "below zero"
    elseif value == 0 then
        return "at zero"
    end
    return "above zero"
end

local counter = makeCounter(4)
assert(counter() == 4)
assert(counter() == 8)
assert(describe(counter()) == "above zero")
assert(describe(-2) == "below zero")
assert(describe(0) == "at zero")

local sourceLine = VLT_LINE or 0
assert(sourceLine >= 0)
print("Voltfuscator example passed")
