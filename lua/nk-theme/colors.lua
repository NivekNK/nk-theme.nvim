local hsl = require("nk-theme.colors_util").hsl
local blend = require("nk-theme.colors_util").blend

local M = {}

---@class Palette
local default = {
    none = "NONE",

    bg_dark = hsl(233, 23, 15),
    bg = hsl(234, 22, 17),
    bg_highlight = hsl(232, 24, 24),
    fg_dim = hsl(228, 24, 30),
    fg_dark = hsl(230, 27, 61),
    fg = hsl(225, 69, 87),

    magenta300 = hsl(345, 87, 69),
    magenta400 = hsl(341, 82, 59),
    magenta500 = hsl(338, 81, 53),
    magenta600 = hsl(334, 100, 40),
    magenta700 = hsl(337, 100, 34),

    cyan200 = hsl(194, 63, 81),
    cyan300 = hsl(193, 72, 68),
    cyan400 = hsl(193, 78, 60),
    cyan500 = hsl(191, 89, 48),
    cyan600 = hsl(194, 100, 29),
    cyan700 = hsl(197, 100, 23),

    green300 = hsl(79, 74, 75),
    green400 = hsl(80, 75, 63),
    green500 = hsl(80, 76, 53),
    green600 = hsl(82, 100, 32),
    green700 = hsl(96, 100, 22),

    orange300 = hsl(27, 100, 70),
    orange400 = hsl(27, 100, 62),
    orange500 = hsl(30, 100, 50),
    orange600 = hsl(27, 100, 43),
    orange700 = hsl(23, 100, 36),

    pruple300 = hsl(263, 89, 83),
    purple400 = hsl(263, 87, 78),
    purple500 = hsl(261, 86, 74),
    purple600 = hsl(260, 58, 62),
    purple700 = hsl(259, 44, 52),

    yellow300 = hsl(67, 58, 74),
    yellow400 = hsl(68, 59, 68),
    yellow500 = hsl(69, 59, 65),
    yellow600 = hsl(69, 47, 57),
    yellow700 = hsl(69, 46, 42),

    -- terminal_black = "#444a73",
    -- blue7 = "#394b70",
    -- dark3 = "#545c7e",
    -- dark5 = "#737aa2",
    -- blue0 = "#3e68d7",
    -- blue = "#82aaff",
    -- cyan = "#86e1fc",
    -- blue1 = "#65bcff",
    -- blue2 = "#0db9d7",
    -- blue5 = "#89ddff",
    -- blue6 = "#b4f9f8",
    -- purple = "#fca7ea",
    -- magenta2 = "#ff007c",
    -- magenta = "#c099ff",
    -- orange = "#ff966c",
    -- yellow = "#ffc777",
    -- green = "#c3e88d",
    -- green1 = "#4fd6be",
    -- green2 = "#41a6b5",
    -- teal = "#4fd6be",
    -- red = "#ff757f",
    -- red1 = "#c53b53",
}

---@return ColorScheme
function M.get()
    local config = require("nk-theme.config")

    ---@class ColorScheme: Palette
    local colors = default

    colors.comment = blend(hsl(230, 47, 65), default.bg, 0.7)

    colors.git = {
        add = blend(default.green500, default.bg, 0.9),
        change = blend(default.cyan600, default.bg, 0.9),
        delete = blend(default.magenta600, default.bg, 0.8),
        ignore = hsl(231, 20, 54),
    }

    colors.gitSigns = {
        add = blend(default.green500, default.bg, 0.5),
        change = blend(default.cyan600, default.bg, 0.5),
        delete = blend(default.magenta600, default.bg, 0.6),
    }

    colors.diff = {
        add = default.green600,
        change = default.cyan700,
        delete = default.magenta700,
        text = hsl(220, 33, 33),
    }

    colors.black = blend(default.cyan600, hsl(0, 0, 0), 0.2)
    colors.border_highlight = default.cyan600
    colors.border = colors.black

    -- Popups and statusline always get a dark background
    colors.bg_popup = colors.bg_dark
    colors.bg_statusline = colors.bg_dark

    -- Sidebar and Floats are configurable
    colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
        or config.options.styles.sidebars == "dark" and colors.bg_dark
        or colors.bg

    colors.bg_float = config.options.styles.floats == "transparent" and colors.none
        or config.options.styles.floats == "dark" and colors.bg_dark
        or colors.bg

    colors.bg_visual = colors.cyan700
    colors.bg_search = colors.cyan600
    colors.fg_sidebar = colors.fg_dark
    colors.fg_float = colors.fg

    colors.error = colors.magenta700
    colors.todo = colors.purple400
    colors.warning = colors.yellow500
    colors.info = colors.cyan600
    colors.hint = colors.green400

    colors.delta = {
        add = blend(default.green500, colors.black, 0.45),
        delete = blend(default.magenta600, colors.black, 0.45),
    }

    config.options.on_colors(colors)

    return colors
end

return M
