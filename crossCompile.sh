#!/bin/env bash

#Create pre-req directories
if [[ ! -d "crossCompilers" ]]; then mkdir crossCompilers; fi
if [[ ! -d "src" ]]; then mkdir src; fi

# For every arch wanted  

grep -v '^#' arch.txt | while read -r line; do

    # Sanitize input by only allowing alpha-numeric charachters
    sanitizedLine=${line//[^a-zA-Z0-9-]/}

    #Make sure it doesnt exist before (re)making it
    if [[ ! -f crossCompilers/dockcross-$sanitizedLine ]]; then
        echo "Downloading helper script"
        docker run --rm dockcross/$sanitizedLine > crossCompilers/dockcross-$sanitizedLine
        chmod +x crossCompilers/dockcross-$sanitizedLine
    fi

    # Actually compile the shit
    echo "Compiling for $line"
    ./crossCompilers/dockcross-$line bash -c '$CXX src/main.cpp src/cubiomes/*.c -O2 -static -static-libgcc -static-libstdc++ -lpthread -lm'

done
