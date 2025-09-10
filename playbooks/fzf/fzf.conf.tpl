PATH=$PATH:{{ fzf_sourcecode_dir }}/bin
eval "$(fzf --bash)"
source {{ fzf_extensions_dir}}/fzf-git/fzf-git.sh

export FZF_DEFAULT_OPTS="--height=40% \
 --layout=reverse \
 --info=inline \
 --border \
 --preview='batcat --color=always {1}' \
 --preview-window=right,60%,border-left \
 --bind=ctrl-k:preview-up,ctrl-j:preview-down,ctrl-h:preview-half-page-up,ctrl-l:preview-half-page-down" 

alias rfv='{{ fzf_extensions_dir}}/fzf_ripgrep_interactive.sh'