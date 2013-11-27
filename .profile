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

# Crosstool-ng
if [ -d "${HOME}/ctng/bin" ] ; then
  PATH="${HOME}/ctng/bin:${PATH}"
fi

# Android SDK
if [ -d "/opt/android-sdk/sdk/tools" -a -d "/opt/android-sdk/sdk/platform-tools" ] ; then
  PATH="/opt/android-sdk/sdk/tools:/opt/android-sdk/sdk/platform-tools:${PATH}"
fi

# Eclipse
if [ -d "/opt/eclipse" ]; then
  PATH="/opt/eclipse:$PATH"
fi

# Android-Studio
if [ -d "/opt/android-studio/bin" ]; then
  PATH="/opt/android-studio/bin:$PATH"
fi

# ssh/gpg keychain
keychain -q id_rsa
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] &&
  . $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] &&
  . $HOME/.keychain/$HOSTNAME-sh-gpg

# vim: ts=2 sw=2 et ai
