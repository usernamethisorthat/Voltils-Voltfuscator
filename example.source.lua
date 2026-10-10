local function makeCounter(step)
    local total = 0
    return function()
        total = total + step
        return total
    end
end

local function classify(value)
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
assert(classify(counter()) == "above zero")
assert(classify(-2) == "below zero")
assert(classify(0) == "at zero")
print("Hello from Voltfuscator!")
