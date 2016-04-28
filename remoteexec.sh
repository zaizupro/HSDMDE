#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo 
    echo "    [**USAGE**]: datscript PROJECT HOST_USER HOST_IP"
    echo "    [**EXIT***]"
    echo
    exit -1
fi

SESSION=BUILD
PROJECT=$1
WINDOW=${PROJECT}
PANE=

BUILDHOSTUSER=$2
BUILDHOSTIP=$3
BUILDHOSTADDR=${BUILDHOSTUSER}"@"${BUILDHOSTIP}

REMOTECOMMAND="remek"

tmux has-session -t ${SESSION}
if [ $? != 0 ]; then
    tmux new-session -s ${SESSION} -n ${PROJECT} -d "ifconfig"
fi

ssh ${BUILDHOSTADDR} "tmux send-keys -t ${SESSION}:${WINDOW}.${PANE} '${REMOTECOMMAND}' Enter"
