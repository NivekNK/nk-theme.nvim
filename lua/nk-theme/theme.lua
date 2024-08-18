local colors = require("nk-theme.colors")
local util = require("nk-theme.colors_util")

local M = {}

---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight
---@field link string|nil

---@alias Highlights table<string,Highlight>

---@return Theme
function M.get()
    local config = require("nk-theme.config")
    local options = config.options

    ---@class Theme
    ---@field highlights Highlights
    local theme = {
        config = options,
        colors = colors.get(),
    }

    local c = theme.colors

    theme.highlights = {
        Foo = { bg = c.magenta500, fg = c.fg },

        Comment = { fg = c.comment, style = options.styles.comments }, -- any comment
        ColorColumn = { bg = c.black700 }, -- used for the columns set with 'colorcolumn'
        Conceal = { fg = c.gray700 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor = { fg = c.bg, bg = c.fg }, -- character under the cursor
        lCursor = { fg = c.bg, bg = c.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM = { fg = c.bg, bg = c.fg }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorColumn = { bg = c.bg_highlight }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine = { bg = c.bg_highlight }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory = { fg = c.purple400 }, -- directory names (and other special names in listings)
        DiffAdd = { bg = c.git.add }, -- diff mode: Added line |diff.txt|
        DiffChange = { bg = c.git.change }, -- diff mode: Changed line |diff.txt|
        DiffDelete = { bg = c.git.delete }, -- diff mode: Deleted line |diff.txt|
        DiffText = { bg = c.git.text }, -- diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer = { fg = c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        -- TermCursor  = { }, -- cursor in a focused terminal
        -- TermCursorNC= { }, -- cursor in an unfocused terminal
        ErrorMsg = { fg = c.error }, -- error messages on the command line
        VertSplit = { fg = c.border }, -- the column separating vertically split windows
        WinSeparator = { fg = c.border, bold = true }, -- the column separating vertically split windows
        Folded = { fg = c.purple400, bg = c.fg_gutter }, -- line used for closed folds
        FoldColumn = { bg = options.transparent and c.none or c.bg, fg = c.comment }, -- 'foldcolumn'
        SignColumn = { bg = options.transparent and c.none or c.bg, fg = c.fg_gutter }, -- column where |signs| are displayed
        SignColumnSB = { bg = c.bg_sidebar, fg = c.fg_gutter }, -- column where |signs| are displayed
        Substitute = { bg = c.red500, fg = c.black700 }, -- |:substitute| replacement text highlighting
        LineNr = { fg = c.fg_gutter }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr = { fg = c.gray700 }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen = { fg = c.orange500, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = { fg = c.fg, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea = { fg = c.fg }, -- Area for messages and cmdline
        -- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        MoreMsg = { fg = c.purple400 }, -- |more-prompt|
        NonText = { fg = c.gray800 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = { fg = c.fg, bg = options.transparent and c.none or c.bg }, -- normal text
        NormalNC = { fg = c.fg, bg = options.transparent and c.none or options.dim_inactive and c.bg_darker or c.bg }, -- normal text in non-current windows
        NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in sidebar
        NormalFloat = { fg = c.fg_float, bg = c.bg_float }, -- Normal text in floating windows.
        FloatBorder = { fg = c.border_highlight, bg = c.bg_float },
        FloatTitle = { fg = c.border_highlight, bg = c.bg_float },
        Pmenu = { bg = c.bg_popup, fg = c.fg }, -- Popup menu: normal item.
        PmenuSel = { bg = util.darken(c.fg_gutter, 0.8) }, -- Popup menu: selected item.
        PmenuSbar = { bg = util.lighten(c.bg_popup, 0.95) }, -- Popup menu: scrollbar.
        PmenuThumb = { bg = c.fg_gutter }, -- Popup menu: Thumb of the scrollbar.
        Question = { fg = c.purple400 }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine = { bg = c.bg_visual, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search = { bg = c.bg_search, fg = c.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        IncSearch = { bg = c.orange500, fg = c.black700 }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        CurSearch = { link = "IncSearch" },
        SpecialKey = { fg = c.gray800 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = { sp = c.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine = { fg = c.fg_sidebar, bg = c.bg_statusline }, -- status line of current window
        StatusLineNC = { fg = c.fg_gutter, bg = c.bg_statusline }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine = { bg = c.bg_statusline, fg = c.fg_gutter }, -- tab pages line, not active tab page label
        TabLineFill = { bg = c.black700 }, -- tab pages line, where there are no labels
        TabLineSel = { fg = c.black700, bg = c.purple400 }, -- tab pages line, active tab page label
        Title = { fg = c.purple400, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
        Visual = { bg = c.bg_visual }, -- Visual mode selection
        VisualNOS = { bg = c.bg_visual }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg = { fg = c.warning }, -- warning messages
        Whitespace = { fg = c.fg_gutter }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion
        WinBar = { link = "StatusLine" }, -- window bar
        WinBarNC = { link = "StatusLineNC" }, -- window bar in inactive windows

        -- These groups are not listed as default vim groups,
        -- but they are defacto standard group names for syntax highlighting.
        -- commented out groups should chain up to their "preferred" group by
        -- default,
        -- Uncomment and edit if you want more specific syntax highlighting.

        -- Constant = { fg = c.nk_purple }, -- (preferred) any constant
        String = { fg = c.yellow500 }, --   a string constant: "this is a string"
        Character = { fg = c.yellow500 }, --  a character constant: 'c', '\n'
        Boolean       = { fg = c.magenta500 }, --  a boolean constant: TRUE, false
        Number        = { fg = c.purple500 }, --   a number constant: 234, 0xff
        Float         = { fg = c.purple500 }, --    a floating point constant: 2.3e10

        Identifier = { fg = c.gray200, style = options.styles.variables }, -- (preferred) any variable name
        Function = { fg = c.orange500, style = options.styles.functions }, -- function name (also: methods for classes)

        Statement = { fg = c.magenta500 }, -- (preferred) any statement
        -- Conditional   = { }, --  if, then, else, endif, switch, etc.
        -- Repeat        = { }, --   for, do, while, etc.
        -- Label         = { }, --    case, default, etc.
        Operator = { fg = c.magenta500 }, -- "sizeof", "+", "*", etc.
        Keyword = { fg = c.magenta500, style = options.styles.keywords }, --  any other keyword
        -- Exception     = { }, --  try, catch, throw

        PreProc = { fg = c.orange200 }, -- (preferred) generic Preprocessor
        -- Include       = { }, --  preprocessor #include
        -- Define        = { }, --   preprocessor #define
        -- Macro         = { }, --    same as Define
        -- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

        Type = { fg = c.cyan500 }, -- (preferred) int, long, char, etc.
        StorageClass  = { fg = c.magenta500 }, -- static, register, volatile, etc.
        -- Structure     = { }, --  struct, union, enum, etc.
        -- Typedef       = { }, --  A typedef

        Special = { fg = c.magenta500 }, -- (preferred) any special symbol
        -- SpecialChar   = { }, --  special character in a constant
        -- Tag           = { }, --    you can use CTRL-] on this
        Delimiter = { link = "Special" }, --  character that needs attention
        -- SpecialComment= { }, -- special things inside a comment
        Debug = { fg = c.orange500 }, --    debugging statements

        Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
        Bold = { bold = true },
        Italic = { italic = true },

        -- ("Ignore", below, may be invisible...)
        -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

        Error = { fg = c.error }, -- (preferred) any erroneous construct
        Todo = { bg = c.todo, fg = c.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        qfLineNr = { fg = c.gray700 },
        qfFileName = { fg = c.purple400 },

        htmlH1 = { fg = c.magenta500, bold = true },
        htmlH2 = { fg = c.purple400, bold = true },

        mkdCodeDelimiter = { bg = c.terminal_black, fg = c.fg },
        mkdCodeStart = { fg = c.green300, bold = true },
        mkdCodeEnd = { fg = c.green300, bold = true },

        markdownHeadingDelimiter = { fg = c.orange500, bold = true },
        markdownCode = { fg = c.green300 },
        markdownCodeBlock = { fg = c.green300 },
        markdownH1 = { fg = c.magenta500, bold = true },
        markdownH2 = { fg = c.purple400, bold = true },
        markdownLinkText = { fg = c.purple400, underline = true },

        ["helpCommand"] = { bg = c.terminal_black, fg = c.purple400 },

        debugPC = { bg = c.bg_sidebar }, -- used for highlighting the current line in terminal-debug
        debugBreakpoint = { bg = util.darken(c.info, 0.1), fg = c.info }, -- used for breakpoint colors in terminal-debug

        dosIniLabel = { link = "@property" },

        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own. Consult your LSP client's
        -- documentation.
        LspReferenceText = { bg = c.fg_gutter }, -- used for highlighting "text" references
        LspReferenceRead = { bg = c.fg_gutter }, -- used for highlighting "read" references
        LspReferenceWrite = { bg = c.fg_gutter }, -- used for highlighting "write" references

        DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticUnnecessary = { fg = c.terminal_black }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

        DiagnosticVirtualTextError = { bg = util.darken(c.error, 0.1), fg = c.error }, -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextWarn = { bg = util.darken(c.warning, 0.1), fg = c.warning }, -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextInfo = { bg = util.darken(c.info, 0.1), fg = c.info }, -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextHint = { bg = util.darken(c.hint, 0.1), fg = c.hint }, -- Used for "Hint" diagnostic virtual text

        DiagnosticUnderlineError = { undercurl = true, sp = c.error }, -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo = { undercurl = true, sp = c.info }, -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint = { undercurl = true, sp = c.hint }, -- Used to underline "Hint" diagnostics

        LspSignatureActiveParameter = { bg = util.darken(c.bg_visual, 0.4), bold = true },
        LspCodeLens = { fg = c.comment },
        LspInlayHint = { bg = util.darken(c.purple400, 0.1), fg = c.gray800 },

        LspInfoBorder = { fg = c.border_highlight, bg = c.bg_float },

        ALEErrorSign = { fg = c.error },
        ALEWarningSign = { fg = c.warning },

        DapStoppedLine = { bg = util.darken(c.warning, 0.1) }, -- Used for "Warning" diagnostic virtual text

        -- These groups are for the Neovim tree-sitter highlights.
        ["@annotation"] = { link = "PreProc" },
        ["@attribute"] = { link = "PreProc" },
        ["@boolean"] = { link = "Boolean" },
        ["@character"] = { link = "Character" },
        ["@character.special"] = { link = "SpecialChar" },
        ["@comment"] = { link = "Comment" },
        ["@keyword.conditional"] = { link = "Conditional" },
        ["@constant"] = { link = "Constant" },
        ["@constant.builtin"] = { link = "@type.builtin" },
        ["@constant.macro"] = { link = "Define" },
        ["@keyword.debug"] = { link = "Debug" },
        ["@keyword.directive.define"] = { link = "Define" },
        ["@keyword.exception"] = { link = "Exception" },
        ["@number.float"] = { link = "Float" },
        ["@function"] = { link = "Function" },
        ["@function.builtin"] = { link = "@function" },
        ["@function.call"] = { link = "@function" },
        ["@function.macro"] = { link = "Macro" },
        ["@keyword.import"] = { link = "Include" },
        ["@keyword.coroutine"] = { link = "@keyword" },
        ["@keyword.operator"] = { link = "@operator" },
        ["@keyword.return"] = { link = "@keyword" },
        ["@function.method"] = { link = "Function" },
        ["@function.method.call"] = { link = "@function.method" },
        ["@namespace.builtin"] = { link = "@variable.builtin" },
        ["@none"] = {},
        ["@number"] = { link = "Number" },
        ["@keyword.directive"] = { link = "PreProc" },
        ["@keyword.repeat"] = { link = "Repeat" },
        ["@keyword.storage"] = { link = "StorageClass" },
        ["@string"] = { link = "String" },
        ["@markup.link.label"] = { link = "SpecialChar" },
        ["@markup.link.label.symbol"] = { link = "Identifier" },
        ["@tag"] = { link = "Label" },
        ["@tag.attribute"] = { link = "@property" },
        ["@tag.delimiter"] = { link = "Delimiter" },
        ["@markup"] = { link = "@none" },
        ["@markup.environment"] = { link = "Macro" },
        ["@markup.environment.name"] = { link = "Type" },
        ["@markup.raw"] = { link = "String" },
        ["@markup.math"] = { link = "Special" },
        ["@markup.strong"] = { bold = true },
        ["@markup.emphasis"] = { italic = true },
        ["@markup.strikethrough"] = { strikethrough = true },
        ["@markup.underline"] = { underline = true },
        ["@markup.heading"] = { link = "Title" },
        ["@comment.note"] = { fg = c.hint },
        ["@comment.error"] = { fg = c.error },
        ["@comment.hint"] = { fg = c.hint },
        ["@comment.info"] = { fg = c.info },
        ["@comment.warning"] = { fg = c.warning },
        ["@comment.todo"] = { fg = c.todo },
        ["@markup.link.url"] = { link = "Underlined" },
        ["@type"] = { link = "Type" },
        ["@type.definition"] = { link = "Typedef" },
        ["@type.qualifier"] = { link = "@keyword" },

        --- Misc
        ["@operator"] = { fg = c.magenta500 }, -- For any operator: `+`, but also `->` and `*` in C.

        --- Punctuation
        ["@punctuation.delimiter"] = { fg = c.purple400 }, -- For delimiters ie: `.`
        ["@punctuation.bracket"] = { fg = c.fg_darker }, -- For brackets and parens.
        ["@punctuation.special"] = { fg = c.purple400 }, -- For special symbols (e.g. `{}` in string interpolation)
        ["@markup.list"] = { fg = c.purple400 }, -- For special punctutation that does not fall in the catagories before.
        ["@markup.list.markdown"] = { fg = c.orange500, bold = true },

        --- Literals
        ["@string.documentation"] = { fg = c.yellow500 },
        ["@string.regexp"] = { fg = c.purple400 }, -- For regexes.
        ["@string.escape"] = { fg = c.magenta500 }, -- For escape characters within a string.

        --- Functions
        ["@constructor"] = { fg = c.magenta500 }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
        ["@variable.parameter"] = { fg = c.cyan300 }, -- For parameters of a function.
        ["@variable.parameter.builtin"] = { fg = c.cyan300 }, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]

        --- Keywords
        ["@keyword"] = { fg = c.magenta500, style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
        ["@keyword.function"] = { fg = c.magenta500, style = options.styles.functions }, -- For keywords used to define a fuction.

        ["@label"] = { fg = c.purple400 }, -- For labels: `label:` in C and `:label:` in Lua.

        --- Types
        ["@type.builtin"] = { fg = c.magenta500 },
        ["@variable.member"] = { fg = c.cyan300 }, -- For fields.
        ["@property"] = { fg = c.cyan300 },

        --- Identifiers
        ["@variable"] = { fg = c.fg, style = options.styles.variables }, -- Any variable name that does not have another highlight.
        ["@variable.builtin"] = { fg = c.magenta500 }, -- Variable names that are defined by the languages, like `this` or `self`.
        ["@module.builtin"] = { fg = c.red500 }, -- Variable names that are defined by the languages, like `this` or `self`.

        --- Text
        ["@markup.raw.markdown_inline"] = { bg = c.terminal_black, fg = c.purple400 },
        ["@markup.link"] = { fg = c.green300 },

        ["@markup.list.unchecked"] = { fg = c.purple400 }, -- For brackets and parens.
        ["@markup.list.checked"] = { fg = c.green500 }, -- For brackets and parens.

        ["@diff.plus"] = { link = "DiffAdd" },
        ["@diff.minus"] = { link = "DiffDelete" },
        ["@diff.delta"] = { link = "DiffChange" },

        ["@module"] = { link = "Include" },

        -- tsx
        ["@tag.tsx"] = { fg = c.red500 },
        ["@constructor.tsx"] = { fg = c.purple400 },
        ["@tag.delimiter.tsx"] = { fg = util.darken(c.purple400, 0.7) },
        typescriptVariable = { fg = c.magenta500 },
        tsxAttrib = { fg = c.cyan300 },
        tsxTagName = { fg = c.purple400 },
        htmlTagName = { fg = c.purple400 },
        typescriptArrayMethod = { fg = c.orange500 };

        -- Custom
        ["@lsp.type.struct"] = { fg = c.green500 },
        ["@lsp.type.typeParameter"] = { fg = c.green500 },

        -- LSP Semantic Token Groups
        ["@lsp.type.boolean"] = { link = "@boolean" },
        ["@lsp.type.builtinType"] = { link = "@type.builtin" },
        ["@lsp.type.comment"] = { link = "@comment" },
        ["@lsp.type.decorator"] = { link = "@attribute" },
        ["@lsp.type.deriveHelper"] = { link = "@attribute" },
        ["@lsp.type.enum"] = { fg = c.purple500 },
        ["@lsp.type.enumMember"] = { fg = c.orange500 },
        ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
        ["@lsp.type.formatSpecifier"] = { link = "@markup.list" },
        ["@lsp.type.generic"] = { link = "@variable" },
        ["@lsp.type.interface"] = { fg = c.purple500 },
        ["@lsp.type.keyword"] = { link = "@keyword" },
        ["@lsp.type.lifetime"] = { link = "@keyword.storage" },
        ["@lsp.type.namespace"] = { link = "@module" },
        ["@lsp.type.number"] = { link = "@number" },
        ["@lsp.type.operator"] = { link = "@operator" },
        ["@lsp.type.parameter"] = { link = "@variable.parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
        ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
        ["@lsp.type.string"] = { link = "@string" },
        ["@lsp.type.typeAlias"] = { link = "@type.definition" },
        ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.error },
        ["@lsp.type.variable"] = { link = "@variable" }, -- use treesitter styles for regular variables
        ["@lsp.typemod.class.defaultLibrary"] = { link = c.cyan500 },
        ["@lsp.typemod.class.deduced"] = { link = "@type.builtin" },
        ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
        ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
        ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
        ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.operator.injected"] = { link = "@operator" },
        ["@lsp.typemod.string.injected"] = { link = "@string" },
        ["@lsp.typemod.struct.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.type.defaultLibrary"] = { fg = c.magenta500 },
        ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = c.purple400 },
        ["@lsp.typemod.variable.callable"] = { link = "@function" },
        ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
        ["@lsp.typemod.variable.injected"] = { link = "@variable" },
        ["@lsp.typemod.variable.static"] = { link = "@variable" },
        -- NOTE: maybe add these with distinct highlights?
        -- ["@lsp.typemod.variable.globalScope"] (global variables)

        -- ts-rainbow
        rainbowcol1 = { fg = c.red500 },
        rainbowcol2 = { fg = c.orange500 },
        rainbowcol3 = { fg = c.yellow500 },
        rainbowcol4 = { fg = c.green500 },
        rainbowcol5 = { fg = c.purple500 },
        rainbowcol6 = { fg = c.magenta500 },
        rainbowcol7 = { fg = c.cyan500 },

        -- ts-rainbow2 (maintained fork)
        TSRainbowRed = { fg = c.red500 },
        TSRainbowOrange = { fg = c.orange500 },
        TSRainbowYellow = { fg = c.yellow500 },
        TSRainbowGreen = { fg = c.green500 },
        TSRainbowBlue = { fg = c.purple500 },
        TSRainbowViolet = { fg = c.magenta500 },
        TSRainbowCyan = { fg = c.cyan500 },

        -- rainbow-delimiters
        RainbowDelimiterRed = { fg = c.red500 },
        RainbowDelimiterOrange = { fg = c.orange500 },
        RainbowDelimiterYellow = { fg = c.yellow500 },
        RainbowDelimiterGreen = { fg = c.green500 },
        RainbowDelimiterBlue = { fg = c.purple500 },
        RainbowDelimiterViolet = { fg = c.magenta500 },
        RainbowDelimiterCyan = { fg = c.cyan500 },

        -- LspTrouble
        TroubleText = { fg = c.fg_darker },
        TroubleCount = { fg = c.magenta500, bg = c.fg_gutter },
        TroubleNormal = { fg = c.fg, bg = c.bg_sidebar },

        -- Illuminate
        illuminatedWord = { bg = c.fg_gutter },
        illuminatedCurWord = { bg = c.fg_gutter },
        IlluminatedWordText = { bg = c.fg_gutter },
        IlluminatedWordRead = { bg = c.fg_gutter },
        IlluminatedWordWrite = { bg = c.fg_gutter },

        -- diff
        diffAdded = { fg = c.git.add },
        diffRemoved = { fg = c.git.delete },
        diffChanged = { fg = c.git.change },
        diffOldFile = { fg = c.yellow500 },
        diffNewFile = { fg = c.orange500 },
        diffFile = { fg = c.purple400 },
        diffLine = { fg = c.comment },
        diffIndexLine = { fg = c.magenta500 },

        -- Neogit
        NeogitBranch = { fg = c.magenta500 },
        NeogitRemote = { fg = c.purple500 },
        NeogitHunkHeader = { bg = c.bg_highlight, fg = c.fg },
        NeogitHunkHeaderHighlight = { bg = c.fg_gutter, fg = c.purple400 },
        NeogitDiffContextHighlight = { bg = util.darken(c.fg_gutter, 0.5), fg = c.fg_darker },
        NeogitDiffDeleteHighlight = { fg = c.git.delete, bg = c.git.delete },
        NeogitDiffAddHighlight = { fg = c.git.add, bg = c.git.add },

        -- Neotest
        NeotestPassed = { fg = c.green500 },
        NeotestRunning = { fg = c.yellow500 },
        NeotestFailed = { fg = c.red500 },
        NeotestSkipped = { fg = c.purple400 },
        NeotestTest = { fg = c.fg_sidebar },
        NeotestNamespace = { fg = c.green200 },
        NeotestFocused = { fg = c.yellow500 },
        NeotestFile = { fg = c.green300 },
        NeotestDir = { fg = c.purple400 },
        NeotestBorder = { fg = c.purple400 },
        NeotestIndent = { fg = c.fg_sidebar },
        NeotestExpandMarker = { fg = c.fg_sidebar },
        NeotestAdapterName = { fg = c.purple500, bold = true },
        NeotestWinSelect = { fg = c.purple400 },
        NeotestMarked = { fg = c.purple400 },
        NeotestTarget = { fg = c.purple400 },
        --[[ NeotestUnknown = {}, ]]

        -- GitGutter
        GitGutterAdd = { fg = c.git.add }, -- diff mode: Added line |diff.txt|
        GitGutterChange = { fg = c.git.change }, -- diff mode: Changed line |diff.txt|
        GitGutterDelete = { fg = c.git.delete }, -- diff mode: Deleted line |diff.txt|
        GitGutterAddLineNr = { fg = c.git.add },
        GitGutterChangeLineNr = { fg = c.git.change },
        GitGutterDeleteLineNr = { fg = c.git.delete },

        -- GitSigns
        GitSignsAdd = { fg = c.git.add }, -- diff mode: Added line |diff.txt|
        GitSignsChange = { fg = c.git.change }, -- diff mode: Changed line |diff.txt|
        GitSignsDelete = { fg = c.git.delete }, -- diff mode: Deleted line |diff.txt|

        -- Telescope
        TelescopeBorder = { fg = c.border_highlight, bg = c.bg_float },
        TelescopeNormal = { fg = c.fg, bg = c.bg_float },

        -- NvimTree
        NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        NvimTreeWinSeparator = {
            fg = options.styles.sidebars == "transparent" and c.border or c.bg_sidebar,
            bg = c.bg_sidebar,
        },
        NvimTreeNormalNC = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        NvimTreeRootFolder = { fg = c.purple400, bold = true },
        NvimTreeGitDirty = { fg = c.git.change },
        NvimTreeGitNew = { fg = c.git.add },
        NvimTreeGitDeleted = { fg = c.git.delete },
        NvimTreeOpenedFile = { bg = c.bg_highlight },
        NvimTreeSpecialFile = { fg = c.purple500, underline = true },
        NvimTreeIndentMarker = { fg = c.fg_gutter },
        NvimTreeImageFile = { fg = c.fg_sidebar },
        NvimTreeSymlink = { fg = c.purple400 },
        NvimTreeFolderIcon = { bg = c.none, fg = c.purple400 },

        NeoTreeNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        NeoTreeNormalNC = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        NeoTreeDimText = { fg = c.fg_gutter },

        -- Fern
        FernBranchText = { fg = c.purple400 },

        -- glyph palette
        GlyphPalette1 = { fg = c.red500 },
        GlyphPalette2 = { fg = c.green500 },
        GlyphPalette3 = { fg = c.yellow500 },
        GlyphPalette4 = { fg = c.purple400 },
        GlyphPalette6 = { fg = c.green800 },
        GlyphPalette7 = { fg = c.fg },
        GlyphPalette9 = { fg = c.red300 },

        -- Dashboard
        DashboardShortCut = { fg = c.cyan500 },
        DashboardHeader = { fg = c.purple400 },
        DashboardCenter = { fg = c.magenta500 },
        DashboardFooter = { fg = c.purple400 },
        DashboardKey = { fg = c.orange500 },
        DashboardDesc = { fg = c.cyan500 },
        DashboardIcon = { fg = c.cyan500, bold = true },

        -- Alpha
        AlphaShortcut = { fg = c.orange500 },
        AlphaHeader = { fg = c.purple400 },
        AlphaHeaderLabel = { fg = c.orange500 },
        AlphaFooter = { fg = c.purple400 },
        AlphaButtons = { fg = c.cyan500 },

        -- WhichKey
        WhichKey = { fg = c.cyan500 },
        WhichKeyGroup = { fg = c.purple400 },
        WhichKeyDesc = { fg = c.magenta500 },
        WhichKeySeperator = { fg = c.comment },
        WhichKeySeparator = { fg = c.comment },
        WhichKeyFloat = { bg = c.bg_sidebar },
        WhichKeyValue = { fg = c.gray700 },

        -- LspSaga
        DiagnosticWarning = { link = "DiagnosticWarn" },
        DiagnosticInformation = { link = "DiagnosticInfo" },

        LspFloatWinNormal = { bg = c.bg_float },
        LspFloatWinBorder = { fg = c.border_highlight },
        LspSagaBorderTitle = { fg = c.cyan500 },
        LspSagaHoverBorder = { fg = c.purple400 },
        LspSagaRenameBorder = { fg = c.green500 },
        LspSagaDefPreviewBorder = { fg = c.green500 },
        LspSagaCodeActionBorder = { fg = c.purple400 },
        LspSagaFinderSelection = { fg = c.bg_visual },
        LspSagaCodeActionTitle = { fg = c.purple400 },
        LspSagaCodeActionContent = { fg = c.purple500 },
        LspSagaSignatureHelpBorder = { fg = c.red500 },
        ReferencesCount = { fg = c.purple500 },
        DefinitionCount = { fg = c.purple500 },
        DefinitionIcon = { fg = c.purple400 },
        ReferencesIcon = { fg = c.purple400 },
        TargetWord = { fg = c.cyan500 },

        -- NeoVim
        healthError = { fg = c.error },
        healthSuccess = { fg = c.green500 },
        healthWarning = { fg = c.warning },

        -- BufferLine
        BufferLineIndicatorSelected = { fg = c.git.change },

        -- Barbar
        BufferCurrent = { bg = c.bg, fg = c.fg },
        BufferCurrentERROR = { bg = c.bg, fg = c.error },
        BufferCurrentHINT = { bg = c.bg, fg = c.hint },
        BufferCurrentINFO = { bg = c.bg, fg = c.info },
        BufferCurrentWARN = { bg = c.bg, fg = c.warning },
        BufferCurrentIndex = { bg = c.bg, fg = c.info },
        BufferCurrentMod = { bg = c.bg, fg = c.warning },
        BufferCurrentSign = { bg = c.bg, fg = c.bg },
        BufferCurrentTarget = { bg = c.bg, fg = c.red500 },
        BufferAlternate = { bg = c.fg_gutter, fg = c.fg },
        BufferAlternateERROR = { bg = c.fg_gutter, fg = c.error },
        BufferAlternateHINT = { bg = c.fg_gutter, fg = c.hint },
        BufferAlternateIndex = { bg = c.fg_gutter, fg = c.info },
        BufferAlternateINFO = { bg = c.fg_gutter, fg = c.info },
        BufferAlternateMod = { bg = c.fg_gutter, fg = c.warning },
        BufferAlternateSign = { bg = c.fg_gutter, fg = c.info },
        BufferAlternateTarget = { bg = c.fg_gutter, fg = c.red500 },
        BufferAlternateWARN = { bg = c.fg_gutter, fg = c.warning },
        BufferVisible = { bg = c.bg_statusline, fg = c.fg },
        BufferVisibleERROR = { bg = c.bg_statusline, fg = c.error },
        BufferVisibleHINT = { bg = c.bg_statusline, fg = c.hint },
        BufferVisibleINFO = { bg = c.bg_statusline, fg = c.info },
        BufferVisibleWARN = { bg = c.bg_statusline, fg = c.warning },
        BufferVisibleIndex = { bg = c.bg_statusline, fg = c.info },
        BufferVisibleMod = { bg = c.bg_statusline, fg = c.warning },
        BufferVisibleSign = { bg = c.bg_statusline, fg = c.info },
        BufferVisibleTarget = { bg = c.bg_statusline, fg = c.red500 },
        BufferInactive = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.gray700, 0.8) },
        BufferInactiveERROR = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.error, 0.8) },
        BufferInactiveHINT = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.hint, 0.8) },
        BufferInactiveINFO = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.info, 0.8) },
        BufferInactiveWARN = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
        BufferInactiveIndex = { bg = util.darken(c.bg_highlight, 0.4), fg = c.gray700 },
        BufferInactiveMod = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
        BufferInactiveSign = { bg = util.darken(c.bg_highlight, 0.4), fg = c.bg },
        BufferInactiveTarget = { bg = util.darken(c.bg_highlight, 0.4), fg = c.red500 },
        BufferOffset = { bg = c.bg_statusline, fg = c.gray700 },
        BufferTabpageFill = { bg = util.darken(c.bg_highlight, 0.8), fg = c.gray700 },
        BufferTabpages = { bg = c.bg_statusline, fg = c.none },

        -- Sneak
        Sneak = { fg = c.bg_highlight, bg = c.magenta500 },
        SneakScope = { bg = c.bg_visual },

        -- Hop
        HopNextKey = { fg = c.magenta400, bold = true },
        HopNextKey1 = { fg = c.purple400, bold = true },
        HopNextKey2 = { fg = util.darken(c.purple400, 0.6) },
        HopUnmatched = { fg = c.gray800 },

        TSNodeKey = { fg = c.magenta400, bold = true },
        TSNodeUnmatched = { fg = c.gray800 },

        LeapMatch = { bg = c.magenta400, fg = c.fg, bold = true },
        LeapLabelPrimary = { fg = c.magenta400, bold = true },
        LeapLabelSecondary = { fg = c.green800, bold = true },
        LeapBackdrop = { fg = c.gray800 },

        FlashBackdrop = { fg = c.gray800 },
        FlashLabel = { bg = c.magenta400, bold = true, fg = c.fg },

        LightspeedGreyWash = { fg = c.gray800 },
        LightspeedLabel = { fg = c.magenta400, bold = true, underline = true },
        LightspeedLabelDistant = { fg = c.green800, bold = true, underline = true },
        LightspeedLabelDistantOverlapped = { fg = c.green700, underline = true },
        LightspeedLabelOverlapped = { fg = c.magenta400, underline = true },
        LightspeedMaskedChar = { fg = c.orange500 },
        LightspeedOneCharMatch = { bg = c.magenta400, fg = c.fg, bold = true },
        LightspeedPendingOpArea = { bg = c.magenta400, fg = c.fg },
        LightspeedShortcut = { bg = c.magenta400, fg = c.fg, bold = true, underline = true },
        LightspeedUnlabeledMatch = { fg = c.purple400, bold = true },

        -- Cmp
        CmpDocumentation = { fg = c.fg, bg = c.bg_float },
        CmpDocumentationBorder = { fg = c.border_highlight, bg = c.bg_float },
        CmpGhostText = { fg = c.terminal_black },

        CmpItemAbbr = { fg = c.fg, bg = c.none },
        CmpItemAbbrDeprecated = { fg = c.fg_gutter, bg = c.none, strikethrough = true },
        CmpItemAbbrMatch = { fg = c.purple400, bg = c.none },
        CmpItemAbbrMatchFuzzy = { fg = c.purple400, bg = c.none },

        CmpItemMenu = { fg = c.comment, bg = c.none },

        CmpItemKindDefault = { fg = c.fg_darker, bg = c.none },

        CmpItemKindCodeium = { fg = c.green300, bg = c.none },
        CmpItemKindCopilot = { fg = c.green300, bg = c.none },
        CmpItemKindTabNine = { fg = c.green300, bg = c.none },

        -- headlines.nvim
        CodeBlock = { bg = c.bg_darker },

        -- navic
        NavicSeparator = { fg = c.fg, bg = c.none },
        NavicText = { fg = c.fg, bg = c.none },

        AerialNormal = { fg = c.fg, bg = c.none },
        AerialGuide = { fg = c.fg_gutter },
        AerialLine = { link = "LspInlayHint" },

        IndentBlanklineChar = { fg = c.fg_gutter, nocombine = true },
        IndentBlanklineContextChar = { fg = c.purple500, nocombine = true },
        IblIndent = { fg = c.fg_gutter, nocombine = true },
        IblScope = { fg = c.purple500, nocombine = true },

        -- Scrollbar
        ScrollbarHandle = { fg = c.none, bg = c.bg_highlight },

        ScrollbarSearchHandle = { fg = c.orange500, bg = c.bg_highlight },
        ScrollbarSearch = { fg = c.orange500, bg = c.none },

        ScrollbarErrorHandle = { fg = c.error, bg = c.bg_highlight },
        ScrollbarError = { fg = c.error, bg = c.none },

        ScrollbarWarnHandle = { fg = c.warning, bg = c.bg_highlight },
        ScrollbarWarn = { fg = c.warning, bg = c.none },

        ScrollbarInfoHandle = { fg = c.info, bg = c.bg_highlight },
        ScrollbarInfo = { fg = c.info, bg = c.none },

        ScrollbarHintHandle = { fg = c.hint, bg = c.bg_highlight },
        ScrollbarHint = { fg = c.hint, bg = c.none },

        ScrollbarMiscHandle = { fg = c.purple500, bg = c.bg_highlight },
        ScrollbarMisc = { fg = c.purple500, bg = c.none },

        -- Yanky
        YankyPut = { link = "IncSearch" },
        YankyYanked = { link = "IncSearch" },

        -- Lazy
        LazyProgressDone = { bold = true, fg = c.magenta400 },
        LazyProgressTodo = { bold = true, fg = c.fg_gutter },

        -- Notify
        NotifyBackground = { fg = c.fg, bg = c.bg },
        --- Border
        NotifyERRORBorder = { fg = util.darken(c.error, 0.3), bg = options.transparent and c.none or c.bg },
        NotifyWARNBorder = { fg = util.darken(c.warning, 0.3), bg = options.transparent and c.none or c.bg },
        NotifyINFOBorder = { fg = util.darken(c.info, 0.3), bg = options.transparent and c.none or c.bg },
        NotifyDEBUGBorder = { fg = util.darken(c.comment, 0.3), bg = options.transparent and c.none or c.bg },
        NotifyTRACEBorder = { fg = util.darken(c.purple500, 0.3), bg = options.transparent and c.none or c.bg },
        --- Icons
        NotifyERRORIcon = { fg = c.error },
        NotifyWARNIcon = { fg = c.warning },
        NotifyINFOIcon = { fg = c.info },
        NotifyDEBUGIcon = { fg = c.comment },
        NotifyTRACEIcon = { fg = c.purple500 },
        --- Title
        NotifyERRORTitle = { fg = c.error },
        NotifyWARNTitle = { fg = c.warning },
        NotifyINFOTitle = { fg = c.info },
        NotifyDEBUGTitle = { fg = c.comment },
        NotifyTRACETitle = { fg = c.purple500 },
        --- Body
        NotifyERRORBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        NotifyWARNBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        NotifyINFOBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        NotifyDEBUGBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        NotifyTRACEBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },

        -- Mini
        MiniCompletionActiveParameter = { underline = true },

        MiniCursorword = { bg = c.fg_gutter },
        MiniCursorwordCurrent = { bg = c.fg_gutter },

        MiniIndentscopeSymbol = { fg = c.purple400, nocombine = true },
        MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

        MiniJump = { bg = c.magenta400, fg = "#ffffff" },

        MiniJump2dSpot = { fg = c.magenta400, bold = true, nocombine = true },

        MiniStarterCurrent = { nocombine = true },
        MiniStarterFooter = { fg = c.yellow500, italic = true },
        MiniStarterHeader = { fg = c.purple400 },
        MiniStarterInactive = { fg = c.comment, style = options.styles.comments },
        MiniStarterItem = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        MiniStarterItemBullet = { fg = c.border_highlight },
        MiniStarterItemPrefix = { fg = c.warning },
        MiniStarterSection = { fg = c.purple400 },
        MiniStarterQuery = { fg = c.info },

        MiniStatuslineDevinfo = { fg = c.fg_darker, bg = c.bg_highlight },
        MiniStatuslineFileinfo = { fg = c.fg_darker, bg = c.bg_highlight },
        MiniStatuslineFilename = { fg = c.fg_darker, bg = c.fg_gutter },
        MiniStatuslineInactive = { fg = c.purple400, bg = c.bg_statusline },
        MiniStatuslineModeCommand = { fg = c.black700, bg = c.yellow500, bold = true },
        MiniStatuslineModeInsert = { fg = c.black700, bg = c.green500, bold = true },
        MiniStatuslineModeNormal = { fg = c.black700, bg = c.purple400, bold = true },
        MiniStatuslineModeOther = { fg = c.black700, bg = c.green300, bold = true },
        MiniStatuslineModeReplace = { fg = c.black700, bg = c.red500, bold = true },
        MiniStatuslineModeVisual = { fg = c.black700, bg = c.magenta500, bold = true },

        MiniSurround = { bg = c.orange500, fg = c.black700 },

        MiniTablineCurrent = { fg = c.fg, bg = c.fg_gutter },
        MiniTablineFill = { bg = c.black700 },
        MiniTablineHidden = { fg = c.gray700, bg = c.bg_statusline },
        MiniTablineModifiedCurrent = { fg = c.warning, bg = c.fg_gutter },
        MiniTablineModifiedHidden = { bg = c.bg_statusline, fg = util.darken(c.warning, 0.7) },
        MiniTablineModifiedVisible = { fg = c.warning, bg = c.bg_statusline },
        MiniTablineTabpagesection = { bg = c.bg_statusline, fg = c.none },
        MiniTablineVisible = { fg = c.fg, bg = c.bg_statusline },

        MiniTestEmphasis = { bold = true },
        MiniTestFail = { fg = c.red500, bold = true },
        MiniTestPass = { fg = c.green500, bold = true },

        MiniTrailspace = { bg = c.red500 },

        -- Noice
        NoiceCompletionItemKindDefault = { fg = c.fg_darker, bg = c.none },

        TreesitterContext = { bg = util.darken(c.fg_gutter, 0.8) },
        Hlargs = { fg = c.yellow500 },
    }

    -- lsp symbol kind and completion kind highlights
    local kinds = {
        Array = "@punctuation.bracket",
        Boolean = "@boolean",
        Class = "@type",
        Color = "Special",
        Constant = "@constant",
        Constructor = "@constructor",
        Enum = "@lsp.type.enum",
        EnumMember = "@lsp.type.enumMember",
        Event = "Special",
        Field = "@variable.member",
        File = "Normal",
        Folder = "Directory",
        Function = "@function",
        Interface = "@lsp.type.interface",
        Key = "@variable.member",
        Keyword = "@lsp.type.keyword",
        Method = "@function.method",
        Module = "@module",
        Namespace = "@module",
        Null = "@constant.builtin",
        Number = "@number",
        Object = "@constant",
        Operator = "@operator",
        Package = "@module",
        Property = "@property",
        Reference = "@markup.link",
        Snippet = "Conceal",
        String = "@string",
        Struct = "@lsp.type.struct",
        Unit = "@lsp.type.struct",
        Text = "@markup",
        TypeParameter = "@lsp.type.typeParameter",
        Variable = "@variable",
        Value = "@string",
    }

    local kind_groups = { "NavicIcons%s", "Aerial%sIcon", "CmpItemKind%s", "NoiceCompletionItemKind%s" }
    for kind, link in pairs(kinds) do
        local base = "LspKind" .. kind
        theme.highlights[base] = { link = link }
        for _, plugin in pairs(kind_groups) do
            theme.highlights[plugin:format(kind)] = { link = base }
        end
    end

    local markdown_rainbow = { c.purple400, c.yellow500, c.green500, c.green300, c.magenta500, c.purple500 }

    for i, color in ipairs(markdown_rainbow) do
        theme.highlights["@markup.heading." .. i .. ".markdown"] = { fg = color, bold = true }
        theme.highlights["Headline" .. i] = { bg = util.darken(color, 0.05) }
    end
    theme.highlights["Headline"] = { link = "Headline1" }

    if not vim.diagnostic then
        local severity_map = {
            Error = "Error",
            Warn = "Warning",
            Info = "Information",
            Hint = "Hint",
        }
        local types = { "Default", "VirtualText", "Underline" }
        for _, type in ipairs(types) do
            for snew, sold in pairs(severity_map) do
                theme.highlights["LspDiagnostics" .. type .. sold] = {
                    link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
                }
            end
        end
    end

    ---@type table<string, table>
    theme.defer = {}

    if options.hide_inactive_statusline then
        local inactive = { underline = true, bg = c.none, fg = c.bg, sp = c.border }

        -- StatusLineNC
        theme.highlights.StatusLineNC = inactive

        -- LuaLine
        for _, section in ipairs({ "a", "b", "c" }) do
            theme.defer["lualine_" .. section .. "_inactive"] = inactive
        end

        -- mini.statusline
        theme.highlights.MiniStatuslineInactive = inactive
    end

    options.on_highlights(theme.highlights, theme.colors)

    return theme
end

return M
