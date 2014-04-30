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

# Android-Studio is a .app, so skip this path!
if [ "$(uname)" != "Darwin" ]; then
  # Android-Studio
  if [ -d "/opt/android-studio/bin" ]; then
    PATH="/opt/android-studio/bin:$PATH"
  fi
fi

# No need to run keychain on Mac OS X.
# I normally use the normal built-in "Keychain Access" stuff.
if [ "$(uname)" != "Darwin" ]; then
  # ssh/gpg keychain
  keychain -q id_rsa
  [ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
  [ -f $HOME/.keychain/$HOSTNAME-sh ] &&
    . $HOME/.keychain/$HOSTNAME-sh
  [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] &&
    . $HOME/.keychain/$HOSTNAME-sh-gpg
fi

# Setup ccache
if [ "$(which ccache)" != "" ]; then
  # Default GCC is now ccache
  if [ -d "/usr/lib/ccache" ]; then
    PATH="/usr/lib/ccache:${PATH}"
  elif [ -d "/usr/local/opt/ccache/libexec" ]; then
    # we're on Mac OS X with HomeBrew
    PATH="/usr/local/opt/ccache/libexec:${PATH}"
  fi
  # ccache dir
  export CCACHE_DIR="${HOME}/.ccache"
  # Don't set a BASEDIR on MAC OS X
  if [ "$(uname)" != "Darwin" ]; then
    # only builds in /build will be cached
    export CCACHE_BASEDIR="/build"
  fi
  # For Android
  export USE_CCACHE=1
fi

# vim: ts=2 sw=2 et ai
