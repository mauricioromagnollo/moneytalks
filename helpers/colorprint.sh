#!/bin/bash

function colorprint() {
  local colorParam="$1"
  local msg="$2" 
  case $colorParam in 
    "-red") echo -e '\033[31m'$msg'\033[m'  ;;
    "-green") echo -e '\033[32m'$msg'\033[m'  ;;
    "-blue")  echo -e '\033[34m'$msg'\033[m' ;;
    "-white") echo -e '\033[37m'$msg'\033[m'  ;;  
    *) return ;;
  esac
	sleep 1
}
