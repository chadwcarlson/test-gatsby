#!/usr/bin/env bash

set -e

git clone https://github.com/chadwcarlson/common-actions.git
ls -a 
ls common-actions
cp -R common-actions/* .
cp -R .platform/template/files/ .
ls -a 
pwd
rm -rf common-actions
git add .

# git status

# rsync -aP .platform/template/files/ .
# git add CODE_OF_CONDUCT.md
# git status
# git add .

# git status
# git branch
STAGED_UPDATES=$(git diff --cached)
if [ ${#STAGED_UPDATES} -gt 0 ]; then
    git commit -m "Upstream updates."
else
    echo "No upstream updates found. Skipping."
fi
