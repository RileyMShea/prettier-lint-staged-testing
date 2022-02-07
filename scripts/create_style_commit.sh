#!/usr/bin/env sh
# -*- coding: utf-8 -*-

# Make a commit that only contains the style changes.
# This will run formatting across all files and handle all setup for making
# git-blame retain attribution to the creator of functional commits that would
# otherwise be hidden during `git blame`.

PROJECT_DIR=$(git rev-parse --show-toplevel)

git config --local blame.ignorerevsfile .git-blame-ignore-revs &&
    touch "$PROJECT_DIR/.git-blame-ignore-revs" &&
    npm run prettier -- --write . &&
    git add . &&
    git commit -m "Repo-wide style changes." &&
    git log -1 --pretty=%H >>"$PROJECT_DIR/.git-blame-ignore-revs" &&
    echo "Finished adding style commit."
