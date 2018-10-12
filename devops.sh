#!/bin/bash

export BIN_DIR="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
export INCLUDES_DIR="${BIN_DIR}/includes"
export TEMPLATES_DIR="${BIN_DIR}/templates"

source ${INCLUDES_DIR}/system.sh
source ${INCLUDES_DIR}/init.sh
source ${INCLUDES_DIR}/docker.sh
source ${INCLUDES_DIR}/server.sh

##
# Initializing devops
##
if [ "$1" = "init" ]; then
    $(_copy_files ${TEMPLATES_DIR})
    $(_link_files ${BIN_DIR})

##
# Updating devops
##
elif [ "$1" = "update" ]; then
    $(composer update awsmug/wp-devops)
    $(_link_files ${BIN_DIR})

##
# Starting server
##
elif [ "$1" = "up" ]; then
    $(_start)

##
# Stopping server
##
elif [ "$1" = "down" ]; then
    $(_stop)

##
# Help on wrong usage
##
else
    echo "Usage: $(basename $0) <init|update|up|down>"
fi