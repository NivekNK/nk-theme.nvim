local M = {}

---@param hue number
---@param saturation number
---@param lightness number
---@return string Color in hexadecimal
function M.hsl_to_hex(hue, saturation, lightness)
    lightness = lightness / 100
    local a = saturation * math.min(lightness, 1 - lightness) / 100
    local f = function(n)
        local k = (n + hue / 30) % 12
        local color = lightness - a * math.max(math.min(k - 3, 9 - k, 1), -1)
        return string.format("%02x", math.floor(255 * color + 0.5))
    end
    return "#" .. f(0) .. f(8) .. f(4)
end

---@param c string
local function hex_to_rgb(c)
    c = string.lower(c)
    return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
---@return string
function M.blend(foreground, background, alpha)
    alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha

    local bg = hex_to_rgb(background)
    local fg = hex_to_rgb(foreground)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

---@param hex string color
---@param amount number number between 0 and 1. 0 results in bg, 1 results in fg
---@param bg string|nil background color
---@return string
function M.darken(hex, amount, bg)
    if not bg then
        bg = require("nk-theme.colors").palette.black700
    end
    return M.blend(hex, bg, amount)
end

---@param hex string color
---@param amount number number between 0 and 1. 0 results in bg, 1 results in fg
---@param fg string|nil foreground color
---@return string
function M.lighten(hex, amount, fg)
    if not fg then
        fg = require("nk-theme.colors").palette.gray200
    end
    return M.blend(hex, fg, amount)
end

return M
