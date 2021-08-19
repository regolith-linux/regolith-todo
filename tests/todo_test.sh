#!/bin/bash

set -Eeux -o pipefail

echo ${BASH_SOURCE[0]}

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
cd "${SCRIPT_DIR}"

# Make sure we can handle 0 with leading space
PATH="$(pwd)/fixtures/todo/first:${PATH}"
OUTPUT=$(../scripts/todo)
echo "${OUTPUT}" | grep -q -P '\>\s{2}0\<'

# Make sure we can handle 1 with leading space
PATH="$(pwd)/fixtures/todo/second:${PATH}"
OUTPUT=$(../scripts/todo)
echo "${OUTPUT}" | grep -q -P '\>\s{2}1\<'

# Make sure we can handle 22 without leading space
PATH="$(pwd)/fixtures/todo/third:${PATH}"
OUTPUT=$(../scripts/todo)
echo "${OUTPUT}" | grep -q -P '\>\s22\<'

# Make sure we can handle 122 without leading space
PATH="$(pwd)/fixtures/todo/fourth:${PATH}"
OUTPUT=$(../scripts/todo)
echo "${OUTPUT}" | grep -q -P '\>\s122\<'

# Make sure we can handle 12 with --uncomplete
PATH="$(pwd)/fixtures/todo/fifth:${PATH}"
OUTPUT=$(filter=true ../scripts/todo)
echo "${OUTPUT}" | grep -q -P '\>\s12\<'

# Make sure button command is right
PATH="$(pwd)/fixtures/todo/fifth:${PATH}"
OUTPUT=$(filter=false button=1 ../scripts/todo)
echo "${OUTPUT}" | grep -q -P "i3-msg called with -q exec /usr/bin/gnome-terminal --class=floating_window -- td --interactive"

# Make sure button command is right with --uncomplete
PATH="$(pwd)/fixtures/todo/fifth:${PATH}"
OUTPUT=$(filter=true button=1 ../scripts/todo)
echo "${OUTPUT}" | grep -q -P "i3-msg called with -q exec /usr/bin/gnome-terminal --class=floating_window -- td --interactive --uncompleted"
