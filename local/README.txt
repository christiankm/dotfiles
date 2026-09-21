This folder contains files, keys, scripts and any other resources specific
to the current local machine.

Use this folder to store SSH keys, shell files, and anything else which you can
source from your .zshrc (or similar config). All content inside this local
folder are ignored from git and should never be committed into the repository.

A few special things apply which are automatically sourced or linked if exists:

- Anything added to local/ssh/ is linked to ~/.ssh/
- If `local.sh` exists, it will be sourced in .zshrc. This file
  can be used to source any other local files or resources required, set
  secrets, environment variables, etc, specific to this local machine
- If `ansible-vars.yml` exists, it is loaded by the Homebrew and Mac App
  Store playbooks. Use it to list packages, casks and mas apps that should
  only be installed on this machine (see homebrew_local_packages,
  homebrew_local_cask_apps and homebrew_local_mas_apps in that file)
