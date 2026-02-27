
#   _   _             _
#  | | | | ___   ___ | | _____
#  | |_| |/ _ \ / _ \| |/ / __|
#  |  _  | (_) | (_) |   <\__ \
#  |_| |_|\___/ \___/|_|\_\___/
#

chpwd() {
  lsd --config-file $HOME/.config/lsd/hook.yaml
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
