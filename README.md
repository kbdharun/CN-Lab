# CN-Lab

This repository contains the programs that I worked out in the Computer Networks Lab.

## Packages

The experiments in this repository require specific versions of `ns`, `nam`, and `xgraph`.

## Installation

For Ubuntu, `ns2` can be installed with `sudo apt install ns2` commands and the specific versions of `nam` and `xgraph` can be installed via the DEB files [found here](https://github.com/kbdharun/CN-Lab/releases/tag/nam) (i.e `sudo apt install ./<path/to/file.deb>`) [Note: `awk` comes preinstalled in Ubuntu and other Linux distributions so a separate installation isn't necessary].

For ease of use, I have created a [lightweight container image](https://github.com/kbdharun/CN-Lab/pkgs/container/cn-lab-image) with the packages preinstalled. You can install it in [Distrobox](https://github.com/89luca89/distrobox) with the command `distrobox create -i ghcr.io/kbdharun/cn-lab-image:latest -n ns` and use it with the command `distrobox enter ns`.

Now you are all set, good luck networking.

## Commands Cheatsheet

- Run/start a simulation in Network Simulator:

`ns <file>.tcl`

- Visualize the simulation in Network Animator:

`nam <file>.nam`

- Perform analysis on the generated trace file:

`awk -f <analysis-file>.awk <file>.tr`

- Plot x-y data plotter graphs:

`xgraph <file1 file2 ...>`
