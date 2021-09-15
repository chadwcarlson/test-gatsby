#!/usr/bin/env bash

set -e

git add .
STAGED_UPDATES=$(git diff --cached)
if [ ${#STAGED_UPDATES} -gt 0 ]; then
    git commit -m $1
else
    echo "No updates found. Skipping."
fi
