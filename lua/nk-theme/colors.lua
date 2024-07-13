local hsl = require("nk-theme.colors_util").hsl_to_hex

local M = {}

---@class Palette
local palette = {
    none = "NONE",

    red500 = "#c53b53",

    magenta200 = hsl(344.82, 97.65, 83.33),
    magenta300 = hsl(344.13, 89.63, 73.53),
    magenta400 = hsl(341.34, 83.67, 61.57),
    magenta500 = hsl(338.15, 81.59, 53.14),
    magenta600 = hsl(338.57, 65.42, 41.96),
    magenta700 = hsl(338.9, 57.96, 30.78),
    magante800 = hsl(340, 48, 19.61),

    cyan200 = hsl(195, 73.68, 77.65),
    cyan300 = hsl(194.23, 65.99, 71.18),
    cyan400 = hsl(193.58, 73.26, 63.33),
    cyan500 = hsl(191.28, 89.34, 47.84),
    cyan600 = hsl(191.34, 80.39, 40),
    cyan700 = hsl(192.1, 73.91, 31.57),
    cyan800 = hsl(192.15, 67.52, 22.94),

    green200 = hsl(103.45, 28.16, 59.61),
    green300 = hsl(95.6, 43.96, 59.41),
    green400 = hsl(87.69, 60.19, 57.65),
    green500 = hsl(80, 75.63, 53.33),
    green600 = hsl(90.74, 56.81, 41.76),
    green700 = hsl(99.51, 50, 32.16),
    green800 = hsl(107, 46.15, 25.49),

    orange200 = hsl(22.22, 71.43, 62.94),
    orange300 = hsl(23.7, 81.82, 61.18),
    orange400 = hsl(24.95, 90.48, 58.82),
    orange500 = hsl(30.12, 100, 50),
    orange600 = hsl(24.78, 80.72, 48.82),
    orange700 = hsl(20.74, 71.68, 44.31),
    orange800 = hsl(15.14, 61.33, 35.49),

    gray200 = hsl(210, 20, 98.04),
    gray300 = hsl(220, 14.29, 95.88),
    gray400 = hsl(220, 13.04, 90.98),
    gray500 = hsl(216, 12.2, 83.92),
    gray600 = hsl(217.89, 10.61, 64.9),
    gray700 = hsl(220, 8.94, 46.08),
    gray800 = hsl(215, 13.79, 34.12),

    purple200 = hsl(267.06, 73.91, 86.47),
    purple300 = hsl(264.75, 81.63, 80.78),
    purple400 = hsl(262.2, 84.75, 76.86),
    purple500 = hsl(261.03, 86.67, 73.53),
    purple600 = hsl(259.15, 45.63, 59.61),
    purple700 = hsl(256.8, 32.19, 45.69),
    purple800 = hsl(254.74, 34.55, 32.35),

    yellow200 = hsl(67.16, 54.47, 75.88),
    yellow300 = hsl(67.5, 56.34, 72.16),
    yellow400 = hsl(67.83, 57.5, 68.63),
    yellow500 = hsl(69.14, 59.32, 65.29),
    yellow600 = hsl(66.1, 53.15, 56.47),
    yellow700 = hsl(64.84, 51.67, 52.94),
    yellow800 = hsl(63.26, 51.39, 49.22),
}

---@return Palette
function M.palette()
    ---@class Palette
    local default = {
        none = "NONE",
        bg_dark = "#1e2030",
        bg = "#222436",
        bg_highlight = "#2f334d",
        terminal_black = "#444a73",
        fg = "#c8d3f5",
        fg_dark = "#828bb8",
        fg_gutter = "#3b4261",
        dark3 = "#545c7e",
        dark5 = "#737aa2",
        blue0 = "#3e68d7",
        blue = "#82aaff",
        cyan = "#86e1fc",
        blue1 = "#65bcff",
        blue2 = "#0db9d7",
        blue5 = "#89ddff",
        blue6 = "#b4f9f8",
        blue7 = "#394b70",
        purple = "#fca7ea",
        magenta2 = "#ff007c",
        magenta = "#c099ff",
        orange = "#ff966c",
        yellow = "#ffc777",
        green = "#c3e88d",
        green1 = "#4fd6be",
        green2 = "#41a6b5",
        teal = "#4fd6be",
        red = "#ff757f",
        red1 = "#c53b53",

        comment = "undefined",
        git = {
            add = "undefined",
            change = "undefined",
            delete = "undefined"
        },
        gitSigns = {
            add = "undefined",
            change = "undefined",
            delete = "undefined",
        },

        nk_magenta = "#e9266d",
        nk_cyan = "#0dbee7",
        nk_light_cyan = "#9cdbf0",
        nk_green = "#a6e22e",
        nk_orange = "#ff8000",
        nk_white = "#f8f8f1",
        nk_purple = "#aa81f6",
        nk_yellow = "#cbdb72",
    }

    default.comment = util.blend("#7a88cf", default.bg, "bb")
    default.git = {
        add = util.blend(default.green, default.bg, "ee"),
        change = util.blend(default.blue, default.bg, "ee"),
        delete = util.blend(default.red, default.bg, "dd"),
    }
    default.gitSigns = {
        add = util.blend(default.green, default.bg, "66"),
        change = util.blend(default.blue, default.bg, "66"),
        delete = util.blend(default.red, default.bg, "aa"),
    }

    return default
end

---@return ColorScheme
function M.get()
    local config = require("nk-theme.config")

    ---@class ColorScheme: Palette
    local colors = M.palette()

    util.bg = colors.bg
    util.fg = colors.fg

    colors.diff = {
        add = util.darken(colors.green2, 0.15),
        change = util.darken(colors.blue7, 0.15),
        delete = util.darken(colors.red1, 0.15),
        text = colors.blue7,
    }

    colors.git.ignore = colors.dark3
    colors.black = util.darken(colors.bg, 0.8, "#000000")
    colors.border_highlight = util.darken(colors.blue1, 0.8)
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

    colors.bg_visual = util.darken(colors.blue0, 0.4)
    colors.bg_search = colors.blue0
    colors.fg_sidebar = colors.fg_dark
    colors.fg_float = colors.fg

    colors.error = colors.red1
    colors.todo = colors.blue
    colors.warning = colors.yellow
    colors.info = colors.blue2
    colors.hint = colors.teal

    colors.delta = {
        add = util.darken(colors.green2, 0.45),
        delete = util.darken(colors.red1, 0.45),
    }

    config.options.on_colors(colors)

    return colors
end

return M
