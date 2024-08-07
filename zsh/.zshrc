# ~/.zshrc

echo && fastfetch && echo

update_ps1() {
    local git_status
    local git_branch

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_status=$(git status --porcelain 2>/dev/null)

        if [[ -n $(echo "$git_status" | grep -E '^\s*[MADRCU]') ]]; then
            # Uncommitted changes
            git_branch=$(__git_ps1 " (%s)")
            PS1='%F{117}%n%F{white}@%F{117}%m %F{226}%~%F{196}'"$git_branch"'%f$ '
        elif [[ -n $(echo "$git_status" | grep '^?? ') ]]; then
            # Untracked files
            git_branch=$(__git_ps1 " (%s)")
            PS1='%F{117}%n%F{white}@%F{117}%m %F{226}%~%F{213}'"$git_branch"'%f$ '
        else
            # Up to date
            git_branch=$(__git_ps1 " (%s)")
            PS1='%F{117}%n%F{white}@%F{117}%m %F{226}%~%F{46}'"$git_branch"'%f$ '
        fi
    else
        # Not inside a Git repository
        PS1='%F{117}%n%F{white}@%F{117}%m %F{226}%~%f$ '
    fi
}

precmd_functions+=(update_ps1)

alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias v='nvim'
alias aur='yay -S --noconfirm --noanswerclean --noanswerdiff'
alias ll='exa -alF'
alias la='exa -A'
alias ls='exa'
alias g='git'
alias gs='git status'
alias mirrorupdate='sudo reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu'

cd() { builtin cd "$@" && exa -A; }

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/git/completion/git-prompt.sh

eval "$(zoxide init zsh)"

export EDITOR=vim
export VISUAL=vim
