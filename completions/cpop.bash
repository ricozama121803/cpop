# bash completion for cpop
_cpop() {
  local cur="${COMP_WORDS[COMP_CWORD]}" i=1
  local flags="-t --table -m --markdown -j --json -p --pretty -c --code -r --raw -q --quiet -h --help -V --version"

  # Skip over cpop's own flags to find where the wrapped command starts.
  while [ "$i" -lt "$COMP_CWORD" ] && [[ "${COMP_WORDS[i]}" == -* ]]; do
    if [ "${COMP_WORDS[i]}" = "--" ]; then i=$((i + 1)); break; fi
    i=$((i + 1))
  done

  if [ "$i" -ge "$COMP_CWORD" ]; then
    if [[ "$cur" == -* ]]; then
      mapfile -t COMPREPLY < <(compgen -W "$flags" -- "$cur")
    else
      mapfile -t COMPREPLY < <(compgen -c -- "$cur")   # command names
    fi
    return 0
  fi

  # Past the command name: complete it the way the command itself would.
  if declare -F _command_offset >/dev/null 2>&1; then
    _command_offset "$i"
  else
    mapfile -t COMPREPLY < <(compgen -f -- "$cur")
  fi
}
complete -F _cpop cpop
