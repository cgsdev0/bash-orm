#!/usr/bin/env bash

function dog() {
  cat
}

function query() {
  function _query() {
    local QUERY
    QUERY="$1"
    shift
    printf ".parameter init\n"
    INDEX=1
    for arg in "$@"; do
      : "${arg//\\/\\\\\\\\}"
      : "${_//$'\t'/    }"
      : "${_//\"/\\\"}"
      : "${_//\'/\\\'}"
      : "${_//$'\n'/\\\\n}"
      if [[ "$_" =~ "'" ]]; then
        printf ".parameter set ?%d \"%s\"\n" $INDEX "$_"
      else
        printf ".parameter set ?%d \"'%s'\"\n" $INDEX "$_"
      fi
      ((INDEX++))
    done
    printf "%s\n" "$QUERY";
  }
  sqlite3 -separator $'\t' $ORM_DB < <(_query "$@")
}

export -f query
