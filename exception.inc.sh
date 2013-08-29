#!/bin/bash

# Script from: http://blog.doylenet.net/?p=275
# Please contact author via here for license info: http://blog.doylenet.net/?page_id=43
# Multiple attempts to contact original developer. As such, uploading until receipt of 
# Notice to take down.

function try(){
    CAUGHT=false
    eval "$@"
    return $?
}
 
function catch(){
    # Arguments
    local RETURN="$?"
    CAUGHT=false
    # Cut up the comma passed exit codes into space separated
    local EXITS=`echo "$1" | sed 's/,/ /g'`
    local EXIT=
    # Check against each exit
    for EXIT in $EXITS; do
        if [ $EXIT = $RETURN ]; then
            CAUGHT=true
            break
        fi
    done
    # Work out if we caught the exception
    if $CAUGHT; then
        echo "Caught exception $RETURN"
        return 0
    else
        echo "Uncaught exception $RETURN, expecting $EXITS"
        return $RETURN
    fi
}
