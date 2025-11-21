#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

check_tool() {
  local name="$1"
  local version_cmd="$2"
  if $version_cmd >/dev/null 2>&1; then
    echo "[OK] $name present: $($version_cmd | head -n1)"
    return 0
  else
    echo "[MISSING] $name"
    return 1
  fi
}

main() {
  check_tool "brew" "brew -v" ||
    echo "Install Homebrew: https://brew.sh"
  check_tool "task" "task -v" ||
    echo "Install Task: brew install go-task/tap/go-task"
  [[ -f Taskfile.yml ]] || task --init ||
    echo "Manually create Taskfile.yml"
}
main "$@"
