#!/bin/bash
# This is a template script to install the external project
# You should create a configuration folder and copy this script
# to the folder for actual installation.

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cmake -S $script_dir/../source -B $script_dir/build -DCMAKE_INSTALL_PREFIX=$script_dir/install
cmake --build $script_dir/build --target install