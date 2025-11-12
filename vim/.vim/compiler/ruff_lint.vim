if exists("current_compiler")
  finish
endif
let current_compiler = "ruff_lint"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=uvx\ ruff\ check\ --output-format=concise
CompilerSet errorformat=%f:%l:%c:\ %m,%-G%.%#
