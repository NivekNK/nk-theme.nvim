local util = require("nk-theme.colors_util")

local M = {}

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
