# aliases
alias work="cd ~/go/src/github.com/rippling"
alias notes="cd ~/notes"
alias cls="clear"
alias play="cd ~/go/src/github.com/blaze2305/playground"
alias cleanup='git branch | grep -vE "(main|master)" | xargs -I{} git branch -D {}'
# adding this alias because a lot of tools open VSCode and I want to redirect that to helix
alias code="hx"
alias tffmt='terraform fmt -recursive && linelint -a'

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# asdf and asdf completions
#
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# yazi function to change dir while moving through it
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias y="yazi"

# open the diff between current commit and master in chrome/firefox etc
function commit-diff(){
	git_url=$(git ls-remote --get-url origin)
	head_branch=$(git rev-parse --abbrev-ref HEAD)
	curr_commit=$(git rev-parse --short HEAD)

	github_url=$(sed -r 's/\.git//' <<< $git_url)

	echo $github_url

	url=${github_url}/compare/${curr_commit}...${head_branch}

	open $url
}

# zsh autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship.rs
eval "$(starship init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

eval "$(direnv hook zsh)"

# CDE CLI zsh configuration
source /Users/pranav/.cde/.venv/lib/python3.11/site-packages/cde_cli/cde_cli_sh_rc.sh


