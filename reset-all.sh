#!/bin/sh

reset_branch_to_remote()
{
    git checkout "$1"
    git reset --hard "$2"/"$1"
}

./clean-all.sh

reset_branch_to_remote test origin
reset_branch_to_remote scripts origin
reset_branch_to_remote base origin
reset_branch_to_remote main origin
