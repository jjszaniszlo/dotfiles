vim.g.zig_fmt_autosave = 0

return {
	cmd = { "/Users/jjszaniszlo/Source Code/zls-0.12.0/zig-out/bin/zls" },
	settings = {
		zls = {
			semantic_tokens = "full",
			warn_style = true,
			highlight_global_var_declarations = true,
			enable_snippets = true,
			enable_autofix = true,
			enable_inlay_hints = false,
			inlay_hints_show_builtin = true,
			inlay_hints_exclude_single_argument = true,
			inlay_hints_hide_redundant_param_names = true,
			inlay_hints_hide_redundant_param_names_last_token = true,
			skip_std_references = true,
			record_session = true,
		},
	},
}
