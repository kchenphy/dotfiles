#!/usr/bin/env bash

current_script_dir() {
    ( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
}

die() {
    local -r message=$1 exit_code="${2:-1}"
    printf "%s (status code: %d)\n" "$message" "$exit_code" >&2
    print_stack_trace >&2
}

check_num_args() {
    local -ri num_args=$1
    shift
    if [[ $# -ne "$num_args" ]]; then
	die "number of arguments for ${FUNCNAME[1]} is $# (expected $num_args)"
    fi
}

test_check_num_args() {
    check_num_args 2 "$@"
}

print_stack_trace() {
    local context frame=0
    while true; do
	context=$(caller ${frame})
	if [ -z "${context}" ]; then
	    break
	fi
	read -r -a array <<< "${context}"
	printf "  at %s (%s:%d)\n"  "${array[1]}" "${array[2]}" "${array[0]}"
	(( ++frame ))
    done
}
