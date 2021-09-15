#!/usr/bin/env bash

set -e

yarn upgrade

git add .
STAGED_UPDATES=$(git diff --cached)
if [ ${#STAGED_UPDATES} -gt 0 ]; then
    git commit -m "Update dependencies."
else
    echo "No dependency updates found. Skipping."
fi
