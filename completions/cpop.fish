# fish completion for cpop
complete -c cpop -s t -l table    -d 'Copy as an aligned table'
complete -c cpop -s m -l markdown -d 'Copy as a Markdown table'
complete -c cpop -s j -l json     -d 'Copy as JSON'
complete -c cpop -s p -l pretty   -d 'Pretty-print JSON, otherwise a table'
complete -c cpop -s c -l code     -d 'Wrap in a Markdown code fence'
complete -c cpop -s r -l raw      -d 'Keep ANSI colors in the copy'
complete -c cpop -s q -l quiet    -d 'Hide the banner'
complete -c cpop -s h -l help     -d 'Show help'
complete -c cpop -s V -l version  -d 'Show version'
complete -c cpop -x -a "(__fish_complete_subcommand)"
