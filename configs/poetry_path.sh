#!/usr/bin/env bash
# Add poetry to the CLI path
_local_bin="${HOME}/.local/bin"
if [[ ":${PATH}:" != *":${_local_bin}:"* ]] ; then
  export PATH="${_local_bin}:${PATH}"
fi
