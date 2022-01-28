#!/bin/env bash

#Create pre-req directories
if [[ ! -d "crossCompilers" ]]; then mkdir crossCompilers; fi
if [[ ! -d "src" ]]; then mkdir src; fi

# For every arch wanted  

grep -v '^#' arch.txt | while read -r line; do

    # Make sure it doesnt exist before (re)making it
    if [[ ! -f crossCompilers/dockcross-$line ]]; then
        #echo "It doesnt exist"
        docker run --rm dockcross/'$(echo $line)' > "crossCompilers/dockcross-''$(echo $line)'"
        chmod +x crossCompilers/dockcross-$line
    fi

    # Actually compile the shit
    ./dockcross-$line bash -c '$CXX ./src/main.cpp ./src/cubiomes/*.c -O2 -static -static-libgcc -static-libstdc++ -lpthread -lm -o $line'

done
