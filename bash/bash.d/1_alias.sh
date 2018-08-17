#!/usr/bin/env bash

pail_cat() {
    check_num_args 1 "$@"
    hdfs dfs -text "$1" | sed 's/^...../0a/' | xxd -p -r
}

get_yarn_logs() {
    check_num_args 1 "$@"
    local -r appId="$1"
    yarn logs -applicationId "$appId" > "$appId".log
}
