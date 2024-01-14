#!/bin/sh
echo -ne '\033c\033]0;YSpace\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/YSpace.x86_64" "$@"
