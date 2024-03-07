local Utils = {}

function Utils.vim_echo(str)
    vim.cmd "redraw"
    vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

function Utils.load_mappings(mappings, opts)
    local opts = opts or {}

    if type(mappings) == "string" then
        mappings = require("core.mappings")[mappings]
        assert(mappings and type(mappings) == "table", "invalid map")
    end

    for lhs, mapping in pairs(mappings) do
        local rhs = mapping.rhs or mapping[1]
        local mode = mapping.mode or 'n'

        local o = {
            desc = mapping.desc or mapping[2],
            buffer = mapping.buffer or opts.buffer,
            silent = mapping.silent or opts.silent,
            noremap = mapping.noremap or opts.noremap,
            nowait = mapping.nowait or opts.nowait,
            expr = mapping.expr or opts.expr,
        }

        vim.keymap.set(mode, lhs, rhs, o)
    end
end

function Utils.create_handlers_table(capabilities)
    local function filename(path)
        return path:match("^.+/(.+)%..+$")
    end

    local lsp_config_files = vim.api.nvim_get_runtime_file("lua/lsp/*.lua", true)
    local handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
            }
        end,
    }

    for _, name in pairs(lsp_config_files) do
        local name = filename(name)
        local config_table = require("lsp." .. name)

        config_table.capabilities = capabilities

        handlers[name] = function()
            require("lspconfig")[name].setup(config_table)
        end
    end

    return handlers
end

return Utils
