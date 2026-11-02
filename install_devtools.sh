#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
INSTALL_DEVTOOLS_HERE="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "${INSTALL_DEVTOOLS_HERE}/check_bash_version.sh"


function ensure_git_credential_helper_installed() {
  if git config get --global credential.helper 2>&1 >/dev/null ; then
    echo "Skipping: Git credential helper already configured."
    return 0
  fi

  echo "Ensuring Git credential helper is activated."
  git config set --global credential.helper store
}


function ensure_secrets_dir_exists() {
  if [[ -d ~/.secrets ]]; then
    echo "Skipping: ~/.secrets already exists."

  else
    echo "Creating ~/.secrets"
    mkdir ~/.secrets
  fi
}


function install_devtools() {
  source "${INSTALL_DEVTOOLS_HERE}/install_packages.sh"
  ensure_git_credential_helper_installed
  ensure_secrets_dir_exists
}


install_devtools
