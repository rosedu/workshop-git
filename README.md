# Git Workshop

This is a practical workshop consisting of common Git-related actions.
It is based on the [`unikraft/catalog-core` repository](https://github.com/unikraft/catalog-core), giving us a concrete Git repository to screw up ... hmmmm ... to do wonderful amazing great things to.

First of all, clone the [repository](https://github.com/rosedu/workshop-git):

```console
git clone https://github.com/rosedu/workshop-git
cd workshop-git/
```

And let's get going! 🚀

> [!NOTE]
> If, at any point in time, you miss a command, or something bad simply happened, reset the environment by running:
>
> ```console
> ./reset-all.sh
> ```

> [!IMPORTANT]
> We re recommend you write all commands below by hand, i.e. without using copy & paste.
> This will get you better accustomed to Git and Git commands.

## Inspect Repository

1. See the current branch and status:

   ```console
   git status
   ```

   Git commands happen in a repository.
   A **repository** is the collection of data and metadata that you use to manage content, typically code.

   All Git commands start with `git`.
   They are then followed by arguments.
   The `status` argument is the argument of choice to get the state of the repository and the current branch.
   `git status` is probably the most used Git command, due to it providing information on the repository state.

1. See local branches:

   ```console
   git branch
   ```

   A **branch** is a specific setup and evolution of the repository.
   A repository consists of multiple branches, among which you can switch.

1. See local and remote branches:

   ```console
   git branch -a
   ```

   A local repository is typically a **clone** of a remote repository.
   It can also be connected to multiple remote repositories.
   All repositories have branches, that may or may not be in sync with each other.

1. Make remote branches available locally:

   ```console
   git branch base origin/base
   git branch scripts origin/scripts
   ```

   A local branch can be created to "follow" a remote branch.
   Note that changes to local branches are not implicitly made available to remote branches or viceversa.
   You must use specific actions to sync them: `push` and `pull`.
   We will not cover branch syncing in this workshop.

1. See local branches again.
   Note the difference (green color, `*` - *star* character) between the current branch and other local branches:

   ```console
   git branch
   ```

1. Show verbose information about branches:

   ```console
   git branch -v
   git branch -vv
   git branch -vv -a
   ```

1. Check out to a local branch:

   ```console
   git checkout base
   git branch
   git status
   ls
   git checkout scripts
   git branch
   git status
   ls
   git checkout main
   git branch
   git status
   ls
   ```

   Switching among branches is also called checking out.

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

   The construct `scripts:c-fs` means the `c-fs` filesystem entry in the `scripts` branch.
   Similarly, the construct `scripts:c-fs/rootfs` means the `c-fs/rootfs` filesystem entry in the `scripts` branch.

1. Show contents of a file on another branch without checking out:

   ```console
   git show scripts:c-fs/build.qemu.x86_64
   git show scripts:c-fs/README.scripts.md
   ```

### Do It Yourself

1. Do more listing.
   Try out the other commands [here](https://graphite.dev/guides/git-list-all-files).

1. Check out (switch to) the `test` branch from the remote `origin/test` branch.
   List contents, get back to the `main` branch.

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
   git log --pretty=fuller
   ```

   A **commit** is an individual collection of changes to the repository.
   It represents a given state of the repo.
   You can compare a commit to a save file or checkpoint in a video game.

   A commit consists of actual changes to the files in the repository and metadata: timestamp, authorship, commit description.
   Commit description is very important to have a good understanding of the repository and rationale for changes.
   Be sure to follow [best practices in creating commits and commit descriptions]((https://cbea.ms/git-commit/).

   A branch is a series of commits, called a **history of commits**.
   Each branch has its own commit history.

1. Show top commit contents:

   ```console
   git show
   git show HEAD
   ```

   The `HEAD` keyword is an alias for the latest (most recent) commit in the current branch.

1. Show commit contents by commit ID:

   ```console
   git show 1a02ae3
   ```

   Each commit is identified by a commit ID, typically a [SHA-1](https://en.wikipedia.org/wiki/SHA-1) hash of the commit contents.

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

   `git blame` shows the latest modification of each line in the file: latest commit ID, together with timestamp and author.

1. Show commits that modified a path:

   ```console
   git log scripts -- README.md
   git log scripts -- c-fs
   ```

1. Show difference between two commits / references:

   ```console
   git diff base scripts
   ```

   `git diff` shows lines that need to be added (`+`) or removed (`-`) in order to get from the first reference to the second one.

1. Show commit difference between two references:

   ```console
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

1. Show local Git configuration:

   ```
   git config -l
   git config user.name
   git config user.email
   ```

   Git uses configuration variables, such as `user.name` or `user.email` or `color.ui` to customize command effects, i.e. author being used, coloring, aliases, files to be ignored.

1. If not already configured, configure your name and e-mail:

   ```console
   git config --global user.name "<your-full-name-here>"
   git config --global user.email "<your-email-here>"
   ```

   Use your full name as you would typically do: `Firstname Lastname`.

1. Configure colored output:

   ```console
   git config --global color.ui "auto"
   ```

1. Configure aliases:

   ```console
   git config --global alias.lg 'log --pretty=fuller'
   git lg
   ```

   An **alias** is typically a short name for a common command, to make typing more efficient or to make it easier to remember.

1. Check the configuration:

   ```console
   cat .git/config
   cat ~/.gitconfig
   ```

   The `.git/config` is the local repository Git configuration file.
   The `~/.gitconfig` is the global Git configuration file.
   The `git config` command reads from and makes updates to these files.

## Clean Up / Reset Your Git Environment

We make mistakes:
- We create commits we shouldn't have (yet) created.
- We leave changes out of commits.
- We amend the wrong commit.
- We do merges / rebases / cherry-picks that fail.
- We add a change in the staging area that we shouldn't have (yet) added.
- We delete a file by mistake.

These things happen.
We solve them.
We just need to know how to do that.

1. First prepare a messed up environment, by running:

   ```console
   ./mess-it-up.sh
   ```

1. Now look at the mess:

   ```console
   git status
   ```

1. See the commit history:

   ```console
   git log
   ```

   See the `bla bla` commit (latest).
   And see the wrong message (`Bue` instead of `Bye`) for the other other commit.

1. **Note**: If, at any point in time, you miss a command, or something bad simply happened, reset the environment by running:

   ```console
   ./reset-all.sh
   ```

   The go back to step 1 and prepare the messed up environment again.

1. Let's first get rid of all the temporary files we do not require (they were added by mistake):

   ```console
   git clean -d -f
   git status
   ```

   `git clean` removes files that are not used (not tracked) in the repository.
   Files are **tracked** if there are commits with contents of those files.
   Files are **not tracked / untracked** if there are no commits related to those files.

   Untracked files appear, in the `git status` output, typically colored red, marked with `Untracked files:`.

1. Restore the deleted `Makefile`:

   ```console
   git status
   git restore c-hello/Makefile
   git status
   ```

   When you delete or modify a tracked file, its changes appear in the **"tracking" area**, typically colored red, marked with `Changes not staged for commit:`.
   You can restore changes to its original contents.

1. Restore the staged deleted `hello.c`:

   ```console
   git status
   git restore --staged c-hello/hello.c
   git status
   git restore c-hello/hello.c
   git status
   ```

   When you delete or modify a tracked file, and then you add changes (via `git add` or `git rm`), its changes appear in the **"staging" area**, typically colored green, marked with `Changes to be committed:`.
   You can get a file from the "staging" area to the "tracking" area via `git restore --staged`.
   You can then restore changes to its original contents, and remove the file from the "tracking" area, via `git restore`.

1. Restore the staged new file `c-bye/build.fc.x86_64` to create a proper commit:

   ```console
   git status
   git restore c-bye/build.fc.x86_64
   git status
   ```

1. See the commit history again:

   ```console
   git log
   ```

1. Remove the `bla bla` commit:

   ```console
   git reset HEAD^
   git status
   git log
   rm blabla.txt
   ```

   Adding a caret sign (`^`) after a commit reference points to the previous commit.
   `git reset` discards all commits after the argument reference.

1. Update the commit message from `Bue` to `Bye`:

   ```console
   git log
   git commit --amend    # do edit as required
   git log
   git show
   ```

   The `git commit --amend` command presents a commit description edit screen.
   After saving the changes and exiting the edit screen, the commit description (and its ID / SHA hash) are updated.

1. Create a new commit with the `c-bye/build.fc.x86_64` file:

   ```console
   git add c-bye/build.fc.x86_64
   git commit -s -m 'c-bye: Add Firecracker build script for x86_64'
   git log
   git show
   git status
   ```

### Do It Yourself

1. Repeat the above steps at least 2 more times.

   Aim to have one time without checking the instructions.
   That is, run the `./mess-it-up.sh` script and then repair the mess by yourself.

   If, at any point, you get lost, run the reset script:

   ```console
   ./reset-all.sh
   ```

1. Do your own messing up of the environment.
   Go to a given branch, remove files, create new files, create commits, add files to staging area etc.
   Then repair the environment.

   If, at any point, you get lost, run the reset script:

   ```console
   ./reset-all.sh
   ```

## Edit Commit History

Let's get to a situation where we need to repair the commit history.
We will have a setup where we have the following stack of commits:

- (top) correct commit
- (next) commit that shouldn't exist (`bla bla` commit)
- (next-next) commit with a typo (`Bue` instead of `Bye`)

We want to edit the commit history and:

- Remove the `bla bla` commit.
- Fix the typo.

1. Create the setup:

   ```console
   ./set-up-history-edit.sh
   git status
   git log
   ```

1. **Note**: If, at any point in time, you miss a command, or something bad simply happened, reset the environment by running:

   ```console
   ./reset-all.sh
   ```

   The go back to step 1 and prepare the messed up environment again.

1. Go into commit history editing mode:

   ```console
   git rebase -i HEAD~3
   ```

   The `rebase` command positions you somewhere else in the commit history.
   You can make updates to commits from that point onward.

   The `~N` construct is a reference to `N` commits before the current one.
   `HEAD~3` means 3 commits before the top commit.

   You get an editor screen with an output like this:

   ```text
   pick e5442f0 Add C Bue application
   pick 06eb1fa bla bla
   pick 74f3d3e c-bye: Add Firecracker build script for x86_64
   ```

1. Edit the rebase screen contents in order to edit the commit with the typo (`Bue` instead of `Bye`) and to drop the extra commit (the one with `bla bla`).
   Have the editor screen have the contents:

   ```
   edit e5442f0 Add C Bue application
   drop 06eb1fa bla bla
   pick 74f3d3e c-bye: Add Firecracker build script for x86_64
   ```

   That is, the first line (the bad commit message) should have `edit` instead of `pick` - we edit the commit.
   And the second line (the extra commit) should have `drop` instead of `pick` - we drop the commit.

   Save and exit the editor screen.

1. We are currently editing the typo commit:

   ```console
   git log
   git show
   ```

1. Update the commit message from `Bue` to `Bye`:

   ```console
   git log
   git commit --amend    # do edit as required
   git log
   git show
   ```

1. Continue the commit history editing:

   ```console
   git rebase --continue
   ```

   Each `git rebase --continue` command gets you to the next commit to update.

1. The extra commit has been dropped:

   ```console
   git log
   git status
   ```

1. The commit history editing (aka the rebase) is done:

   ```console
   git rebase --continue
   ```

   It says "No rebase in progress?", meaning the rebase is done.
   There are no more commits to update.

### Do It Yourself

1. Repeat the above steps at least 2 more times.

   Aim to have one time without checking the instructions.
   That is, run the `./set-up-history-edit.sh` script and then repair the commit history by yourself.

   If, at any point, you get lost, run the reset script:

   ```console
   ./reset-all.sh
   ```

1. Do your own commit history that you want to edit.
   Go to a given branch, create commits, create some bad or extra commits.
   Then repair the commit history.

   If, at any point, you get lost, run the reset script:

   ```console
   ./reset-all.sh
   ```

## Create Commits

We will get some new content that we will add as commits to the repository.
Make sure you are on the `main` branch and everything is clean:

```console
git checkout main
```

Or, reset the repository:

```console
./reset-all.sh
```

1. Create contents from archive:

   ```console
   unzip support/c-bye.zip
   git status
   ```

   We now have a `c-bye/` directory:

   ```console
   ls c-bye/
   ```

   There are a lot of files.
   We want to add them as 3 separate commits in 3 separate branches.

   1. The `bye.c`, `Makefile`, `Makefile.uk`, `fc...`, `xen...`, `README.md` files will go to the `base` branch.
   1. The `defconfig...`, `build...`, `run...`, `README.scripts.md` files will go to the `scripts` branch.
   1. The `test...` files will go to the `test` branch.

1. Go to the `c-bye/` directory:

   ```console
   cd c-bye/
   ls
   ```

### `base` branch

Let's create commit to `base` branch:

1. Check out the `base` branch:

   ```console
   git checkout base
   ```

1. Add contents to staged area:

   ```console
   git add bye.c Makefile Makefile.uk README.md xen.* fc.* .gitignore
   git status
   ```

1. Create the commit:

   ```console
   git commit -s -m 'Introduce C Bye on Unikraft'
   ```

1. List the commit:

   ```console
   git log
   git show
   ```

1. Look at the commit for the initial C Hello program:

   ```console
   git show 7fd6e9290dddc2ae799ae5df684668a7d16e87f3
   ```

   The commit message is:

   ```text
   Introduce C Hello on Unikraft

   Add `c-hello/` directory:

   - `hello.c`: the source code file
   - `Makefile.uk`: defining the source code files used
   - `Makefile`: for building the application
   - `fc.x86_64.json` / `fc.arm64.json`: Firecracker configuration
   - `xen.x86_64.cfg` / `xen.arm64.cfg`: Xen configuration
   - `README.md`: instructions
   - `.gitignore`: ignore generated files
   ```

   We want something similar for our C bye commit.

1. Update the commit message by amending:

   ```console
   git commit --amend
   ```

   You get an editable screen.
   Edit the commit message to have contents similar to the one for C Hello.
   Use copy & paste.

   You can use `git commit --amend` to constantly update the commit.

   See the final result with:

   ```console
   git log
   git show
   ```

### `scripts` branch

Let's create commit to `scripts` branch:

1. Check out the `scripts` branch:

   ```console
   git checkout scripts
   ```

1. Add contents to staged area:

   ```console
   git add defconfig.* build.* run.* README.scripts.md
   git status
   ```

1. Create the commit:

   ```console
   git commit -s -m 'c-bye: Add scripts'
   ```

1. List the commit:

   ```console
   git log
   git show
   ```

1. Look at the commit for the initial C Hello program:

   ```console
   git show 04cf0f57f2853d73a5c25082d4652fef63da8f57
   ```

   The commit message is:

   ```text
   c-hello: Add scripts

   Use scripts as quick actions for building and running C Hello on Unikraft.

    - `defconfig.<plat>.<arch>`: default configs, used by build scripts
    - `build.<plat>.<arch>`: scripts for building Unikraft images
    - `run.<plat>.<arch>`: scripts for running Unikraft images
    - `README.script.md`: companion README with instructions
   ```

   We want something similar for our C bye commit.

1. Update the commit message by amending:

   ```console
   git commit --amend
   ```

   You get an editable screen.
   Edit the commit message to have contents similar to the one for C Hello.
   Use copy & paste.

   You can use `git commit --amend` to constantly update the commit.

   See the final result with:

   ```console
   git log
   git show
   ```

### `test` branch

Let's create commit to `test` branch:

1. Check out the `test` branch:

   ```console
   git checkout test
   ```

1. Add contents to staged area:

   ```console
   git add test*
   git status
   ```

1. Create the commit:

   ```console
   git commit -s -m 'c-bye: Add test scripts'
   ```

1. List the commit:

   ```console
   git log
   git show
   ```

### Do It Yourself

1. Reset the configuration:

   ```console
   ./reset-all.sh
   ```

1. Repeat the above steps at least 2 more times.

   Aim to have one time without checking the instructions.
   That is, create the 3 commits in the 3 branches for C bye.

   If, at any point, you get lost, run the reset script:

   ```console
   ./reset-all.sh
   ```

1. Do the same for the C++ Bye program.

   Make sure you are on the `main` branch:

   ```console
   git status
   git checkout main
   ```

   First unpack the contents:

   ```console
   unzip support/cpp-bye.zip
   git status
   ```

   We now have a `cpp-bye/` directory:

   ```console
   ls cpp-bye/
   ```

   There are a lot of files.
   We want to add them as 3 separate commits in 3 separate branches.

   1. The `bye.cpp`, `Makefile`, `Makefile.uk`, `Config.uk`, `fc...`, `xen...`, `README.md` files will go to the `base` branch.
   1. The `defconfig...`, `build...`, `run...`, `README.scripts.md` files will go to the `scripts` branch.
   1. The `test...` files will go to the `test` branch.

   Follow the steps for C Bye to create the commits for C++ Bye.

1. Do the same for the Python Bye program.

   Make sure you are on the `main` branch:

   ```console
   git status
   git checkout main
   ```

   First unpack the contents:

   ```console
   unzip support/python3-bye.zip
   git status
   ```

   We now have a `python3-bye/` directory:

   ```console
   ls python3-bye/
   ```

   There are a lot of files.
   We want to add them as 3 separate commits in 3 separate branches.

   1. The `bye.py`, `Makefile`, `Makefile.uk`, `Config.uk`, `fc...`, `xen...`, `README.md` files will go to the `base` branch.
   1. The `defconfig...`, `build...`, `run...`, `README.scripts.md` files will go to the `scripts` branch.
   1. The `test...` files will go to the `test` branch.

   Follow the steps for C bye to create the commits for Python3 Bye.

## Create Commit History

At this point there are commits in the `base` branch that are not part of the `scripts` branch.
And there are commits in the `scripts` branch that are not part of the `test` branch.

We aim to have the `scripts` branch built on top of the `base` branch.
And we want to have the `test` branch built on top of the `scripts` branch.

For this, all commits from the `base` branch will have to be on the `scripts` branch.
And all commits from the `scripts` branch will have to be on the `test` branch.

1. To get the `c-bye` commit from the `base` branch to the `scripts` branch, first check out the `scripts` branch:

   ```console
   git checkout scripts
   ```

1. Find out the commit ID in the `base` branch:

   ```console
   git log base
   ```

   Scroll the commit history and copy the commit ID belonging to the `c-bye` program.
   That is, the ID of the commit you created earlier with the message: `Introduce C Bye on Unikraft`.

1. Use the commit ID cherry pick the commit from the `base` branch to the `scripts` branch:

   ```console
   git cherry-pick <commit-id>
   ```

   Replace `<commit-id>` with the commit ID you copied above (copy & paste).

1. Check the updated history of the `scripts` branch:

   ```console
   git log
   ```

1. To get the `c-bye` commits from the `scripts` branch to the `test` branch, first check out the `test` branch:

   ```console
   git checkout test
   ```

1. First cherry pick the `base` commit that is now on `scripts`:

   ```console
   git cherry-pick <commit-id>
   ```

   This is the same commit ID from above.

   **Cherry-picking** is selecting a commit, or series of commits and adding them on top of the current setup.

1. Now let's get the `c-bye` commit from the `scripts` branch.
   Find out the commit ID in the `scripts` branch:

   ```console
   git log scripts
   ```

   Scroll the commit history and copy the commit ID belonging to the `c-bye` program.
   That is, the ID of the commit you created earlier with the message: `c-hello: Add scripts`.

1. Use the commit ID cherry pick the commit from the `scripts` branch to the `test` branch:

   ```console
   git cherry-pick <new-commit-id>
   ```

   Replace `<new-commit-id>` with the commit ID you copied above (copy & paste).

1. Check the updated history of the `scripts` branch:

   ```console
   git log
   ```

> [!NOTE]
> If, at any point, you did something wrong, recall that you can drop the top commit by doing:
>
> ```console
> git reset --hard HEAD^
> ```

### Do It Yourself

1. Repeat the above steps at least 2 more times.

   Aim to have one time without checking the instructions.
   That is, have the `scripts` based on the `base` branch, and have the `test` branch based on the `scripts` branch.

   For starters, drop the newly cherry-picked commit from the `scripts` branch:

   ```console
   git checkout scripts
   git reset --hard HEAD^
   ```

   And drop the newly cherry-picked commits from the `test` branch:

   ```console
   git checkout test
   git reset --hard HEAD^^
   ```

   Now repeat the steps above.

1. Do the same steps for the C++ Bye program.
   That is, have the `scripts` based on the `base` branch, and have the `test` branch based on the `scripts` branch.

1. Do the same steps for the Python Bye program.
   That is, have the `scripts` based on the `base` branch, and have the `test` branch based on the `scripts` branch.

## Update Commit History

At this point, the `scripts` branch is based on the `base` branch.
And the `test` branch is based on the `scripts` branch.

What we do not like, however, is that the commits in the `scripts` and the `test` branch are not in the correct order.

In the `scripts` branch the commits are (top-to-bottom):

- python3-bye: Add scripts
- Introduce Python3 Bye
- cpp-bye: Add scripts
- Introduce C++ Bye
- c-bye: Add scripts
- Introduce C Bye
- python3-bye: Add test scripts
- cpp-bye: Add test scripts
- c-bye: Add test scripts

Use `git log` to confirm this:

```console
git log
git log --oneline
```

The order we want is (top-to-bottom):

- python3-bye: Add test scripts
- python3-bye: Add scripts
- Introduce Python3 Bye
- cpp-bye: Add test scripts
- cpp-bye: Add scripts
- Introduce C++ Bye
- c-bye: Add scripts
- Introduce C Bye
- c-bye: Add test scripts

So, to update the commit history, follow the steps below:

1. Enter the history update mode.
   Update the last `9` commits:

   ```console
   git rebase -i HEAD~9
   ```

   You are now in a custom editor mode where you can update the commits.

1. Move the commits (cut & paste) to get to the new commit history.
   Do this by cutting and pasting the lines in the commit history.

1. Save the custom editor mode.

You're done.
Check the new commit history with:

```console
git log
git log --oneline
```

### Do It Yourself

Edit the commit history on the `test` branch are in the correct order, the same they are now on the `scripts` branch.
