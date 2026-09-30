#!/usr/bin/env bash
# Install cpop, its man page and shell completions.
# Usage: ./install.sh [prefix]     (default: ~/.local, or /usr/local when run as root)
#        ./install.sh --uninstall [prefix]
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"

uninstall=0
if [ "${1:-}" = "--uninstall" ]; then uninstall=1; shift; fi

if [ -n "${1:-}" ]; then prefix="$1"
elif [ "$(id -u)" -eq 0 ]; then prefix=/usr/local
else prefix="$HOME/.local"; fi

bin="$prefix/bin/cpop"
man="$prefix/share/man/man1/cpop.1"
bash_c="$prefix/share/bash-completion/completions/cpop"
zsh_c="$prefix/share/zsh/site-functions/_cpop"
fish_c="$prefix/share/fish/vendor_completions.d/cpop.fish"
[ "$prefix" = "$HOME/.local" ] && fish_c="${XDG_CONFIG_HOME:-$HOME/.config}/fish/completions/cpop.fish"

if [ "$uninstall" -eq 1 ]; then
  rm -f "$bin" "$man" "$bash_c" "$zsh_c" "$fish_c"
  echo "removed cpop from $prefix"
  exit 0
fi

install -Dm 755 "$here/cpop" "$bin"
install -Dm 644 "$here/man/cpop.1" "$man"
install -Dm 644 "$here/completions/cpop.bash" "$bash_c"
install -Dm 644 "$here/completions/_cpop" "$zsh_c"
install -Dm 644 "$here/completions/cpop.fish" "$fish_c"

echo "installed:"
printf '  %s\n' "$bin" "$man" "$bash_c" "$zsh_c" "$fish_c"
echo
case ":$PATH:" in *":$prefix/bin:"*) ;; *) echo "note: add $prefix/bin to your PATH" ;; esac
echo "bash: completion loads automatically in new shells (needs the bash-completion package)."
echo "zsh:  add this to ~/.zshrc before compinit:  fpath=($prefix/share/zsh/site-functions \$fpath)"
echo "man:  try 'man cpop' (open a new shell if it isn't found)"
