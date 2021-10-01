#!/usr/bin/env bash

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

if [ $# -ne 2 ] ; then
    /bin/echo -e "${GREEN}Usage:${NC} owndir.sh {user} {dir}"
    exit 1
fi

function checkUser {
    if id "$1" &>/dev/null ; then
        :
    else
        /bin/echo -e "${RED}Error!${NC} No such user: ${RED}$1${NC}"
        exit 2
    fi
}

function checkDir {
    if [ -d "$1" ]; then
        :
    else
        /bin/echo -e "${RED}Error!${NC} No such directory: ${RED}$1${NC}"
        exit 3
    fi
}

function ownDir {
    if /usr/bin/chown $1 $2 ; then
        /bin/echo -e "${GREEN}Owner changed.${NC}"
    else
       /bin/echo -e "${RED}Error!${NC} Could not change ownership on ${RED}$2${NC}"
       exit 4
    fi
}

checkUser $1
checkDir $2
ownDir $1 $2