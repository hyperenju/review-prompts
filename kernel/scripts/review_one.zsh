# zsh helper for running a single Codex kernel review.
#
# Usage after sourcing:
#   kreview1 <commit>
#   kreview1 /path/to/linux <commit>

if [[ -z "${KREVIEW1_SCRIPT_DIR:-}" ]]; then
    typeset -g KREVIEW1_SCRIPT_DIR="${${(%):-%N}:A:h}"
fi

function kreview1() {
    if [[ $# -ne 1 && $# -ne 2 ]]; then
        print -u2 "usage: kreview1 [linux_path] <commit>"
        return 1
    fi

    local linux_dir
    local sha

    if [[ $# -eq 1 ]]; then
        linux_dir="${PWD:A}"
        sha="$1"
    else
        linux_dir="$1"
        sha="$2"
    fi

    "${KREVIEW1_SCRIPT_DIR}/review_one.sh" --cli codex --linux "${linux_dir}" "${sha}"
}
