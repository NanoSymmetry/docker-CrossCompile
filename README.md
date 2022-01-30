# docker-CrossCompile

## Prerequisites
- Windows
    - [Docker](https://docs.docker.com/desktop/windows/install/)
    - [WSL2](https://docs.microsoft.com/en-us/windows/wsl/install)
- Linux
    - [Docker](https://docs.docker.com/engine/install/)

## Usage
- Edit arch.txt to include the architechtures that you want.
    - Available architechtures: https://github.com/e666666/crossbuild#supported-targets
- `chmod +x crossCompile.sh`
- `./crossCompile.sh`

## TODO:
- [x] Make it actually work
- [x] Add instructions
- [x] Add pre-reqs
- [X] Support MacOS AArch64
- [ ] Allow arguments to be changed

## Technology used
- [Docker](https://www.docker.com/)
- [crossbuild](https://github.com/e666666/crossbuild)
