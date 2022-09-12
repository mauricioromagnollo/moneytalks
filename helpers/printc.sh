#!/bin/bash

function printc() {
  local colorParam="$1"
  local message="$2"

  if [[ (! -z "$colorParam") && (! -z "$message") ]]; then 
    case $colorParam in 
      "-red") echo -e '\033[31m'$message'\033[m'    ;;
      "-green") echo -e '\033[32m'$message'\033[m'  ;;
      "-blue")  echo -e '\033[34m'$message'\033[m'  ;;
      "-white") echo -e '\033[37m'$message'\033[m'  ;;  
      *) return ;;
    esac
    sleep 1
  fi
}