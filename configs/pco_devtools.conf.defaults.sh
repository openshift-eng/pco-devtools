#!/usr/bin/env bash
export PCO_BASE_DIR=~/dev
export PCO_REPO_DIR="${PCO_BASE_DIR}/repos"
export PCO_VENV_DIR="${PCO_BASE_DIR}/venvs"

if [[ "$(uname)" == "Linux" ]]; then
  # Linux-specific customizations
  if [[ -z "${VIRTUAL_ENV}" ]] ; then
    # try to get out of the virtual env
    deactivate || source deactivate || :
  fi
  if [[ "${PATH}" =~ "pyenv" ]] ; then
    # try to switch to the system-managed python version when `pyenv` is installed; fail silently if `pyenv` isn't
    # installed.
    pyenv shell system || :
  fi
  # Extract the system python's default CA bundle path to set REQUESTS_CA_BUNDLE; this way, virtualenvs will pick up
  # the correct location.
  REQUESTS_CA_BUNDLE="$(python -c 'from requests.utils import DEFAULT_CA_BUNDLE_PATH; print(DEFAULT_CA_BUNDLE_PATH)')"
  # Make sure the extracted bundle path is under `/etc`
  if [[ "${REQUESTS_CA_BUNDLE}" =~ ^/etc ]]
    export REQUESTS_CA_BUNDLE
  fi
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
