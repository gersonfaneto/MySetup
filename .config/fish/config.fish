#--------------------------------------------------------------------------------#
#                               Basic Configs                                    #
#--------------------------------------------------------------------------------#

# Remove the default 'fish' greeting.
set fish_greeting ""

# Set default color support and editor.
set -gx TERM xterm-256color
set -gx EDITOR nvim

# General Aliases.
alias ex exit
alias cl clear
alias cp "cp -i"
alias mv "mv -i"
alias rm "rm -i"
alias sr "sudo reboot -h now"
alias sp "sudo poweroff"
alias refresh "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"

#--------------------------------------------------------------------------------#
#                               Especial Aliases                                 #
#--------------------------------------------------------------------------------#

# Use 'exa' instead of 'ls'
if type -q exa
  alias ls "exa --icons"
  alias ll "exa --icons --long --header --group-directories-first"
  alias lla "exa --icons --long --all --header --group-directories-first"
  alias tree "exa --icons --tree --level=6 --only-dirs"
end

# Quickly manipulate 'TMUX' sessions
if type -q tmux
  alias tl "tmux list-sessions"
  alias ta "tmux attach-session"
  alias tn "tmux new-session -s (basename (pwd)) -d"
  alias tk "tmux kill-session"
end

# Quickly summon 'neofetch'
if type -q neofetch
  alias nf "neofetch"
end

# Quickly summon 'git' and use 'config' as an alias for the 'MySetup' repository.
if type -q git
  alias g git
  alias config "/usr/bin/git --git-dir=$HOME/Developer/GitHub/Personal/MySetup \
    --work-tree=$HOME/"
end

# Use 'bat' as a substitute for 'cat'.
if type -q batcat
  alias bat "batcat --theme=TwoDark"
end

# Quickly summon 'neovim' (Default editor)
if type -q nvim
  alias v nvim
end

#--------------------------------------------------------------------------------#
#                               Version Manager                                  #
#--------------------------------------------------------------------------------#

# 'ASDF': Multiple runtime and language version manager
if test -d ~/.asdf
  source ~/.asdf/asdf.fish
end

#--------------------------------------------------------------------------------#
#                                 Path Updates                                   #
#--------------------------------------------------------------------------------#

# Add '~/.local/bin' to the $PATH
if test -d "$HOME/.local/bin/"
  export PATH="$PATH:$HOME/.local/bin/"
end

#--------------------------------------------------------------------------------#
#                                 Common Tools                                   #
#--------------------------------------------------------------------------------#

# 'FZF': Fuzzy file finder. Enable preview using 'batcat' and change default styling.
if type -q fzf
  export FZF_DEFAULT_OPTS="--layout=reverse --height=50% --border=rounded \
  --prompt='Search: ' --info=inline --multi --tabstop=2 --color=dark --preview='bat \
  --theme=TwoDark --style=numbers --color=always --line-range :500 {}'"
end

# 'Batcat': Use it as the pager for 'man'.
if type -q batcat
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
end

# 'Starship': Prompt theme
if type -q starship
  starship init fish | source
end

#--------------------------------------------------------------------------------#
#                                  On Startup                                    #
#--------------------------------------------------------------------------------#

# Automatically create the 'Home' session on 'TMUX'.
if status is-interactive  
  and not set -q TMUX
    if not tmux has-session -t Home 2>/dev/null
      tmux new-session -s Home -d 2>/dev/null
    end
end

#--------------------------------------------------------------------------------#
#                                  Functions                                     #
#--------------------------------------------------------------------------------#

function hop -d "Create a new directory and set it as the CWD"
  command mkdir $argv
    if test $status = 0
        switch $argv[(count $argv)]
          case '-*'
          case '*'
            cd $argv[(count $argv)]
            return
        end
    end
end


function todo -d "Display the contents of a TODO.md list on ~/Desktop"
  if test -f ~/Desktop/TODO.md
    and type -q glow
    command glow ~/Desktop/TODO.md
  end
end

