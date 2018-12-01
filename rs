#!/usr/bin/env bash

clear
echo "Compiling & Running: $1.rs"
echo "----------------------------"
rustc rust/day_$1.rs && ./day_$1 && rm day_$1
