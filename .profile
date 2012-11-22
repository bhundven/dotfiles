# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

OPENEMBEDDED_ENABLED=true

EDITOR=vim

# if running bash
if [ -n "${BASH_VERSION}" ]; then
  # include .bashrc if it exists
  if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

if [ -d "${HOME}/ctng/bin" ] ; then
  PATH="${HOME}/ctng/bin:${PATH}"
fi

if [ -d "${HOME}/android-sdk-linux_x86/tools" -a -d "${HOME}/android-sdk-linux_x86/platform-tools" ] ; then
  PATH="${HOME}/android-sdk-linux_x86/tools:${HOME}/android-sdk-linux_x86/platform-tools:${PATH}"
fi

if [ -d "/usr/lib/ccache" ]; then
  PATH="/usr/lib/ccache:$PATH"
  [ ! -d "${HOME}/.ccache" ] && mkdir -p "${HOME}/.ccache"
  export CCACHE_DIR=${HOME}/.ccache
  ccache -M10G
fi

keychain id_rsa
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] &&
  . $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] &&
  . $HOME/.keychain/$HOSTNAME-sh-gpg

# vim: ts=2 sw=2 et ai
