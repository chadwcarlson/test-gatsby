#!/usr/bin/env bash

set -e

# Fetch upstream.
echo "- Retrieving upstream."
git remote add upstream $UPSTREAM_REMOTE       
git fetch --all
git merge --allow-unrelated-histories -X ours upstream/master

# Modify upstream.
echo "- Modifying upstream."
rm package-lock.json
mv README.md README_UPSTREAM.md

# Add template files.
echo "- Adding common template files."
cp -R .platform/template/files/. .
# mv .github .something

# Stage and commit.
git add .
STAGED_UPDATES=$(git diff --cached)
if [ ${#STAGED_UPDATES} -gt 0 ]; then
    git commit -m "Apply upstream updates."
else
    echo "No upstream updates found. Skipping."
fi
