local M = {}

local c_v_code = vim.api.nvim_replace_termcodes("<c-v>", true, true, true)
local c_s_code = vim.api.nvim_replace_termcodes("<c-s>", true, true, true)

local vim_mode_mappings = {
    n = { "NORMAL", "Cursor" },
    v = { "VISUAL", "DiffAdd" },
    V = { "VISUAL-L", "DiffAdd" },
    [c_v_code] = { "VISUAL-B", "DiffAdd" },
    s = { "SELECT", "DiffAdd" },
    S = { "SELELCT-L", "DiffAdd" },
    [c_s_code] = { "SELECT-B", "DiffAdd" },
    i = { "INSERT", "DiffChange" },
    R = { "REPLACE", "DiffDelete" },
    c = { "COMMAND", "DiffText" },
    r = { "PROMPT", "IncSearch" },
    ["!"] = { "SHELL", "IncSearch" },
    ["t"] = { "TERMINAL", "IncSearch" },
}

function M.currentState()
    local mode = vim_mode_mappings[vim.fn.mode()]
    return string.format("%%#%s# ", mode[2]) .. mode[1] .. " %*"
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("JUI_statusline", {}),
    pattern = "*",
    callback = function()
        local c_win = vim.api.nvim_get_current_win()
        vim.wo[c_win].statusline = "%!v:lua.JUI_statusline.currentState()"
    end,
    desc = "Status Line",
})

return M
