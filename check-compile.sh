#!/bin/sh
set -e
cd "$(dirname "$0")"
cd src
for f in *.sv; do
  verilator --cc "$f"
done
