#!/bin/env bash

#Create pre-req directories
if [[ ! -d "crossCompilers" ]]; then mkdir crossCompilers; fi
if [[ ! -d "src" ]]; then mkdir src; fi

# For every arch wanted  

grep -v '^#' arch.txt | while read -r line; do

    # Sanitize input by only allowing alpha-numeric charachters
    line=${line//[^a-zA-Z0-9_]/}

    #Make sure it doesnt exist before (re)making it
    if [[ ! -f crossCompilers/dockcross-$line ]]; then
        docker run --rm dockcross/$(echo $line) > crossCompilers/dockcross-$(echo $line)
        chmod +x crossCompilers/dockcross-$line
    fi

    # Actually compile the shit
    ./crossCompilers/dockcross-$(echo $line) bash -c '$CXX src/main.cpp src/cubiomes/*.c -O2 -static -static-libgcc -static-libstdc++ -lpthread -lm'

done
