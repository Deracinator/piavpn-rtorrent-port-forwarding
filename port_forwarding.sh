#!/usr/bin/env bash
#
# Enable port forwarding when using Private Internet Access
#
# Usage:
#  ./port_forwarding.sh

## COLORS
RESET="\e[0m"
BOLD="\e[1m"
RED="\e[31m"
LIGHT_BLUE="\e[94m"
LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_YELLOW="\e[93m"
###

error( )
{
  echo "$@" 1>&2
  exit 1
}

error_and_usage( )
{
  echo "$@" 1>&2
  usage_and_exit 1
}

usage( )
{
  echo "Usage: `dirname $0`/$PROGRAM"
}

usage_and_exit( )
{
  usage
  exit $1
}

version( )
{
  echo "$PROGRAM version $VERSION"
}


port_forward_assignment( )
{
  echo -e "${LIGHT_YELLOW}Loading port forward assignment information...${RESET}"
  if [ "$(uname)" == "Linux" ]; then
    client_id=`head -n 100 /dev/urandom | sha256sum | tr -d " -"`
  fi
  if [ "$(uname)" == "Darwin" ]; then
    client_id=`head -n 100 /dev/urandom | shasum -a 256 | tr -d " -"`
  fi

  json=`curl "http://209.222.18.222:2000/?client_id=$client_id" 2>/dev/null`
  
  if [ "$json" != "" ]; then
    echo -e "${LIGHT_BLUE}Updating ${BOLD}rTorrent ${RESET}${LIGHT_BLUE}port range...${RESET}"
    pure_port=`echo $json | tr -d '{"port":}'`
    sed -i "s/network.port_range.set = .*/network.port_range.set = ${pure_port}-${pure_port}/g" $HOME/.rtorrent.rc
  fi
  
  if [ "$json" == "" ]; then
	  json="${RED}Port forwarding is already activated on this connection, has expired, or you are not connected to a PIA region that supports port forwarding. ${BOLD}WARNING: rTorrent will use last assigned port!${RESET}"
  fi

  echo -e $json
}

EXITCODE=0
PROGRAM=`basename $0`
VERSION=2.1

while test $# -gt 0
do
  case $1 in
  --usage | --help | -h )
    usage_and_exit 0
    ;;
  --version | -v )
    version
    exit 0
    ;;
  *)
    error_and_usage "Unrecognized option: $1"
    ;;
  esac
  shift
done

port_forward_assignment

exit 0
