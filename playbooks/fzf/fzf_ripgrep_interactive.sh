#!/usr/bin/env bash

# 1. Search for text in files using Ripgrep
# 2. Interactively restart Ripgrep with reload action
# 3. Open the file in Vim (commented)
# see https://github.com/junegunn/fzf/blob/master/ADVANCED.md#using-fzf-as-interactive-ripgrep-launcher
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
PREVIEW_KEY_BINDINGS="ctrl-k:preview-up,ctrl-j:preview-down,ctrl-h:preview-half-page-up,ctrl-l:preview-half-page-down"
# last options in preview-window param respond for centering preview on mathing string
INITIAL_QUERY="${*:-}"
fzf --ansi \
    --disabled \
    --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true,$PREVIEW_KEY_BINDINGS" \
    --delimiter : \
    --preview-window 'right,60%,border-left,+{2}+3/3,~3' \
    --preview 'batcat --color=always {1} --highlight-line {2}' 