#!/usr/bin/env bash

set -eu
source orm.sh

ORM_DB=test.db

query "SELECT ?1, ?2" "'param1" '"param2'
query "SELECT ?1, ?2" "1+1" "'1+1"
query "SELECT ?1 as hey, ?2" $'\t\t' 'hello

world\a\n'
