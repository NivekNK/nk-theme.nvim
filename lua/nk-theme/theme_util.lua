local M = {}

---@param group string
function M.highlight(group, hl)
    if hl.style then
        if type(hl.style) == "table" then
            hl = vim.tbl_extend("force", hl, hl.style)
        elseif hl.style:lower() ~= "none" then
            for s in string.gmatch(hl.style, "([^,]+)") do
                hl[s] = true
            end
        end
        hl.style = nil
    end
    vim.api.nvim_set_hl(0, group, hl)
end

function M.syntax(syntax)
    for group, colors in pairs(syntax) do
        M.highlight(group, colors)
    end
end

---@param colors ColorScheme
function M.terminal(colors)
    -- dark
    vim.g.terminal_color_0 = colors.black
    vim.g.terminal_color_8 = colors.terminal_black

    -- light
    vim.g.terminal_color_7 = colors.fg_dark
    vim.g.terminal_color_15 = colors.fg

    -- colors
    vim.g.terminal_color_1 = colors.red
    vim.g.terminal_color_9 = colors.red

    vim.g.terminal_color_2 = colors.green
    vim.g.terminal_color_10 = colors.green

    vim.g.terminal_color_3 = colors.yellow
    vim.g.terminal_color_11 = colors.yellow

    vim.g.terminal_color_4 = colors.blue
    vim.g.terminal_color_12 = colors.blue

    vim.g.terminal_color_5 = colors.magenta
    vim.g.terminal_color_13 = colors.magenta

    vim.g.terminal_color_6 = colors.cyan
    vim.g.terminal_color_14 = colors.cyan
end

---@param config Config
function M.autocmds(config)
    local group = vim.api.nvim_create_augroup("nk-theme", { clear = true })

    vim.api.nvim_create_autocmd("ColorSchemePre", {
        group = group,
        callback = function()
            vim.api.nvim_del_augroup_by_id(group)
        end,
    })

    local function set_whl()
        local win = vim.api.nvim_get_current_win()
        local whl = vim.split(vim.wo[win].winhighlight, ",")
        vim.list_extend(whl, { "Normal:NormalSB", "SignColumn:SignColumnSB" })
        whl = vim.tbl_filter(function(hl)
            return hl ~= ""
        end, whl)
        vim.opt_local.winhighlight = table.concat(whl, ",")
    end

    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = table.concat(config.sidebars, ","),
        callback = set_whl,
    })

    if vim.tbl_contains(config.sidebars, "terminal") then
        vim.api.nvim_create_autocmd("TermOpen", {
            group = group,
            callback = set_whl,
        })
    end
end

---@param theme Theme
function M.load(theme)
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "nk-theme"

    M.syntax(theme.highlights)

    if theme.config.terminal_colors then
        M.terminal(theme.colors)
    end

    M.autocmds(theme.config)

    vim.defer_fn(function()
        M.syntax(theme.defer)
    end, 100)
end

return M
