# Git Workshop

This is a practical workshop consisting of common Git-related actions.

## Inspect Repository

1. See the current branch and status:

   ```console
   git status
   ```

1. See local branches:

   ```console
   git branch
   ```

1. See local and remote branches:

   ```console
   git branch -a
   ```

1. heck out remote branches locally:

   ```console
   git branch base origin/base
   git branch scripts origin/base
   ```

1. Show verbose information about branches:

   ```console
   git branch -vv
   git branch -vv -a
   ```

1. Check out to a local branch:

   ```console
   git checkout base
   ls
   git checkout scripts
   ls
   git checkout main
   ```

1. List contents of another branch without checking out:

   ```console
   git ls-tree scripts
   git ls-tree scripts:c-fs
   git ls-tree scripts:c-fs/rootfs
   git ls-tree scripts --name-only
   git ls-tree scripts:c-fs --name-only
   git ls-tree scripts:c-fs/rootfs --name-only
   git ls-tree -r scripts --name-only
   ```

1. Show contents of file on another branch without checking out:

   ```console
   git show scripts:c-fs/build.qemu.x86_64
   git show scripts:c-fs/README.scripts.md
   ```

### Do It Yourself.

1. Do more listing.
   Try out the other commands [here](https://graphite.dev/guides/git-list-all-files).

1. Check out the `test` branch from the remote `origin/test` branch.
   List contents, check out the branch, get back to the `main` branch.

## Inspect Commit History

1. Make sure you are on the `main` branch:

   ```console
   git checkout main
   git status
   ```

1. List commit history:

   ```console
   git log
   git log base
   git log --oneline base
   ```

1. Show top commit contents:

   ```console
   git show
   git show HEAD
   ```

1. Show commit contents by commit ID:

   ```console
   git show 1a02ae3
   ```

1. Only show actual contents, no metadata:

   ```console
   git show --pretty="" 1a02ae3
   ```

1. Only show modified files:

   ```console
   git show --pretty="" --name-only 1a02ae3
   ```

1. Show commits that modified a file:

   ```console
   git checkout base
   git blame README.md
   git checkout main
   ```

1. Show commits that modified a path:

   ```console
   git log scripts -- README.md
   git log scripts -- c-fs
   ```

1. Show difference between two commits / references:

   ```console
   git diff base scripts
   ```

1. Show commit difference between two references:

   ``console
   git cherry -v main scripts
   git cherry -v scripts main
   git cherry -v main d379011
   git cherry -v d379011 main
   ```

### Do It Yourself

1. How are the three branches (`base`, `scripts`, `test`) constructed?
   Which is constructed on top of the other?

1. Do more history inspection.

## Configure Git

## Create Commits

Also git add -i

## Reset Changes

## Create Branches

## Amending a Commit

## Edit Commit History

## Stashing Changes

## Common Situations

Amending a commit instead of creating a new one.

git add . ; something needs to be left out

you added an extra something in a commit

need to reset author
