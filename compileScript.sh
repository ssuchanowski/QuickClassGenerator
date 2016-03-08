#!/bin/bash

# if [[ $UID != 0 ]]; then
#     echo "[ERROR] Please start the script with sudo!"
#     echo "Required to move script to /usr/bin"
#     exit 1
# fi

if [ ! -f main.swift ]; then
    echo "[ERORR] Must be run from script directory!"
    exit 1
fi

execFileName="qc"
swiftc -o $execFileName main.swift sources/*

path="$HOME/.scripts/SwiftClassGenerator"
mkdir -p $path
cp -R templates $path
mv $execFileName /usr/local/bin
