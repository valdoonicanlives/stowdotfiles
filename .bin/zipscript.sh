#!/bin/bash

# Checking if a directory path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [directory path]"
    exit 1
fi

DIRECTORY=$1
ZIPFILE='output.zip'

# Zipping the specified directory
zip -er $ZIPFILE $DIRECTORY
