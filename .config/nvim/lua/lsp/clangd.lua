return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--cross-file-rename",
		"--header-insertion=iwyu",
	},
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = true,
	},
}
