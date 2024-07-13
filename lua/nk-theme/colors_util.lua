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

return M
