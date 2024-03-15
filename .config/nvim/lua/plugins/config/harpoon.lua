local harpoon = require("harpoon")
harpoon:setup()

local function harpoon_desc(str)
	return "[harpoon]: " .. str
end

local harpoon_maps = {
	["<leader>ha"] = {
		function()
			harpoon:list():append()
		end,
		harpoon_desc("Add file to list"),
	},
	["<leader>hh"] = {
		function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end,
		harpoon_desc("Toggle quick menu"),
	},
	["<leader>hp"] = {
		function()
			harpoon:list():prev()
		end,
		harpoon_desc("Goto previous buffer"),
	},
	["<leader>hn"] = {
		function()
			harpoon:list():next()
		end,
		harpoon_desc("Goto next buffer"),
	},
}

require("core.utils").load_mappings(harpoon_maps)
