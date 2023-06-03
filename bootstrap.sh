#!/bin/sh

# This script will install all required software, packages and tools on a new machine, to my liking.
# It will configure them as needed, and setup all program configurations and settings.
# This script can be run on any machine, on any OS, and should act accordingly.

set -e # stop on first error

# Detect OS
echo "Detected OS:"
case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)  echo "MACOS" ;; 
  linux*)   echo "LINUX" ;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

