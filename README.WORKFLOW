SLACKBUILDS WORKFLOW

This repository is a fork of SlackBuilds.org. The master branch follows the
upstream tree and is used for contributions that may be submitted upstream.

The current-overlay branch is a personal Slackware-current collection. It
contains only packages used on the local machine that are not maintained by
the owner, require local customizations, or are not suitable for submission
to SlackBuilds.org. Examples include local config.h files for suckless
projects and package-specific patches.


REPOSITORY MODEL

- upstream/master
  Canonical SlackBuilds.org history (read-only).

- master
  Local fork of the complete SlackBuilds.org tree.
  Synced from upstream via merge commits.
  Used as the base for upstream contribution branches.

- add/*, update/*
  Temporary branches for upstream contributions.
  Always created from upstream/master.
  Deleted after merge.

- current-overlay
  Orphan branch containing only personal Slackware-current packages and
  customizations. It is not submitted upstream.


WHEN TO USE CURRENT-OVERLAY

A package belongs in current-overlay if it is:

- Slackware-current specific
- Required only for local systems
- Opinionated or policy-driven
- Rejected or not desired upstream
- Experimental or long-term customization

current-overlay is intentional local divergence.


WORKING WITH CURRENT-OVERLAY

Personal current-overlay work is kept out of master.

1. Switch to master for upstream synchronization:

   git checkout master

2. Sync with upstream (never reset):

   git fetch upstream
   git merge upstream/master

3. Create a temporary branch from upstream/master for an upstream change:

   git checkout -b update/pkgname-version upstream/master

4. Test the SlackBuild locally.

5. Push the contribution branch to your fork:

   git push origin update/pkgname-version

Local-only changes belong in current-overlay and must never be submitted
upstream.


UPSTREAM CONTRIBUTIONS

Pull requests must always start from upstream/master.

Updating an existing package:

  git fetch upstream
  git checkout -b update/pkgname-version upstream/master
  git commit -am "category/pkgname: short description"
  git push origin update/pkgname-version

Commit messages for upstream submissions must use the format:

  category/pkgname: short description

Example:

  system/TLP: update to 1.9.1

Branch names may follow the local convention:

  update/pkgname-version

Branch names are disposable and local-only; commit messages must follow
upstream style.


CI TESTING (OPTIONAL)

For contributors with CI access, builds can be triggered after opening a
pull request by adding a PR comment:

  @sbo-bot: build category/pkgname

Example:

  @sbo-bot: build system/xbattmon

This must be posted as a PR comment, not in the commit message or PR
description.


AFTER UPSTREAM MERGE

SlackBuilds.org may merge pull requests directly, cherry-pick commits,
or apply changes manually. In all cases, upstream/master is the source
of truth.

Once changes have been merged or applied upstream, the local fork must
be resynchronized and temporary branches cleaned up.

Update local master from upstream:

  git checkout master
  git fetch upstream
  git merge upstream/master
  git push origin master

Accept the default merge commit message.

Verify that the changes are present upstream, either by inspecting the
SlackBuilds.org repository or by checking the local tree after the merge.

Temporary add/* and update/* branches are disposable and should be
removed once upstream has applied the changes.

Local cleanup:

  git branch -D update/pkgname-version

Force deletion is expected here, as upstream may apply changes without
creating a merge commit.

Remote cleanup (optional):

  git push origin --delete update/pkgname-version


SAFETY RULES

Master is the upstream fork and current-overlay is a separate personal branch:

- never rebase master
- never hard-reset master
- never force-push master
- never fast-forward merge upstream
- never branch from current-overlay for PRs

- never delete current-overlay with cleanup-branches.workflow

Only add/* and update/* branches may be used for upstream work.


VALIDATION

To review the fork against upstream:

  git diff upstream/master..master --stat

The current-overlay branch is intentionally separate and contains only local
packages and customizations.


PHILOSOPHY

Upstream stays clean.
Local systems stay functional.
Processes are respected.
Workflow stays boring.

current-overlay is where local reality lives.
upstream/master is the source of truth.
