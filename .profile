# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

EDITOR=vim

# if running bash
if [ -n "${BASH_VERSION}" ]; then
  # include .bashrc if it exists
  if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
  fi
fi

# setexport PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
 export PATH="${HOME}/bin:${PATH}"
fi

# setexport PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] ; then
 export PATH="${HOME}/.local/bin:${PATH}"
fi

# Crosstool-ng
if [ -d "${HOME}/ctng/bin" ] ; then
 export PATH="${HOME}/ctng/bin:${PATH}"
fi

# Setup ccache
if [ -d "/usr/lib/ccache" ]; then
   export PATH="/usr/lib/ccache:${PATH}"
fi

# Setup gpg-agent to support ssh
eval $(gpg-connect-agent --quiet /bye)
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# vim: ts=2:sw=2:et:ai
