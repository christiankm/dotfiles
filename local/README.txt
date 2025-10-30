This folder contains files, keys, scripts and any other resources specific
to the current local machine. Use this

Use this folder to store SSH keys, shell files, and anything else which you can
source from your .zshrc (or similar config). All content inside this local
folder are ignored from git and should never be committed into the repository.

A few special things apply which are automatically sourced or linked if exists:

- Anything added to local/ssh/ is linked to ~/.ssh/
- If `local.sh` exists, it will be sourced in .zshrc. This file
  can be used to source any other local files or resources required, set
  secrets, environment variables, etc, specific to this local machine
