#!/bin/bash

set -eu

if [ -z "${URL:-}" ]; then
	[ -n "$1" ] && URL="$1"
fi

get_expire_date() {
	LANG= curl -vsS "$URL" 2>&1  | grep expire | sed -e 's/.*date: //'
}

current_date() {
	date +%s
}

main() {
	local cur="$(current_date)"	
	local exp="$(date +%s -ud "$(get_expire_date)")"
	local diff="$((exp-cur))"
	echo diff is $diff
	[ "$diff" -gt "${MAX_DIFF:-604800}" ]
}

main
