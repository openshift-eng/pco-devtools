#!/usr/bin/env bash
export PCO_BASE_DIR=~/dev
export PCO_REPO_DIR="${PCO_BASE_DIR}/repos"
export PCO_VENV_DIR="${PCO_BASE_DIR}/venvs"

if [[ "$(uname)" == "Linux" ]]; then
  # Linux-specific customizations
  export REQUESTS_CA_BUNDLE="${REQUESTS_CA_BUNDLE:-/etc/pki/tls/certs/ca-bundle.crt}"

elif [[ "$(uname)" == "Darwin" ]]; then
  # MacOS-specific customizations
  # Allows the installed GNU findutils (gfind, gxargs, glocate) to be used with their regular names (find, xargs, ...)
  _gnubin_path="$(brew --prefix findutils)/libexec/gnubin"
  [[ ":${PATH:-}:" != *":${_gnubin_path}:"* ]] && export PATH="${_gnubin_path}:${PATH:-}"
  unset _gnubin_path
fi

# This lets gpg-agent work correctly within tmux
# shellcheck disable=SC2155
export GPG_TTY="$(tty)"

# Disable Bash autocomplete on files/dirs with these extensions
export FIGNORE=".o:__pycache__:.pyc"
