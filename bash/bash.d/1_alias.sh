#!/usr/bin/env bash

pail_cat() {
    check_num_args 1 "$@"
    hdfs dfs -text "$1" | sed 's/^...../0a/' | xxd -p -r
}

get_yarn_logs() {
    check_num_args 1 "$@"
    local -r app_id="$1"
    yarn logs -applicationId "$app_id" > "$app_id".log
}

alias hdfs_delete_now="hdfs dfs -rm -r -skipTrash"

grep_exception() {
    grep -i Exception "$1" | sort | uniq 
}

yarn_kill() {
    check_num_args 1 "$@"
    local -r app_id="$1"
    yarn application -kill "$app_id"
}

alias hdfs_quota="hadoop fs -count -q -v"
