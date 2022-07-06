# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/nhattan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# Zsh auto-suggestion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
(cat ~/.cache/wal/sequences &)

# nvm                                                                       
export NVM_DIR="$HOME/.nvm"                                                 
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion 

# Pywal
# reset
# wal -Rnq

# ANTLR4
export ANTLR_JAR="/home/nhattan/.local/lib/antlr-4.9-complete.jar"                    
#alias antlr4='java -Xmx500M -cp "/home/nhattan/.local/lib/antlr-4.9-complete.jar:$ANTLR_JAR" org.antlr.v4.Tool'                                                    
#alias grun='java -Xmx500M -cp "/home/nhattan/.local/lib/antlr-4.9-complete.jar:$ANTLR_JAR" org.antlr.v4.gui.TestRig'                                               
export CLASSPATH=".:/home/nhattan/.local/lib/antlr-4.9-complete.jar":$CLASSPATH
alias antlr4='java -jar /usr/local/lib/antlr-4.9-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'

# Flutter                                                                   
export PATH="$PATH:/usr/local/lib/flutter/bin"
# Dart pub
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Cargo
export PATH="$PATH:/home/nhattan/.cargo/bin"

# Python 3
alias python='/usr/bin/python3'

# pipes
alias pipes='pipes.sh'

# Gotop
alias gotop='~/.local/bin/gotop'

# Polybar-launch
alias polybar-launch='~/.config/polybar/launch.sh'

# Layout manager
alias layout_manager='~/.config/i3/layout_manager.sh'

# Jetbrains
# Android Studio
alias android_studio='/home/nhattan/.local/share/JetBrains/Toolbox/apps/AndroidStudio/ch-0/203.7935034/bin/studio.sh'
# Android Sdk
export PATH="$PATH:/home/nhattan/Android/Sdk"
# Android Studio Emulator
export PATH="$PATH:/home/nhattan/Android/Sdk/emulator"
# Android Debug Bridge
export PATH="$PATH:/home/nhattan/Android/Sdk/platform-tools"
# DataGrip
alias datagrip='/home/nhattan/.local/share/JetBrains/Toolbox/apps/datagrip/ch-0/213.5744.178/bin/datagrip.sh'

# nvim 
alias vim='nvim'
alias nvim-config='nvim ~/.config/nvim/init.vim'

# postman
alias postman='flatpak run com.getpostman.Postman'

# insomnia
alias insomnia='flatpak run rest.insomnia.Insomnia'

# only office
alias onlyoffice='flatpak run org.onlyoffice.desktopeditors'

# matrix
alias matrix='reset && cmatrix'

# cbonsai on dashboard
alias bonsai='cbonsai -li -L 19'

# tty-clock on dashboard
alias clock='tty-clock -cD'

# ncmpcpp
alias ncmpcpp='/usr/local/bin/ncmpcpp'

# Node-oracle
export LD_LIBRARY_PATH="/opt/oracle/instantclient_21_5:$LD_LIBRARY_PATH"


