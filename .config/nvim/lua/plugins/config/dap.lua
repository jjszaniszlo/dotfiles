local M = {}

local dap_setup = {
	["lldb-dap"] = function()
		if not vim.fn.executable("lldb-vscode") == 1 then
			require("core.utils").vim_echo("[dap] lldb-dap is unavailable!")
			return
		end

		local dap = require("dap")
		dap.adapters.lldb = {
			type = "executable",
			command = vim.fn.exepath("lldb-vscode"),
			name = "lldb",
		}

		dap.configurations.c = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
				env = function()
					local variables = {}
					for k, v in pairs(vim.fn.environ()) do
						table.insert(variables, string.format("%s=%s", k, v))
					end
					return variables
				end,
			},
		}
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.zig = dap.configurations.c
	end,
}

function M.init()
	dap_setup["lldb-dap"]()
end

M.dap_ui = {}

return M
