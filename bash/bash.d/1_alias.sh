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

alias hdfs_delete_now="hdfs dfs -rm -r -skipTrash"

grep_exception() {
    local -r logFile="$1"
    grep -i Exception ${logFile} | sort | uniq 
}
