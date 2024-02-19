local M = {}

---@param c string Color in hex format
local function hexToRgb(c)
    c = string.lower(c)
    return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

-- Code from https://stackoverflow.com/questions/36721830/convert-hsl-to-rgb-and-hex
---@param hue float
---@param saturation float
---@param lightness float
---@return string color in hexadecimal format
function M.hsl(hue, saturation, lightness)
    -- Normalize lightness value
    lightness = lightness / 100

    -- Calculate amount of saturation
    local chroma = saturation * math.min(lightness, 1 - lightness) / 100

    local function f(angle)
        local k = (angle + hue / 30) % 12
        local color = lightness - chroma * math.max(math.min(k - 3, 9 - k, 1), -1)
        return string.format("#%02x", math.floor(255 * color))
    end

    -- Combine hex values for red, green, and blue channels
    return f(0) .. f(8) .. f(4)
end

---@param foreground string foreground color in hexadecimal format
---@param background string background color in hexadecimal format
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
---@return string color in hexadecimal format
function M.blend(foreground, background, alpha)
    local bg = hexToRgb(background)
    local fg = hexToRgb(foreground)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

return M
