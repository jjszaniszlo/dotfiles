if exists("current_compiler")
  finish
endif
let current_compiler = "ruff_format"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=uvx\ ruff\ format\ &&\ uvx\ ruff\ check\ --select\ I\ --fix
CompilerSet errorformat=%f:%l:%c:\ %m,%-G%.%#
