local config = require("nk-theme.config")
local util = require("nk-theme.theme_util")
local theme = require("nk-theme.theme")

local M = {}

---@param opts Config|nil
function M.load(opts)
    config.extend(opts)
    util.load(theme.get())
end

M.setup = config.setup

return M
