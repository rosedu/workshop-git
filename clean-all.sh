#!/bin/sh

clean_branch()
{
    if ! git rev-parse --verify "$1" > /dev/null 2>&1; then
        return
    fi
    git checkout "$1"
    git merge --abort > /dev/null 2>&1
    git rebase --abort > /dev/null 2>&1
    git cherry-pick --abort > /dev/null 2>&1
    git reset --hard HEAD
    git clean -d -f
}

git merge --abort > /dev/null 2>&1
git rebase --abort > /dev/null 2>&1
git cherry-pick --abort > /dev/null 2>&1
git reset --hard HEAD

clean_branch test
clean_branch scripts
clean_branch base
clean_branch main
