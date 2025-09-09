PATH=$PATH:{{ fzf_sourcecode_dir }}/bin
eval "$(fzf --bash)"
source {{ fzf_extensions_dir}}/fzf-git/fzf-git.sh
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border" 
alias rfv='{{ fzf_extensions_dir}}/fzf_ripgrep_interactive.sh'