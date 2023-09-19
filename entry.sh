#!/bin/sh

# Detect the user's shell and execute xgraph accordingly
SHELL_TYPE="$(basename "$SHELL")"

case "$SHELL_TYPE" in
  "bash")
    xgraph
    ;;
  "zsh")
    xgraph
    ;;
  *)
    echo "Unsupported shell: $SHELL_TYPE"
    ;;
esac
