#!/bin/bash

# Create pre-req directories
if [[ ! -d "src" ]]; then mkdir src; fi
if [[ ! -d "out" ]]; then mkdir out; fi

# For every arch wanted
rm -vf out/main.*
grep -v '^#' arch.txt | while read -r line; do
    # Sanitize input by only allowing alpha-numeric charachters
    line=${line//[^a-zA-Z0-9-]/}

    # Determine weather or not it should be compiled staticly
    case "$line" in
        osx*|darwin*|x86_64h|*-apple-darwin)
            staticFlags="";;
        *)
            staticFlags="-static -static-libgcc -static-libstdc++";;
    esac

    # Set compiler
    case "$line" in
        aarch64-apple-darwin|*AArch64)
            CXX="/usr/osxcross/bin/aarch64-apple-darwin20.4-clang++";;
        arm-linux-gnueabi|arm|armv5)
            CXX="arm-linux-gnueabi-g++";;
        *)
            CXX="c++";;
    esac

    $compileFlags="-O2 -lpthread -lm"

    echo "Compiling for $line"
    docker run --rm -v $(pwd):/workdir -e CROSS_TRIPLE=$line nyancattw1/crossbuild $CXX src/main.cpp src/cubiomes/*.c $staticFlags $compileFlags -o out/main.$line
    file out/main.$line

done
